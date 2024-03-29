globalvar race_string_ids, race_numeric_ids;

// todo: remove parse after engine update
race_string_ids = {}

race_string_ids[$ "0"] = "random"
race_string_ids[$ "1"] = "fish"
race_string_ids[$ "2"] = "crystal"
race_string_ids[$ "3"] =  "eyes"
race_string_ids[$ "4"] = "melting"
race_string_ids[$ "5"] =  "plant"
race_string_ids[$ "6"] = "skeleton"
race_string_ids[$ "7"] = "steroids"
race_string_ids[$ "8"] = "robot"
race_string_ids[$ "9"] = "chicken"
race_string_ids[$ "10"] = "rebel"
race_string_ids[$ "11"] = "horror"
race_string_ids[$ "12"] = "rogue"
race_string_ids[$ "13"] = "bigdog"
race_string_ids[$ "14"] = "skeleton"
race_string_ids[$ "15"] = "frog"
race_string_ids[$ "16"] = "cuz"
race_string_ids[$ "17"] = "reserved"
race_string_ids[$ "18"] = "reserved"

var keys = struct_keys(race_string_ids)

race_numeric_ids = {}

for(var i = 0; i < array_length(keys); i ++) {
	var key = keys[i]
	
	race_numeric_ids[$ key] = race_string_ids[$ key]
}


function scrRaces() {
    race_name[0] = "RANDOM"
    race_pass[0] = ""
    race_acti[0] = ""
    race_butt[0] = ""
    race_lock[0] = ""
    skin_lock[0] = ""

    race_name[1] = "FISH"
    race_pass[1] = "@wGETS MORE @yAMMO"
    race_acti[1] = "@wCAN ROLL"
    race_butt[1] = "WATER BOOST"
    race_lock[1] = "UNLOCKED FROM THE START"
    race_swep[1] = 1
    skin_lock[1] = "Loop with every character"

    race_name[2] = "CRYSTAL"
    race_pass[2] = "@wHAS MORE @rHP"
    race_acti[2] = "@wCRYSTAL SHIELD"
    race_butt[2] = "TELEPORTATION"
    race_lock[2] = "UNLOCKED FROM THE START"
    race_swep[2] = 1
    skin_lock[2] = "Reach 4-?"

    race_name[3] = "EYES"
    race_pass[3] = "@wSEES @wIN THE @wDARK"
    race_acti[3] = "@wTELEKINESIS"
    race_butt[3] = "STRONGER TELEKINESIS"
    race_lock[3] = "REACH THE SEWERS"
    race_swep[3] = 1
    skin_lock[3] = "Reach 2-?"

    race_name[4] = "MELTING"
    race_pass[4] = "@wLESS @rHP@w, MORE @gRADS"
    race_acti[4] = "@wEXPLODE CORPSES"
    race_butt[4] = "BIGGER CORPSE EXPLOSIONS"
    race_lock[4] = "DIE"
    race_swep[4] = 1
    skin_lock[4] = "Beat the Throne without#Rhino Skin and Strong Spirit"

    race_name[5] = "PLANT"
    race_pass[5] = "@wMOVES FASTER"
    race_acti[5] = "@wTRAPS @wENEMIES"
    race_butt[5] = "SNARE FINISHES ENEMIES#IN UNDER 33% @rHP"
    race_lock[5] = "REACH THE SCRAPYARD"
    race_swep[5] = 1
    skin_lock[5] = "Beat the Throne#in under 10 minutes"

    race_name[6] = "Y.V."
    race_pass[6] = "@wHIGHER @wRATE OF FIRE"
    race_acti[6] = "@wPOP POP"
    race_butt[6] = "BRRRAP"
    race_lock[6] = "REACH 3-?"
    race_swep[6] = 39
    skin_lock[6] = "Unlock Golden Weapon#for every character"

    race_name[7] = "STEROIDS"
    race_pass[7] = "@wFULLY @wAUTOMATIC WEAPONS@w, LESS @wACCURATE"
    race_acti[7] = "@wDUAL WIELDING"
    race_butt[7] = "DUAL FIRING MAY GIVE AMMO SOMETIMES"
    race_lock[7] = "REACH THE LABS"
    race_swep[7] = 1
    skin_lock[7] = "Defeat 6-1 Boss"

    race_name[8] = "ROBOT"
    race_pass[8] = "@wFINDS @wBETTER TECH"
    race_acti[8] = "@wEAT GUNS"
    race_butt[8] = "BETTER GUN NUTRITION"
    race_lock[8] = "REACH THE FROZEN CITY"
    race_swep[8] = 1
    skin_lock[8] = "Eat any Hyper weapon"

    race_name[9] = "CHICKEN"
    race_pass[9] = "@wHARD TO KILL"
    race_acti[9] = "@wTHROW WEAPONS"
    race_butt[9] = "THROWN WEAPONS CAN PIERCE ENEMIES"
    race_lock[9] = "REACH 5-?"
    race_swep[9] = 46
    skin_lock[9] = "Reach 2-1 H1"


    race_name[10] = "REBEL"
    race_pass[10] = "@wPORTAL @rHEALS"
    race_acti[10] = "@wSPAWN ALLIES"
    race_butt[10] = "HIGHER ALLY RATE OF FIRE"
    race_lock[10] = "??? THE GAME"
    race_swep[10] = 1
    skin_lock[10] = "Defeat 2-1 Boss"

    race_name[11] = "HORROR"
    race_pass[11] = "@wEXTRA @gMUTATION CHOICE"
    race_acti[11] = "@gRAD@w BEAM"
    race_butt[11] = "GAIN @rHP@s WHEN USING#@gBEAM@s FOR A LONG TIME"
    race_lock[11] = "DEFEAT WILD HORROR"
    race_swep[11] = 1
    skin_lock[11] = "Defeat 4-1 Boss"

    race_name[12] = "ROGUE"
    race_pass[12] = "@wBLAST @wARMOR"
    race_acti[12] = "@bPORTAL @wSTRIKE"
    race_butt[12] = "BIGGER PORTAL STRIKES"
    race_lock[12] = "DEFEAT THE NUCLEAR THRONE"
    race_swep[12] = 81
    skin_lock[12] = "Defeat ???"

    racemax = 12

    race_name[13] = "BIG DOG"
    race_pass[13] = "BIG"
    race_acti[13] = "DOG"
    race_butt[13] = "FASTER ROCKETS"
    race_lock[13] = "BEAT THE BIG DOG"
    race_swep[13] = 108
    skin_lock[13] = "EMBRACE ETERNITY"

    race_name[14] = "SKELETON"
    race_pass[14] = "@wLESS @rHP@w, LESS SPEED"
    race_acti[14] = "BLOOD GAMBLE"
    race_butt[14] = "BETTER ODDS"
    race_lock[14] = "SECRET CHARACTER"
    race_swep[14] = 56
    skin_lock[14] = "NO SKIN"

    race_name[15] = "FROG"
    race_pass[15] = "CAN'T STAND STILL"
    race_acti[15] = "TOXIC GASES"
    race_butt[15] = "TOXIC SPREADS FASTER"
    race_lock[15] = "SECRET CHARACTER"
    race_swep[15] = 255
    skin_lock[15] = "NO SKIN"

    race_name[16] = "CUZ"
    race_pass[16] = "PLACEHOLDER"
    race_acti[16] = "PLACEHOLDER"
    race_butt[16] = "PLACEHOLDER"
    race_lock[16] = "CANNOT BE UNLOCKED"
    race_swep[16] = wep_golden_revolver
    skin_lock[16] = "NO SKIN"

    race_name[17] = "EXPANSION REQUIRED"
    race_pass[17] = "EXPANSION VERSION IS REQUIRED"
    race_acti[17] = "TO PLAY THIS CHARACTER"
    race_butt[17] = ""
    race_lock[17] = ""
    race_swep[17] = 1
    skin_lock[17] = "NO SKIN"

    race_name[18] = "EXPANSION REQUIRED"
    race_pass[18] = "EXPANSION VERSION IS REQUIRED"
    race_acti[18] = "TO PLAY THIS CHARACTER"
    race_butt[18] = ""
    race_lock[18] = ""
    race_swep[18] = 1
    skin_lock[18] = "NO SKIN"
}