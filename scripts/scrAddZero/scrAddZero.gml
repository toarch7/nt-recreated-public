/// @description scrAddZero(number,amount)
/// @param number
/// @param amount
function scrAddZero(argument0, argument1) {
    if argument0 < 0 argument0 = 0

    if string_length(string(argument0)) <= argument1 argument0 = "0" + string(argument0) if string_length(string(argument0)) <= argument1 argument0 = "0" + string(argument0)

    return string(argument0);



}