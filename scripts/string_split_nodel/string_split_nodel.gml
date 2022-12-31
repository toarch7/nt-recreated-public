/// @description string_split_nodel(string)
/// @param string
function string_split_nodel(argument0) {
    ds_list_clear(global.string_split_list)
    result = global.string_split_list
    max_pos = string_length(argument0)
    pos = 1
    str = argument0

    while pos <= max_pos {
        ds_list_add(result, string_copy(str, pos, 1))
        pos++
    }

    return result



}