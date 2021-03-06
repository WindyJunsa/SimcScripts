require "open3"
require "etc"
require_relative "JSONResults"
require_relative "Logging"
require_relative "SimcConfig"
require_relative "ProfileHelper"

module SimcHelper
  # Convert string into simc name, e.g. "Fortune's Strike" -> "fortunes_strike"
  def self.TokenizeName(name)
    return name.downcase.gsub(/[^0-9a-z_+.% ]/i, "").gsub(" ", "_")
  end

  # Evaluate number of threads to use for Sim
  def self.NumThreads
    begin
      if SimcConfig["Threads"].kind_of?(String)
        max = Etc.nprocessors
        threads = eval(SimcConfig["Threads"])
        return 1 if threads < 1
        return threads
      else
        return SimcConfig["Threads"]
      end
    rescue
      return 1
    end
  end

  # Append a simc file to a filestream, used for generating the full simc input file.
  def self.WriteFileToInput(filename, out)
    out.puts
    out.puts("# --- #{filename} ---")
    out.puts(File.read(filename))
    out.puts("# --- End of File ---")
    out.puts
  end

  # Run a simulation with all args applied in order
  def self.RunSimulation(args, simulationFilename = "LastInput", extraOverridesFile = nil)
    simulationFilename = ProfileHelper.NormalizeProfileName(simulationFilename)

    logFile = "#{SimcConfig["LogsFolder"]}/simc/#{simulationFilename}"
    if SimcConfig["AbortOnExistingReport"] && File.exists?("#{logFile}.json")
      Logging.LogScriptInfo "Logfile already exists, aborting simulation!"
      exit
    end

    generatedFile = "#{SimcConfig["GeneratedFolder"]}/#{simulationFilename}.simc"
    Logging.LogScriptInfo "Writing full SimC Input to #{generatedFile}..."
    File.open(generatedFile, "w") do |input|
      input.puts "### SimcScripts Full Input, generated #{Time.now}"
      input.puts

      # Special input via script config
      input.puts "threads=#{NumThreads()}"
      input.puts "$(simc_profiles_path)=\"#{SimcConfig["SimcPath"]}/profiles\""

      # Logs
      if SimcConfig["SaveSimcTextLogs"]
        input.puts "output=#{logFile}.log"
      else
        if Gem.win_platform?
          input.puts "output=nul"
        else
          input.puts "output=/dev/null"
        end
      end
      input.puts "json=#{logFile}.json"

      # Use global simc config file
      WriteFileToInput("#{SimcConfig["ConfigFolder"]}/SimcGlobalConfig.simc", input)

      args.flatten.each do |arg|
        if arg.end_with?(".simc")
          # Input File
          WriteFileToInput(arg, input)
        else
          input.puts arg
        end
      end

      if extraOverridesFile
        WriteFileToInput(extraOverridesFile, input)
      end
    end

    # Call executable with full input file
    Logging.LogScriptInfo "Invoking simc, this may take a while!"
    command = ["#{SimcConfig["SimcPath"]}/simc", generatedFile]

    # Run simulation with logging and redirecting output to the terminal
    Open3.popen3(*command) do |stdin, stdout, stderr, thread|
      # stdout
      if SimcConfig["SaveSimcStdout"]
        Thread.new do
          begin
            while (result = stdout.readpartial(4096))
              Logging.LogSimcInfo(result)
            end
          rescue EOFError, IOError
          end
        end
      else
        IO.copy_stream(stdout, $stdout)
      end
      # stderr
      if SimcConfig["SaveSimcStderr"]
        Thread.new do
          begin
            while (result = stderr.readpartial(4096))
              Logging.LogSimcError(result)
            end
          rescue EOFError, IOError
          end
        end
      else
        IO.copy_stream(stderr, $stderr)
      end
      thread.join # Wait for simc process to end
    end
  end

  # Run a smart simulation with multiple stages of smaller target error.
  # Wrapper for RunSimulation. This eliminates all results below a certain threshold for following stages.
  # Assumes sims are run with and only eliminates input using profilesets.
  # Config options are in the main config file.
  def self.RunMultiStageSimulation(args, simulationFilename = "LastInput")
    Logging.LogScriptInfo "Running simulation as multi stage sim..."

    if !SimcConfig["MultiStageSimStages"]
      Logging.LogScriptError "Stage definitions not found in config file!"
      exit
    end

    args.flatten!

    number_of_stages = SimcConfig["MultiStageSimStages"].size
    SimcConfig["MultiStageSimStages"].each.with_index(1) do |stage_conf, stage_num|
      Logging.LogScriptInfo "Stage #{stage_num} of #{number_of_stages}"

      stage_conf_file = "#{SimcConfig["ConfigFolder"]}/#{stage_conf}.simc"
      stage_error = ProfileHelper.GetValueFromTemplate("target_error", stage_conf_file)
      unless stage_error
        Logging.LogScriptError "No target error found in stage config file!"
        exit
      end
      stage_error = stage_error.to_f
      Logging.LogScriptInfo "Target error set to #{stage_error} via #{stage_conf} configuration."

      stage_file = simulationFilename
      if stage_num < number_of_stages
        stage_file += "-stage#{stage_num}"
      end

      RunSimulation(args, stage_file, stage_conf_file)

      if stage_num < number_of_stages
        results = JSONResults.new(stage_file)
        sims = results.getAllDPSResults()
        target_count = SimcConfig["MultiStageSimTarget"] && SimcConfig["MultiStageSimTarget"] > 0 ? SimcConfig["MultiStageSimTarget"] : 1
        target_count = [target_count, sims.size].min
        dps_cutoff = sims.values.sort { |a, b| b <=> a }[target_count - 1] * (1.0 - stage_error * 0.03)
        Logging.LogScriptInfo "Stage cutoff is #{dps_cutoff}."
        eliminate = sims.select { |k, v| v < dps_cutoff }.keys
        Logging.LogScriptInfo "Removing #{eliminate.size} combinations for next stage."
        args.delete_if { |x| x.start_with?('profileset."') && eliminate.include?(x.split('"')[1]) }
      end
    end
  end
end
