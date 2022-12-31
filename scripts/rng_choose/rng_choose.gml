/// @description rng_choose(slot, ...)
/// @param slot
/// @param  ...
function rng_choose() {
    var ind = round(rng_rnd(argument[0], 1, argument_count - 1))
    return argument[ind]
}