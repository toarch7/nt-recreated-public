/// @description save_set_val(section,key,value)
/// @param section
/// @param key
/// @param value
function save_set_val() {
    UberCont.saveData[? string(argument[0]) + "_" + string(argument[1])] = argument[2]
}