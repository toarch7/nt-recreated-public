global.inputDelay = 2

function scrCanInput() {
    return 1 //round(get_timer() / 33333) % 30 >= global.inputDelay
}