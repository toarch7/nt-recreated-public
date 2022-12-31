/// @description save_get_val(section,key,default)
/// @param section
/// @param key
/// @param default
function save_get_val() {
    var _datakey_ = string(argument[0]) + "_" + string(argument[1])
    var __v__ = UberCont.saveData[? _datakey_]

    if is_undefined(__v__) {
        __v__ = argument[2]
    }

    return __v__
}