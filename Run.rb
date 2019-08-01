require "rubygems"
require "bundler/setup"
require "optparse"
require_relative "lib/SimcConfig"

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [-r]"

  opts.on("-r", "Do the run starting from the end") do |r|
    options[:reverse] = r
  end
end.parse!

to_run = {
  "AzeriteSimulation" => {
    "Death-Knight" => [
      # "PR_Death_Knight_Blood",
      # "PR_Death_Knight_Frost",
      # "PR_Death_Knight_Unholy",
      # "T22_Death_Knight_Blood",
      # "T22_Death_Knight_Frost",
      # "T22_Death_Knight_Unholy",
      "T24_Death_Knight_Blood",
      "T24_Death_Knight_Frost",
      "T24_Death_Knight_Unholy",
      "DS_Death_Knight_Blood",
      "DS_Death_Knight_Frost",
      "DS_Death_Knight_Unholy",
    ],
    "Demon-Hunter" => [
      # "PR_Demon_Hunter_Havoc",
      # "PR_Demon_Hunter_Vengeance",
      # "T22_Demon_Hunter_Havoc",
      # "T22_Demon_Hunter_Vengeance",
      "T24_Demon_Hunter_Havoc",
      "T24_Demon_Hunter_Havoc_Momentum",
      "T24_Demon_Hunter_Vengeance",
      "DS_Demon_Hunter_Havoc",
      "DS_Demon_Hunter_Havoc_Momentum",
      "DS_Demon_Hunter_Vengeance",
    ],
    "Druid" => [
      # "PR_Druid_Balance",
      # "PR_Druid_Feral",
      # "PR_Druid_Guardian",
      # "T22_Druid_Balance",
      # "T22_Druid_Feral",
      # "T22_Druid_Guardian",
      "T24_Druid_Balance",
      "T24_Druid_Feral",
      "T24_Druid_Guardian",
      "DS_Druid_Balance",
      "DS_Druid_Feral",
      "DS_Druid_Guardian",
    ],
    "Hunter" => [
      # "PR_Hunter_Beast_Mastery",
      # "PR_Hunter_Marksmanship",
      # "PR_Hunter_Survival",
      # "T22_Hunter_Beast_Mastery",
      # "T22_Hunter_Marksmanship",
      # "T22_Hunter_Survival",
      "T24_Hunter_Beast_Mastery",
      "T24_Hunter_Marksmanship",
      "T24_Hunter_Survival",
      "DS_Hunter_Beast_Mastery",
      "DS_Hunter_Marksmanship",
      "DS_Hunter_Survival",
    ],
    "Mage" => [
      # "PR_Mage_Arcane",
      # "PR_Mage_Fire",
      # "PR_Mage_Frost",
      # "T22_Mage_Arcane",
      # "T22_Mage_Fire",
      # "T22_Mage_Frost",
      "T24_Mage_Arcane",
      "T24_Mage_Fire",
      "T24_Mage_Frost",
      #"T24_Mage_Frost_NoIceLance",
      #"T24_Mage_Frost_FrozenOrb",
      "DS_Mage_Arcane",
      "DS_Mage_Fire",
      "DS_Mage_Frost",
    ],
    "Monk" => [
      # "PR_Monk_Brewmaster",
      # "PR_Monk_Windwalker",
      # "T22_Monk_Brewmaster",
      # "T22_Monk_Windwalker",
      # "T24_Monk_Brewmaster",
      "T24_Monk_Windwalker",
      "DS_Monk_Windwalker",
    ],
    "Paladin" => [
      # "PR_Paladin_Protection",
      # "PR_Paladin_Retribution",
      # "T22_Paladin_Protection",
      # "T22_Paladin_Retribution",
      "T24_Paladin_Protection",
      "T24_Paladin_Retribution",
      "DS_Paladin_Protection",
      "DS_Paladin_Retribution",
    ],
    "Priest" => [
      # "PR_Priest_Shadow",
      # "T22_Priest_Shadow",
      "T24_Priest_Shadow",
      "DS_Priest_Shadow",
    ],
    "Rogue" => [
      # "PR_Rogue_Assassination",
      # "PR_Rogue_Assassination_Exsg",
      # "PR_Rogue_Outlaw",
      # "PR_Rogue_Outlaw_SnD",
      # "PR_Rogue_Subtlety",
      # "T22_Rogue_Assassination",
      # "T22_Rogue_Assassination_Exsg",
      # "T22_Rogue_Outlaw",
      # "T22_Rogue_Outlaw_SnD",
      # "T22_Rogue_Subtlety",
      "T24_Rogue_Assassination",
      "T24_Rogue_Outlaw",
      "T24_Rogue_Subtlety",
      "DS_Rogue_Assassination",
      "DS_Rogue_Outlaw",
      "DS_Rogue_Subtlety",
    ],
    "Shaman" => [
      # "PR_Shaman_Elemental",
      # "PR_Shaman_Enhancement",
      # "T22_Shaman_Elemental",
      # "T22_Shaman_Enhancement",
      "T24_Shaman_Elemental",
      "T24_Shaman_Enhancement",
      "T24_Shaman_Enhancement_Earth",
      "T24_Shaman_Enhancement_Fire",
      "DS_Shaman_Elemental",
      "DS_Shaman_Enhancement",
    ],
    "Warlock" => [
      # "PR_Warlock_Affliction",
      # "PR_Warlock_Demonology",
      # "PR_Warlock_Destruction",
      # "T22_Warlock_Affliction",
      # "T22_Warlock_Demonology",
      # "T22_Warlock_Destruction",
      "T24_Warlock_Affliction",
      "T24_Warlock_Demonology",
      "T24_Warlock_Destruction",
      "DS_Warlock_Affliction",
      "DS_Warlock_Demonology",
      "DS_Warlock_Destruction",
    ],
    "Warrior" => [
      # "PR_Warrior_Arms",
      # "PR_Warrior_Fury",
      # "PR_Warrior_Protection",
      # "T22_Warrior_Arms",
      # "T22_Warrior_Fury",
      # "T22_Warrior_Protection",
      "T24_Warrior_Arms",
      "T24_Warrior_Fury",
      "T24_Warrior_Protection",
      "DS_Warrior_Arms",
      "DS_Warrior_Fury",
      "DS_Warrior_Protection",
    ],
  },
  "EssenceSimulation" => {
    "Death-Knight" => [
      # "PR_Death_Knight_Blood",
      # "PR_Death_Knight_Frost",
      # "PR_Death_Knight_Unholy",
      # "T22_Death_Knight_Blood",
      # "T22_Death_Knight_Frost",
      # "T22_Death_Knight_Unholy",
      "T24_Death_Knight_Blood",
      "T24_Death_Knight_Frost",
      "T24_Death_Knight_Unholy",
      "DS_Death_Knight_Blood",
      "DS_Death_Knight_Frost",
      "DS_Death_Knight_Unholy",
    ],
    "Demon-Hunter" => [
      # "PR_Demon_Hunter_Havoc",
      # "PR_Demon_Hunter_Vengeance",
      # "T22_Demon_Hunter_Havoc",
      # "T22_Demon_Hunter_Vengeance",
      "T24_Demon_Hunter_Havoc",
      "T24_Demon_Hunter_Havoc_Momentum",
      "T24_Demon_Hunter_Vengeance",
      "DS_Demon_Hunter_Havoc",
      "DS_Demon_Hunter_Havoc_Momentum",
      "DS_Demon_Hunter_Vengeance",
    ],
    "Druid" => [
      # "PR_Druid_Balance",
      # "PR_Druid_Feral",
      # "PR_Druid_Guardian",
      # "T22_Druid_Balance",
      # "T22_Druid_Feral",
      # "T22_Druid_Guardian",
      "T24_Druid_Balance",
      "T24_Druid_Feral",
      "T24_Druid_Guardian",
      "DS_Druid_Balance",
      "DS_Druid_Feral",
      "DS_Druid_Guardian",
    ],
    "Hunter" => [
      # "PR_Hunter_Beast_Mastery",
      # "PR_Hunter_Marksmanship",
      # "PR_Hunter_Survival",
      # "T22_Hunter_Beast_Mastery",
      # "T22_Hunter_Marksmanship",
      # "T22_Hunter_Survival",
      "T24_Hunter_Beast_Mastery",
      "T24_Hunter_Marksmanship",
      "T24_Hunter_Survival",
      "DS_Hunter_Beast_Mastery",
      "DS_Hunter_Marksmanship",
      "DS_Hunter_Survival",
    ],
    "Mage" => [
      # "PR_Mage_Arcane",
      # "PR_Mage_Fire",
      # "PR_Mage_Frost",
      # "T22_Mage_Arcane",
      # "T22_Mage_Fire",
      # "T22_Mage_Frost",
      "T24_Mage_Arcane",
      "T24_Mage_Fire",
      "T24_Mage_Frost",
      #"T24_Mage_Frost_NoIceLance",
      #"T24_Mage_Frost_FrozenOrb",
      "DS_Mage_Arcane",
      "DS_Mage_Fire",
      "DS_Mage_Frost",
    ],
    "Monk" => [
      # "PR_Monk_Brewmaster",
      # "PR_Monk_Windwalker",
      # "T22_Monk_Brewmaster",
      # "T22_Monk_Windwalker",
      # "T24_Monk_Brewmaster",
      "T24_Monk_Windwalker",
      "DS_Monk_Windwalker",
    ],
    "Paladin" => [
      # "PR_Paladin_Protection",
      # "PR_Paladin_Retribution",
      # "T22_Paladin_Protection",
      # "T22_Paladin_Retribution",
      "T24_Paladin_Protection",
      "T24_Paladin_Retribution",
      "DS_Paladin_Protection",
      "DS_Paladin_Retribution",
    ],
    "Priest" => [
      # "PR_Priest_Shadow",
      # "T22_Priest_Shadow",
      "T24_Priest_Shadow",
      "DS_Priest_Shadow",
    ],
    "Rogue" => [
      # "PR_Rogue_Assassination",
      # "PR_Rogue_Assassination_Exsg",
      # "PR_Rogue_Outlaw",
      # "PR_Rogue_Outlaw_SnD",
      # "PR_Rogue_Subtlety",
      # "T22_Rogue_Assassination",
      # "T22_Rogue_Assassination_Exsg",
      # "T22_Rogue_Outlaw",
      # "T22_Rogue_Outlaw_SnD",
      # "T22_Rogue_Subtlety",
      "T24_Rogue_Assassination",
      "T24_Rogue_Outlaw",
      "T24_Rogue_Subtlety",
      "DS_Rogue_Assassination",
      "DS_Rogue_Outlaw",
      "DS_Rogue_Subtlety",
    ],
    "Shaman" => [
      # "PR_Shaman_Elemental",
      # "PR_Shaman_Enhancement",
      # "T22_Shaman_Elemental",
      # "T22_Shaman_Enhancement",
      "T24_Shaman_Elemental",
      "T24_Shaman_Enhancement",
      "T24_Shaman_Enhancement_Earth",
      "T24_Shaman_Enhancement_Fire",
      "DS_Shaman_Elemental",
      "DS_Shaman_Enhancement",
    ],
    "Warlock" => [
      # "PR_Warlock_Affliction",
      # "PR_Warlock_Demonology",
      # "PR_Warlock_Destruction",
      # "T22_Warlock_Affliction",
      # "T22_Warlock_Demonology",
      # "T22_Warlock_Destruction",
      "T24_Warlock_Affliction",
      "T24_Warlock_Demonology",
      "T24_Warlock_Destruction",
      "DS_Warlock_Affliction",
      "DS_Warlock_Demonology",
      "DS_Warlock_Destruction",
    ],
    "Warrior" => [
      # "PR_Warrior_Arms",
      # "PR_Warrior_Fury",
      # "PR_Warrior_Protection",
      # "T22_Warrior_Arms",
      # "T22_Warrior_Fury",
      # "T22_Warrior_Protection",
      "T24_Warrior_Arms",
      "T24_Warrior_Fury",
      "T24_Warrior_Protection",
      "DS_Warrior_Arms",
      "DS_Warrior_Fury",
      "DS_Warrior_Protection",
    ],
  },
  "Combinator" => {
    ##########################################################################################
    # Keep the gear called Azerite and setup as well, this will be auto replaced for stacks. #
    ##########################################################################################
    "Death-Knight" => [
      "T24_Death_Knight_Blood Death-Knight_Azerite Azerite xxx20xx",
      "T24_Death_Knight_Frost Death-Knight_Azerite Azerite xx0x0xx",
      "T24_Death_Knight_Unholy Death-Knight_Azerite Azerite xx0x0xx",
      "DS_Death_Knight_Blood Death-Knight_Azerite Azerite xxx20xx",
      "DS_Death_Knight_Frost Death-Knight_Azerite Azerite xx0x0xx",
      "DS_Death_Knight_Unholy Death-Knight_Azerite Azerite xx0x0xx",
      # Essence sims
      "T24_Death_Knight_Blood Death-Knight_Essences 1E xxx20xx",
      "T24_Death_Knight_Frost Death-Knight_Essences 1E xx0x0xx",
      "T24_Death_Knight_Unholy Death-Knight_Essences 1E xx0x0xx",
      "DS_Death_Knight_Blood Death-Knight_Essences 1E xxx20xx",
      "DS_Death_Knight_Frost Death-Knight_Essences 1E xx0x0xx",
      "DS_Death_Knight_Unholy Death-Knight_Essences 1E xx0x0xx",
      "T24_Death_Knight_Blood Death-Knight_Essences 2E default",
      "T24_Death_Knight_Frost Death-Knight_Essences 2E default",
      "T24_Death_Knight_Unholy Death-Knight_Essences 2E default",
      "DS_Death_Knight_Blood Death-Knight_Essences 2E default",
      "DS_Death_Knight_Frost Death-Knight_Essences 2E default",
      "DS_Death_Knight_Unholy Death-Knight_Essences 2E default",
      "T24_Death_Knight_Blood Death-Knight_Essences 3E default",
      "T24_Death_Knight_Frost Death-Knight_Essences 3E default",
      "T24_Death_Knight_Unholy Death-Knight_Essences 3E default",
      "DS_Death_Knight_Blood Death-Knight_Essences 3E default",
      "DS_Death_Knight_Frost Death-Knight_Essences 3E default",
      "DS_Death_Knight_Unholy Death-Knight_Essences 3E default",
    ],
    "Demon-Hunter" => [
      "T24_Demon_Hunter_Havoc Demon-Hunter_Azerite Azerite xxx0x2[13]",
      "T24_Demon_Hunter_Havoc_Momentum Demon-Hunter_Azerite Azerite xxx0x22",
      "T24_Demon_Hunter_Vengeance Demon-Hunter_Azerite Azerite xxxx1x1",
      "DS_Demon_Hunter_Havoc Demon-Hunter_Azerite Azerite xxx0x2[13]",
      "DS_Demon_Hunter_Havoc_Momentum Demon-Hunter_Azerite Azerite xxx0x22",
      "DS_Demon_Hunter_Vengeance Demon-Hunter_Azerite Azerite xxxx1x1",
      # Essence sims
      "T24_Demon_Hunter_Havoc Demon-Hunter_Essences 1E xxx0x2[13]",
      "T24_Demon_Hunter_Havoc_Momentum Demon-Hunter_Essences 1E xxx0x22",
      "T24_Demon_Hunter_Vengeance Demon-Hunter_Essences 1E xxxx1x1",
      "DS_Demon_Hunter_Havoc Demon-Hunter_Essences 1E xxx0x2[13]",
      "DS_Demon_Hunter_Havoc_Momentum Demon-Hunter_Essences 1E xxx0x22",
      "DS_Demon_Hunter_Vengeance Demon-Hunter_Essences 1E xxxx1x1",
      "T24_Demon_Hunter_Havoc Demon-Hunter_Essences 2E default",
      "T24_Demon_Hunter_Havoc_Momentum Demon-Hunter_Essences 2E default",
      "T24_Demon_Hunter_Vengeance Demon-Hunter_Essences 2E default",
      "DS_Demon_Hunter_Havoc Demon-Hunter_Essences 2E default",
      "DS_Demon_Hunter_Havoc_Momentum Demon-Hunter_Essences 2E default",
      "DS_Demon_Hunter_Vengeance Demon-Hunter_Essences 2E default",
      "T24_Demon_Hunter_Havoc Demon-Hunter_Essences 3E default",
      "T24_Demon_Hunter_Havoc_Momentum Demon-Hunter_Essences 3E default",
      "T24_Demon_Hunter_Vengeance Demon-Hunter_Essences 3E default",
      "DS_Demon_Hunter_Havoc Demon-Hunter_Essences 3E default",
      "DS_Demon_Hunter_Havoc_Momentum Demon-Hunter_Essences 3E default",
      "DS_Demon_Hunter_Vengeance Demon-Hunter_Essences 3E default",
    ],
    "Druid" => [
      "T24_Druid_Balance Druid_Azerite Azerite x000xxx",
      "T24_Druid_Feral Druid_Azerite Azerite x000xxx",
      "T24_Druid_Guardian Druid_Azerite Azerite x111x2x",
      "DS_Druid_Balance Druid_Azerite Azerite x000xxx",
      "DS_Druid_Feral Druid_Azerite Azerite x000xxx",
      "DS_Druid_Guardian Druid_Azerite Azerite x111x2x",
      # Essence sims
      "T24_Druid_Balance Druid_Essences 1E x000xxx",
      "T24_Druid_Feral Druid_Essences 1E x000xxx",
      "T24_Druid_Guardian Druid_Essences 1E x111x2x",
      "DS_Druid_Balance Druid_Essences 1E x000xxx",
      "DS_Druid_Feral Druid_Essences 1E x000xxx",
      "DS_Druid_Guardian Druid_Essences 1E x111x2x",
      "T24_Druid_Balance Druid_Essences 2E default",
      "T24_Druid_Feral Druid_Essences 2E default",
      "T24_Druid_Guardian Druid_Essences 2E default",
      "DS_Druid_Balance Druid_Essences 2E default",
      "DS_Druid_Feral Druid_Essences 2E default",
      "DS_Druid_Guardian Druid_Essences 2E default",
      "T24_Druid_Balance Druid_Essences 3E default",
      "T24_Druid_Feral Druid_Essences 3E default",
      "T24_Druid_Guardian Druid_Essences 3E default",
      "DS_Druid_Balance Druid_Essences 3E default",
      "DS_Druid_Feral Druid_Essences 3E default",
      "DS_Druid_Guardian Druid_Essences 3E default",
    ],
    "Hunter" => [
      "T24_Hunter_Beast_Mastery Hunter_Azerite Azerite xx0x0xx",
      "T24_Hunter_Marksmanship Hunter_Azerite Azerite xx0x0xx",
      "T24_Hunter_Survival Hunter_Azerite Azerite xx0x0xx",
      "DS_Hunter_Beast_Mastery Hunter_Azerite Azerite xx0x0xx",
      "DS_Hunter_Marksmanship Hunter_Azerite Azerite xx0x0xx",
      "DS_Hunter_Survival Hunter_Azerite Azerite xx0x0xx",
      # Essence sims
      "T24_Hunter_Beast_Mastery Hunter_Essences 1E xx0x0xx",
      "T24_Hunter_Marksmanship Hunter_Essences 1E xx0x0xx",
      "T24_Hunter_Survival Hunter_Essences 1E xx0x0xx",
      "DS_Hunter_Beast_Mastery Hunter_Essences 1E xx0x0xx",
      "DS_Hunter_Marksmanship Hunter_Essences 1E xx0x0xx",
      "DS_Hunter_Survival Hunter_Essences 1E xx0x0xx",
      "T24_Hunter_Beast_Mastery Hunter_Essences 2E default",
      "T24_Hunter_Marksmanship Hunter_Essences 2E default",
      "T24_Hunter_Survival Hunter_Essences 2E default",
      "DS_Hunter_Beast_Mastery Hunter_Essences 2E default",
      "DS_Hunter_Marksmanship Hunter_Essences 2E default",
      "DS_Hunter_Survival Hunter_Essences 2E default",
      "T24_Hunter_Beast_Mastery Hunter_Essences 3E default",
      "T24_Hunter_Marksmanship Hunter_Essences 3E default",
      "T24_Hunter_Survival Hunter_Essences 3E default",
      "DS_Hunter_Beast_Mastery Hunter_Essences 3E default",
      "DS_Hunter_Marksmanship Hunter_Essences 3E default",
      "DS_Hunter_Survival Hunter_Essences 3E default",
    ],
    "Mage" => [
      "T24_Mage_Arcane Mage_Azerite Azerite x0xx0xx",
      "T24_Mage_Fire Mage_Azerite Azerite x0xx0xx",
      "T24_Mage_Frost Mage_Azerite Azerite x0xx0xx",
      #"T24_Mage_Frost_NoIceLance Mage_Azerite Azerite x0xx0x3",
      #"T24_Mage_Frost_FrozenOrb Mage_Azerite Azerite x0xx0x[12]",
      "DS_Mage_Arcane Mage_Azerite Azerite x0xx0xx",
      "DS_Mage_Fire Mage_Azerite Azerite x0xx0xx",
      "DS_Mage_Frost Mage_Azerite Azerite x0xx0xx",
      # Essence sims
      "T24_Mage_Arcane Mage_Essences 1E x0xx0xx",
      "T24_Mage_Fire Mage_Essences 1E x0xx0xx",
      "T24_Mage_Frost Mage_Essences 1E x0xx0xx",
      #"T24_Mage_Frost_NoIceLance Mage_Essences 1E x0xx0x3",
      #"T24_Mage_Frost_FrozenOrb Mage_Essences 1E x0xx0x[12]",
      "DS_Mage_Arcane Mage_Essences 1E x0xx0xx",
      "DS_Mage_Fire Mage_Essences 1E x0xx0xx",
      "DS_Mage_Frost Mage_Essences 1E x0xx0xx",
      "T24_Mage_Arcane Mage_Essences 2E default",
      "T24_Mage_Fire Mage_Essences 2E default",
      "T24_Mage_Frost Mage_Essences 2E default",
      #"T24_Mage_Frost_NoIceLance Mage_Essences 2E default",
      #"T24_Mage_Frost_FrozenOrb Mage_Essences 2E default",
      "DS_Mage_Arcane Mage_Essences 2E default",
      "DS_Mage_Fire Mage_Essences 2E default",
      "DS_Mage_Frost Mage_Essences 2E default",
      "T24_Mage_Arcane Mage_Essences 3E default",
      "T24_Mage_Fire Mage_Essences 3E default",
      "T24_Mage_Frost Mage_Essences 3E default",
      #"T24_Mage_Frost_NoIceLance Mage_Essences 3E default",
      #"T24_Mage_Frost_FrozenOrb Mage_Essences 3E default",
      "DS_Mage_Arcane Mage_Essences 3E default",
      "DS_Mage_Fire Mage_Essences 3E default",
      "DS_Mage_Frost Mage_Essences 3E default",
    ],
    "Monk" => [
      "T24_Monk_Windwalker Monk_Azerite Azerite x0x20xx",
      "DS_Monk_Windwalker Monk_Azerite Azerite x0x20xx",
      # Essence sims
      "T24_Monk_Windwalker Monk_Essences 1E x0x20xx",
      "DS_Monk_Windwalker Monk_Essences 1E x0x20xx",
      "T24_Monk_Windwalker Monk_Essences 3E default",
      "DS_Monk_Windwalker Monk_Essences 3E default",
    ],
    "Paladin" => [
      "T24_Paladin_Protection Paladin_Azerite Azerite xx0000x",
      "T24_Paladin_Retribution Paladin_Azerite Azerite xx0x00x",
      "DS_Paladin_Protection Paladin_Azerite Azerite xx0000x",
      "DS_Paladin_Retribution Paladin_Azerite Azerite xx0x00x",
      # Essence sims
      "T24_Paladin_Protection Paladin_Essences 1E xx0000x",
      "T24_Paladin_Retribution Paladin_Essences 1E xx0x00x",
      "DS_Paladin_Protection Paladin_Essences 1E xx0000x",
      "DS_Paladin_Retribution Paladin_Essences 1E xx0x00x",
      "T24_Paladin_Protection Paladin_Essences 2E default",
      "T24_Paladin_Retribution Paladin_Essences 2E default",
      "DS_Paladin_Protection Paladin_Essences 2E default",
      "DS_Paladin_Retribution Paladin_Essences 2E default",
      "T24_Paladin_Protection Paladin_Essences 3E default",
      "T24_Paladin_Retribution Paladin_Essences 3E default",
      "DS_Paladin_Protection Paladin_Essences 3E default",
      "DS_Paladin_Retribution Paladin_Essences 3E default",
    ],
    "Priest" => [
      "T24_Priest_Shadow Priest_Azerite Azerite x1x1xxx",
      "DS_Priest_Shadow Priest_Azerite Azerite x1x1xxx",
      # Essence sims
      "T24_Priest_Shadow Priest_Essences 1E x1x1xxx",
      "DS_Priest_Shadow Priest_Essences 1E x1x1xxx",
      "T24_Priest_Shadow Priest_Essences 2E default",
      "DS_Priest_Shadow Priest_Essences 2E default",
      "T24_Priest_Shadow Priest_Essences 3E default",
      "DS_Priest_Shadow Priest_Essences 3E default",
    ],
    "Rogue" => [
      "T24_Rogue_Assassination Rogue_Azerite Azerite xxx00xx",
      "T24_Rogue_Outlaw Rogue_Azerite Azerite x0x00xx",
      "T24_Rogue_Subtlety Rogue_Azerite Azerite xxx00xx",
      "DS_Rogue_Assassination Rogue_Azerite Azerite xxx00xx",
      "DS_Rogue_Outlaw Rogue_Azerite Azerite x0x00xx",
      "DS_Rogue_Subtlety Rogue_Azerite Azerite xxx00xx",
      # Essence sims
      "T24_Rogue_Assassination Rogue_Essences 1E xxx00xx",
      "T24_Rogue_Outlaw Rogue_Essences 1E x0x00xx",
      "T24_Rogue_Subtlety Rogue_Essences 1E xxx00xx",
      "DS_Rogue_Assassination Rogue_Essences 1E xxx00xx",
      "DS_Rogue_Outlaw Rogue_Essences 1E x0x00xx",
      "DS_Rogue_Subtlety Rogue_Essences 1E xxx00xx",
      "T24_Rogue_Assassination Rogue_Essences 2E 2[23]100[23]1",
      "T24_Rogue_Outlaw Rogue_Essences 2E default",
      "T24_Rogue_Subtlety Rogue_Essences 2E 2[13]200[13]1",
      "DS_Rogue_Assassination Rogue_Essences 2E default",
      "DS_Rogue_Outlaw Rogue_Essences 2E default",
      "DS_Rogue_Subtlety Rogue_Essences 2E default",
      "T24_Rogue_Assassination Rogue_Essences 3E 2[23]100[23]1",
      "T24_Rogue_Outlaw Rogue_Essences 3E default",
      "T24_Rogue_Subtlety Rogue_Essences 3E 2[13]200[13]1",
      "DS_Rogue_Assassination Rogue_Essences 3E default",
      "DS_Rogue_Outlaw Rogue_Essences 3E default",
      "DS_Rogue_Subtlety Rogue_Essences 3E default",
    ],
    "Shaman" => [
      "T24_Shaman_Elemental Shaman_Azerite Azerite xx0x0xx",
      "T24_Shaman_Enhancement Shaman_Azerite Azerite xx0x0xx",
      "DS_Shaman_Elemental Shaman_Azerite Azerite xx0x0xx",
      "DS_Shaman_Enhancement Shaman_Azerite Azerite xx0x0xx",
      # Essence sims
      "T24_Shaman_Elemental Shaman_Essences 1E xx0x0xx",
      "T24_Shaman_Enhancement Shaman_Essences 1E xx0x0xx",
      "DS_Shaman_Elemental Shaman_Essences 1E xx0x0xx",
      "DS_Shaman_Enhancement Shaman_Essences 1E xx0x0xx",
      "T24_Shaman_Elemental Shaman_Essences 2E default",
      "T24_Shaman_Enhancement Shaman_Essences 2E default",
      "DS_Shaman_Elemental Shaman_Essences 2E default",
      "DS_Shaman_Enhancement Shaman_Essences 2E default",
      "T24_Shaman_Elemental Shaman_Essences 3E default",
      "T24_Shaman_Enhancement Shaman_Essences 3E default",
      "DS_Shaman_Elemental Shaman_Essences 3E default",
      "DS_Shaman_Enhancement Shaman_Essences 3E default",
    ],
    "Warlock" => [
      "T24_Warlock_Affliction Warlock_Azerite Azerite xx0x0xx",
      "T24_Warlock_Demonology Warlock_Azerite Azerite xx0x0xx",
      "T24_Warlock_Destruction Warlock_Azerite Azerite xx0x0xx",
      "DS_Warlock_Affliction Warlock_Azerite Azerite xx0x0xx",
      "DS_Warlock_Demonology Warlock_Azerite Azerite xx0x0xx",
      "DS_Warlock_Destruction Warlock_Azerite Azerite xx0x0xx",
      # Essence sims
      "T24_Warlock_Affliction Warlock_Essences 1E xx0x0xx",
      "T24_Warlock_Demonology Warlock_Essences 1E xx0x0xx",
      "T24_Warlock_Destruction Warlock_Essences 1E xx0x0xx",
      "DS_Warlock_Affliction Warlock_Essences 1E xx0x0xx",
      "DS_Warlock_Demonology Warlock_Essences 1E xx0x0xx",
      "DS_Warlock_Destruction Warlock_Essences 1E xx0x0xx",
      "T24_Warlock_Affliction Warlock_Essences 2E default",
      "T24_Warlock_Demonology Warlock_Essences 2E default",
      "T24_Warlock_Destruction Warlock_Essences 2E default",
      "DS_Warlock_Affliction Warlock_Essences 2E default",
      "DS_Warlock_Demonology Warlock_Essences 2E default",
      "DS_Warlock_Destruction Warlock_Essences 2E default",
      "T24_Warlock_Affliction Warlock_Essences 3E default",
      "T24_Warlock_Demonology Warlock_Essences 3E default",
      "T24_Warlock_Destruction Warlock_Essences 3E default",
      "DS_Warlock_Affliction Warlock_Essences 3E default",
      "DS_Warlock_Demonology Warlock_Essences 3E default",
      "DS_Warlock_Destruction Warlock_Essences 3E default",
    ],
    "Warrior" => [
      "T24_Warrior_Arms Warrior_Azerite Azerite x3x2xxx",
      "T24_Warrior_Fury Warrior_Azerite Azerite x3x2xxx",
      "T24_Warrior_Protection Warrior_Azerite Azerite x0x00xx",
      "DS_Warrior_Arms Warrior_Azerite Azerite x3x2xxx",
      "DS_Warrior_Fury Warrior_Azerite Azerite x3x2xxx",
      "DS_Warrior_Protection Warrior_Azerite Azerite x0x00xx",
      # Essence sims
      "T24_Warrior_Arms Warrior_Essences 1E x3x2xxx",
      "T24_Warrior_Fury Warrior_Essences 1E x3x2xxx",
      "T24_Warrior_Protection Warrior_Essences 1E x0x00xx",
      "DS_Warrior_Arms Warrior_Essences 1E x3x2xxx",
      "DS_Warrior_Fury Warrior_Essences 1E x3x2xxx",
      "DS_Warrior_Protection Warrior_Essences 1E x0x00xx",
      "T24_Warrior_Arms Warrior_Essences 2E default",
      "T24_Warrior_Fury Warrior_Essences 2E default",
      "T24_Warrior_Protection Warrior_Essences 2E default",
      "DS_Warrior_Arms Warrior_Essences 2E default",
      "DS_Warrior_Fury Warrior_Essences 2E default",
      "DS_Warrior_Protection Warrior_Essences 2E default",
      "T24_Warrior_Arms Warrior_Essences 3E default",
      "T24_Warrior_Fury Warrior_Essences 3E default",
      "T24_Warrior_Protection Warrior_Essences 3E default",
      "DS_Warrior_Arms Warrior_Essences 3E default",
      "DS_Warrior_Fury Warrior_Essences 3E default",
      "DS_Warrior_Protection Warrior_Essences 3E default",
    ],
  },
  "RaceSimulation" => {
    "Death-Knight" => [
      # "PR_Death_Knight_Blood",
      # "PR_Death_Knight_Frost",
      # "PR_Death_Knight_Unholy",
      # "T22_Death_Knight_Blood",
      # "T22_Death_Knight_Frost",
      # "T22_Death_Knight_Unholy",
      "T24_Death_Knight_Blood",
      "T24_Death_Knight_Frost",
      "T24_Death_Knight_Unholy",
      "DS_Death_Knight_Blood",
      "DS_Death_Knight_Frost",
      "DS_Death_Knight_Unholy",
    ],
    "Demon-Hunter" => [
      # "PR_Demon_Hunter_Havoc",
      # "PR_Demon_Hunter_Vengeance",
      # "T22_Demon_Hunter_Havoc",
      # "T22_Demon_Hunter_Vengeance",
      "T24_Demon_Hunter_Havoc",
      "T24_Demon_Hunter_Havoc_Momentum",
      "T24_Demon_Hunter_Vengeance",
      "DS_Demon_Hunter_Havoc",
      "DS_Demon_Hunter_Havoc_Momentum",
      "DS_Demon_Hunter_Vengeance",
    ],
    "Druid" => [
      # "PR_Druid_Balance",
      # "PR_Druid_Feral",
      # "PR_Druid_Guardian",
      # "T22_Druid_Balance",
      # "T22_Druid_Feral",
      # "T22_Druid_Guardian",
      "T24_Druid_Balance",
      "T24_Druid_Feral",
      "T24_Druid_Guardian",
      "DS_Druid_Balance",
      "DS_Druid_Feral",
      "DS_Druid_Guardian",
    ],
    "Hunter" => [
      # "PR_Hunter_Beast_Mastery",
      # "PR_Hunter_Marksmanship",
      # "PR_Hunter_Survival",
      # "T22_Hunter_Beast_Mastery",
      # "T22_Hunter_Marksmanship",
      # "T22_Hunter_Survival",
      "T24_Hunter_Beast_Mastery",
      "T24_Hunter_Marksmanship",
      "T24_Hunter_Survival",
      "DS_Hunter_Beast_Mastery",
      "DS_Hunter_Marksmanship",
      "DS_Hunter_Survival",
    ],
    "Mage" => [
      # "PR_Mage_Arcane",
      # "PR_Mage_Fire",
      # "PR_Mage_Frost",
      # "T22_Mage_Arcane",
      # "T22_Mage_Fire",
      # "T22_Mage_Frost",
      "T24_Mage_Arcane",
      "T24_Mage_Fire",
      "T24_Mage_Frost",
      #"T24_Mage_Frost_NoIceLance",
      #"T24_Mage_Frost_FrozenOrb",
      "DS_Mage_Arcane",
      "DS_Mage_Fire",
      "DS_Mage_Frost",
    ],
    "Monk" => [
      # "PR_Monk_Brewmaster",
      # "PR_Monk_Windwalker",
      # "PR_Monk_Windwalker_Serenity",
      # "T22_Monk_Brewmaster",
      # "T22_Monk_Windwalker",
      # "T22_Monk_Windwalker_Serenity",
      # "T24_Monk_Brewmaster",
      "T24_Monk_Windwalker",
      "T24_Monk_Windwalker_Serenity",
      "DS_Monk_Windwalker",
      "DS_Monk_Windwalker_Serenity",
    ],
    "Paladin" => [
      # "PR_Paladin_Protection",
      # "PR_Paladin_Retribution",
      # "T22_Paladin_Protection",
      # "T22_Paladin_Retribution",
      "T24_Paladin_Protection",
      "T24_Paladin_Retribution",
      "DS_Paladin_Protection",
      "DS_Paladin_Retribution",
    ],
    "Priest" => [
      # "PR_Priest_Shadow",
      # "T22_Priest_Shadow",
      "T24_Priest_Shadow",
      "DS_Priest_Shadow",
    ],
    "Rogue" => [
      # "PR_Rogue_Assassination",
      # "PR_Rogue_Assassination_Exsg",
      # "PR_Rogue_Outlaw",
      # "PR_Rogue_Outlaw_SnD",
      # "PR_Rogue_Subtlety",
      # "T22_Rogue_Assassination",
      # "T22_Rogue_Assassination_Exsg",
      # "T22_Rogue_Outlaw",
      # "T22_Rogue_Outlaw_SnD",
      # "T22_Rogue_Subtlety",
      "T24_Rogue_Assassination",
      "T24_Rogue_Outlaw",
      "T24_Rogue_Subtlety",
      "DS_Rogue_Assassination",
      "DS_Rogue_Outlaw",
      "DS_Rogue_Subtlety",
    ],
    "Shaman" => [
      # "PR_Shaman_Elemental",
      # "PR_Shaman_Enhancement",
      # "T22_Shaman_Elemental",
      # "T22_Shaman_Enhancement",
      "T24_Shaman_Elemental",
      "T24_Shaman_Enhancement",
      "T24_Shaman_Enhancement_Earth",
      "T24_Shaman_Enhancement_Fire",
      "DS_Shaman_Elemental",
      "DS_Shaman_Enhancement",
    ],
    "Warlock" => [
      # "PR_Warlock_Affliction",
      # "PR_Warlock_Demonology",
      # "PR_Warlock_Destruction",
      # "T22_Warlock_Affliction",
      # "T22_Warlock_Demonology",
      # "T22_Warlock_Destruction",
      "T24_Warlock_Affliction",
      "T24_Warlock_Demonology",
      "T24_Warlock_Destruction",
      "DS_Warlock_Affliction",
      "DS_Warlock_Demonology",
      "DS_Warlock_Destruction",
    ],
    "Warrior" => [
      # "PR_Warrior_Arms",
      # "PR_Warrior_Fury",
      # "PR_Warrior_Protection",
      # "T22_Warrior_Arms",
      # "T22_Warrior_Fury",
      # "T22_Warrior_Protection",
      "T24_Warrior_Arms",
      "T24_Warrior_Fury",
      "T24_Warrior_Protection",
      "DS_Warrior_Arms",
      "DS_Warrior_Fury",
      "DS_Warrior_Protection",
    ],
  },
  "TrinketSimulation" => {
    "Death-Knight" => [
      # "PR_Death_Knight_Blood Strength",
      # "PR_Death_Knight_Frost Strength",
      # "PR_Death_Knight_Unholy Strength",
      # "T22_Death_Knight_Blood Strength",
      # "T22_Death_Knight_Frost Strength",
      # "T22_Death_Knight_Unholy Strength",
      "T24_Death_Knight_Blood Strength",
      "T24_Death_Knight_Frost Strength",
      "T24_Death_Knight_Unholy Strength",
      "DS_Death_Knight_Blood Strength",
      "DS_Death_Knight_Frost Strength",
      "DS_Death_Knight_Unholy Strength",
    ],
    "Demon-Hunter" => [
      # "PR_Demon_Hunter_Havoc Agility",
      # "PR_Demon_Hunter_Vengeance Agility",
      # "T22_Demon_Hunter_Havoc Agility",
      # "T22_Demon_Hunter_Vengeance Agility",
      "T24_Demon_Hunter_Havoc Agility",
      "T24_Demon_Hunter_Havoc_Momentum Agility",
      "T24_Demon_Hunter_Vengeance Agility",
      "DS_Demon_Hunter_Havoc Agility",
      "DS_Demon_Hunter_Havoc_Momentum Agility",
      "DS_Demon_Hunter_Vengeance Agility",
    ],
    "Druid" => [
      # "PR_Druid_Balance Intelligence",
      # "PR_Druid_Feral Agility",
      # "PR_Druid_Guardian Agility",
      # "T22_Druid_Balance Intelligence",
      # "T22_Druid_Feral Agility",
      # "T22_Druid_Guardian Agility",
      "T24_Druid_Balance Intelligence",
      "T24_Druid_Feral Agility",
      "T24_Druid_Guardian Agility",
      "DS_Druid_Balance Intelligence",
      "DS_Druid_Feral Agility",
      "DS_Druid_Guardian Agility",
    ],
    "Hunter" => [
      # "PR_Hunter_Beast_Mastery Agility",
      # "PR_Hunter_Marksmanship Agility",
      # "PR_Hunter_Survival Agility",
      # "T22_Hunter_Beast_Mastery Agility",
      # "T22_Hunter_Marksmanship Agility",
      # "T22_Hunter_Survival Agility",
      "T24_Hunter_Beast_Mastery Agility",
      "T24_Hunter_Marksmanship Agility",
      "T24_Hunter_Survival Agility",
      "DS_Hunter_Beast_Mastery Agility",
      "DS_Hunter_Marksmanship Agility",
      "DS_Hunter_Survival Agility",
    ],
    "Mage" => [
      # "PR_Mage_Arcane Intelligence",
      # "PR_Mage_Fire Intelligence",
      # "PR_Mage_Frost Intelligence",
      # "T22_Mage_Arcane Intelligence",
      # "T22_Mage_Fire Intelligence",
      # "T22_Mage_Frost Intelligence",
      "T24_Mage_Arcane Intelligence",
      "T24_Mage_Fire Intelligence",
      "T24_Mage_Frost Intelligence",
      #"T24_Mage_Frost_NoIceLance Intelligence",
      #"T24_Mage_Frost_FrozenOrb Intelligence",
      "DS_Mage_Arcane Intelligence",
      "DS_Mage_Fire Intelligence",
      "DS_Mage_Frost Intelligence",
    ],
    "Monk" => [
      # "PR_Monk_Brewmaster Agility",
      # "PR_Monk_Windwalker Agility",
      # "PR_Monk_Windwalker_Serenity Agility",
      # "T22_Monk_Brewmaster Agility",
      # "T22_Monk_Windwalker Agility",
      # "T22_Monk_Windwalker_Serenity Agility",
      # "T24_Monk_Brewmaster Agility",
      "T24_Monk_Windwalker Agility",
      "T24_Monk_Windwalker_Serenity Agility",
      "DS_Monk_Windwalker Agility",
      "DS_Monk_Windwalker_Serenity Agility",
    ],
    "Paladin" => [
      # "PR_Paladin_Protection Strength",
      # "PR_Paladin_Retribution Strength",
      # "T22_Paladin_Protection Strength",
      # "T22_Paladin_Retribution Strength",
      "T24_Paladin_Protection Strength",
      "T24_Paladin_Retribution Strength",
      "DS_Paladin_Protection Strength",
      "DS_Paladin_Retribution Strength",
    ],
    "Priest" => [
      # "PR_Priest_Shadow Intelligence",
      # "T22_Priest_Shadow Intelligence",
      "T24_Priest_Shadow Intelligence",
      "DS_Priest_Shadow Intelligence",
    ],
    "Rogue" => [
      # "PR_Rogue_Assassination Agility",
      # "PR_Rogue_Assassination_Exsg Agility",
      # "PR_Rogue_Outlaw Agility",
      # "PR_Rogue_Outlaw_SnD Agility",
      # "PR_Rogue_Subtlety Agility",
      # "T22_Rogue_Assassination Agility",
      # "T22_Rogue_Assassination_Exsg Agility",
      # "T22_Rogue_Outlaw Agility",
      # "T22_Rogue_Outlaw_SnD Agility",
      # "T22_Rogue_Subtlety Agility",
      "T24_Rogue_Assassination Agility",
      "T24_Rogue_Outlaw Agility",
      "T24_Rogue_Subtlety Agility",
      "DS_Rogue_Assassination Agility",
      "DS_Rogue_Outlaw Agility",
      "DS_Rogue_Subtlety Agility",
    ],
    "Shaman" => [
      # "PR_Shaman_Elemental Intelligence",
      # "PR_Shaman_Enhancement Agility",
      # "T22_Shaman_Elemental Intelligence",
      # "T22_Shaman_Enhancement Agility",
      "T24_Shaman_Elemental Intelligence",
      "T24_Shaman_Enhancement Agility",
      "T24_Shaman_Enhancement_Earth Agility",
      "T24_Shaman_Enhancement_Fire Agility",
      "DS_Shaman_Elemental Intelligence",
      "DS_Shaman_Enhancement Agility",
    ],
    "Warlock" => [
      # "PR_Warlock_Affliction Intelligence",
      # "PR_Warlock_Demonology Intelligence",
      # "PR_Warlock_Destruction Intelligence",
      # "T22_Warlock_Affliction Intelligence",
      # "T22_Warlock_Demonology Intelligence",
      # "T22_Warlock_Destruction Intelligence",
      "T24_Warlock_Affliction Intelligence",
      "T24_Warlock_Demonology Intelligence",
      "T24_Warlock_Destruction Intelligence",
      "DS_Warlock_Affliction Intelligence",
      "DS_Warlock_Demonology Intelligence",
      "DS_Warlock_Destruction Intelligence",
    ],
    "Warrior" => [
      # "PR_Warrior_Arms Strength",
      # "PR_Warrior_Fury Strength",
      # "PR_Warrior_Protection Strength",
      # "T22_Warrior_Arms Strength",
      # "T22_Warrior_Fury Strength",
      # "T22_Warrior_Protection Strength",
      "T24_Warrior_Arms Strength",
      "T24_Warrior_Fury Strength",
      "T24_Warrior_Protection Strength",
      "DS_Warrior_Arms Strength",
      "DS_Warrior_Fury Strength",
      "DS_Warrior_Protection Strength",
    ],
  },
}

orders = SimcConfig["RunOrders"]
wow_classes = SimcConfig["RunClasses"]
azeriteStacks = SimcConfig["RunCombinatorAzeriteStacks"]

if options[:reverse]
  wow_classes.reverse!
  azeriteStacks.reverse!
end

orders.each do |steps|
  steps.reverse! if options[:reverse]
  steps.each do |order|
    scripts = order[0].clone
    scripts.reverse! if options[:reverse]
    fightstyles = order[1].clone
    fightstyles.reverse! if options[:reverse]
    scripts.each do |script|
      fightstyles.each do |fightstyle|
        wow_classes.each do |wow_class|
          commands = to_run[script][wow_class].clone
          commands.reverse! if options[:reverse]
          commands.each do |command|
            next if command.start_with?("DS_") && fightstyle != "DS" || !command.start_with?("DS_") && fightstyle == "DS"
            if script == "Combinator" && command.include?("Azerite Azerite")
              azeriteStacks.each do |stacks|
                if stacks > 0
                  azCommand = command.gsub("Azerite Azerite", "#{stacks}A Azerite")
                else
                  azCommand = command.gsub("Azerite Azerite", "1A NoAzerite")
                end
                system "bundle exec ruby #{script}.rb #{fightstyle} #{wow_class} #{azCommand} q"
              end
              # Do an additional run of talents with just the default profile (no azerite overrides)
              azCommand = command.gsub("Azerite Azerite", "1A Simple")
              system "bundle exec ruby #{script}.rb #{fightstyle} #{wow_class} #{azCommand} q"
            else
              system "bundle exec ruby #{script}.rb #{fightstyle} #{wow_class} #{command} q"
            end
          end
        end
      end
    end
  end
end

### HAX: For display on HeroDamage, rename our DS reports to include T23 so they show as T23 fightstyle.
Dir.glob("#{SimcConfig["ReportsFolder"]}/*_DS_DS_*.{json,csv}").each do |file|
  puts "Renaming #{file} for T24..."
  File.rename(file, file.gsub(/_DS_DS_/, "_DS_T24_"))
end

puts "All batch simulations done! Press enter!"
gets
