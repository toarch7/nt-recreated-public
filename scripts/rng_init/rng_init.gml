/// @description rng_init()

// custom rng system
// which separates various random native gml function calls
// during such things as level generation
// to be honest this thing should be undone

global.custom_seed = 0
global.seed = 0

#macro rng_m 2147483647
#macro rng_a 1103515245
#macro rng_c 12345

enum RNGSlot {
	
	Generation = 0,
	Enemies = 1,
	Props = 2,
	Drops = 3,
	Chest = 4,
	Skill = 5,
	
	Popo = 8,
	Pickups = 9,
	
	Count
}

function rng_init() {
	if global.custom_seed {
		global.seed = global.custom_seed
	}
    else if !global.coop
        global.seed = irandom(rng_m)
	
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
	
    random_set_seed(global.seed)

	rng_reset()
}
