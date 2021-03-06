require "date"
require_relative "JSONParser"
require_relative "ProfileHelper"

# Used for parsing json output from simc
class JSONResults
  attr_reader :simulationFilename

  def initialize(simulationFilename = "LastInput", multiStage = false)
    simulationFilename = ProfileHelper.NormalizeProfileName(simulationFilename)

    @simulationFilename = simulationFilename
    @logFile = "#{SimcConfig["LogsFolder"]}/simc/#{simulationFilename}.json"
    @jsonData = JSONParser.ReadFile(@logFile)
    @additionalMetadata = {}

    if multiStage && SimcConfig["MultiStageLowResultPolicy"] == "keep"
      # Merge in lower accuracy results from previous stages.
      (SimcConfig["MultiStageSimStages"].size - 1).downto(1) do |i|
        json = JSONParser.ReadFile("#{SimcConfig["LogsFolder"]}/simc/#{simulationFilename}-stage#{i}.json")
        json["sim"]["players"].each do |player|
          next if @jsonData["sim"]["players"].find { |x| x["name"] == player["name"] }
          @jsonData["sim"]["players"].push player
        end
        json["sim"]["profilesets"]["results"].each do |player|
          next if @jsonData["sim"]["profilesets"]["results"].find { |x| x["name"] == player["name"] }
          @jsonData["sim"]["profilesets"]["results"].push player
        end
      end
    end
  end

  def getRawJSON()
    return @jsonData
  end

  # Returns DPS for all profiles and profilesets in a JSON report
  def getAllDPSResults()
    results = {}
    @jsonData["sim"]["players"].each do |player|
      results[player["name"]] = player["collected_data"]["dps"]["mean"].round
    end
    @jsonData["sim"]["profilesets"]["results"].each do |player|
      results[player["name"]] = player["mean"].round
    end
    return results
  end

  # Returns DPS to target for all profilesets with additional_metrics
  def getPriorityDPSResults()
    results = {}
    @jsonData["sim"]["profilesets"]["results"].each do |player|
      next unless player["additional_metrics"]
      player["additional_metrics"].each do |metric|
        if metric["metric"] == "Damage per Second to Priority Target/Boss"
          results[player["name"]] = metric["mean"].round
        end
      end
    end
    return results
  end

  # Append an hash that will be merged with the metas during extractMetadata()
  # Can be called multiple times to append different hashes before the extraction
  def appendToMetadata(additionalMetadata)
    @additionalMetadata.merge!(additionalMetadata)
  end

  # Extract metadata from a simulation
  def extractMetadata()
    Logging.LogScriptInfo "Extract metadata from #{@logFile}..."

    # Get the meta datas from the json report
    metas = {}
    iterations = []
    # totalDpsMeanStdDev = 0

    # Fight infos
    metas["fightLength"] = @jsonData["sim"]["options"]["max_time"].round
    metas["fightLengthVariation"] = @jsonData["sim"]["options"]["vary_combat_length"]
    metas["targetError"] = @jsonData["sim"]["options"]["target_error"]

    # Template infos
    @jsonData["sim"]["players"].each do |player|
      if player["name"] == "Template"
        # Get the gear using items simc encoded string
        gearSlots = ["head", "neck", "shoulders", "back", "chest", "wrists", "hands", "waist", "legs", "feet", "finger1", "finger2", "trinket1", "trinket2", "main_hand", "off_hand"]
        gear = []
        gearSlots.each do |gearSlot|
          item = player["gear"][gearSlot]
          if item
            gear.push "#{gearSlot}=#{item["encoded_item"]}"
          end
        end

        # Get the talents spell id
        talents = []
        player["talents"].each do |talent|
          columnOffset = talent["tier"] - (talents.length + 1)
          talents.fill(0, talents.length, columnOffset) if columnOffset > 0
          talents.push talent["spell_id"]
        end

        metas["templateGear"] = gear
        metas["templateTalents"] = talents
        metas["templateDPS"] = player["collected_data"]["dps"]["mean"].round
        iterations.push player["collected_data"]["dps"]["count"]
        # totalDpsMeanStdDev += player['collected_data']['dps']['mean_std_dev']
      end
    end
    @jsonData["sim"]["profilesets"]["results"].each do |player|
      iterations.push player["iterations"]
      # totalDpsMeanStdDev += player['stddev'] / Math.sqrt(player['iterations'])
    end

    # Statistics
    metas["elapsedTime"] = @jsonData["sim"]["statistics"]["elapsed_time_seconds"].round(2)
    metas["totalEventsProcessed"] = @jsonData["sim"]["statistics"]["total_events_processed"]
    metas["totalIterations"] = iterations.sum
    metas["totalActors"] = iterations.size
    # metas['totalIterationsMean'] = iterations.sum.to_f / iterations.size.to_f
    # metas['totalIterationsVariance'] = iterations.inject(0.0) { |s, x| s + (x - metas['statistics']['total_iterations_mean']) ** 2 }
    # metas['totalIterationsStdDev'] = Math.sqrt(metas['statistics']['total_iterations_variance'])
    # metas['totalIterationsSem'] = metas['statistics']['total_iterations_stddev'] / Math.sqrt(iterations.size)
    # metas['totalMeanDpsStdDev'] = totalDpsMeanStdDev / iterations.size
    # metas['totalMeanDpsVariance'] = metas['statistics']['total_mean_dps_stddev'] ** 2
    # metas['totalMeanDpsSem'] = metas['statistics']['total_mean_dps_stddev'] / Math.sqrt(iterations.size)

    # Build infos
    metas["simcBuildTimestamp"] = DateTime.parse(@jsonData["build_date"] + " " + @jsonData["build_time"] + " " + Time.now.strftime("%:z")).to_time.to_i
    metas["simcGitRevision"] = @jsonData["git_revision"]
    metas["wowVersion"] = @jsonData["sim"]["options"]["dbc"][@jsonData["sim"]["options"]["dbc"]["version_used"]]["wow_version"]
    metas["wowBuild"] = @jsonData["sim"]["options"]["dbc"][@jsonData["sim"]["options"]["dbc"]["version_used"]]["build_level"]

    # Add additional data
    metas.merge!(@additionalMetadata)

    return metas
  end
end
