/// @description skill_set(skill, value)
/// @param skill
/// @param  value
function skill_set(skill, value) {
    if value {
        if !skill_get(skill) {
            ds_list_add(GameCont.skills, skill)

            if instance_exists(LevCont) && LevCont.placeonpatience {
                GameCont.patienceskill = skill
            }
        }
    } else if skill_get(skill) {
        ds_list_delete(GameCont.skills, ds_list_find_index(GameCont.skills, skill))

        if GameCont.patienceskill == skill {
            GameCont.patienceskill = 0
        }
    }
}