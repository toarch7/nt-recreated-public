/// @description skill_get(skill)
/// @param skill
function skill_get(argument0) {
    if !instance_exists(GameCont) return 0
    return ds_list_find_index(GameCont.skills, argument0) >= 0



}