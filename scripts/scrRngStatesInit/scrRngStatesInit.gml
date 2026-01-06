#macro rng_m 2147483647
#macro rng_a 1103515245
#macro rng_c 12345

enum RNGStates {
	Generation = 0,
	Enemies = 1,
	Props = 2,
	WeaponDrops = 3,
	Chest = 4,
	Skill = 5,
	Popo = 8,
	Pickups = 9,
	NUM_RNG_STATES
}

global.seed = 1
global.custom_seed = false

function scrRngStatesInit() {
	global.rng_states = array_create(RNGStates.NUM_RNG_STATES, 1)
	
	if global.custom_seed {
		global.seed = global.custom_seed
	}
    else if !UberCont.coop {
        global.seed = irandom(rng_m)
	}
	
    if UberCont.daily_run {
        if UberCont.weekly_run {
            global.seed = scrReal(UberCont.weekly_data[? "seed"])
        }
        else global.seed = UberCont.daily_seed
		
		global.custom_seed = false
    }
    else {
		if UberCont.opt_practice && global.custom_seed > 0 {
			global.seed = global.custom_seed
		}
        else if file_exists(game_directory + "seed.txt") {
            global.custom_seed = true

            var file = file_text_open_read(game_directory + "seed.txt")
            global.seed = scrGenerateUID(file_text_read_string(file), true)
			
            file_text_close(file)

            show_debug_message("Custom seed: " + string(global.seed))
        }
        else if instance_exists(Console) && Console.seed != undefined {
            global.seed = scrGenerateUID(Console.seed, true)
            global.custom_seed = true
        }
		else global.custom_seed = false
    }
	
	scrRngStatesReset()
}
