/// @description rng_init()

// custom rng system
// which separates various random native gml function calls
// during such things as level generation
// to be honest this thing should be undone

global.custom_seed = 0
global.seed = 0

function rng_init() {
    global.rng_m = int64(2147483647)
    global.rng_a = 1103515245
    global.rng_c = 12345

    if !global.coop {
        global.seed = randomize()
    }

    global.custom_seed = 0

    if UberCont.daily_run {
        if UberCont.weekly_run {
            global.seed = scrReal(UberCont.weekly_data[? "seed"])
        }
        else global.seed = UberCont.daily_seed
    }
    else {
        if file_exists(game_directory + "seed.txt") {
            global.custom_seed = 1

            var file = file_text_open_read(game_directory + "seed.txt")
            global.seed = file_text_read_real(file)
            file_text_close(file)

            show_debug_message("Custom seed: " + string(global.seed))
        }
        else if instance_exists(Console) && Console.seed != undefined {
            global.seed = scrReal(Console.seed)
            global.custom_seed = 1
        }
    }

    for (var i = 0; i <= 12; i++)
    global.rng_state[i] = global.seed

    //0 - generation
    //1 - enemies
    //2 - props
    //3 - decide weapon
    //4 - chests
    //5 - mutations
    //6 - ?
    //7 - ?
    //8 - popo?
    //9 - pickups (not sure if these need seeding)

    random_set_seed(global.seed)
}