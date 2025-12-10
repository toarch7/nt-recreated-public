/// @function scrDecideSkill
/// @param return_default=false
function scrDecideSkill(_return_default=false) {
	var _skill = -1
	
    repeat (100) {
        _skill = irandom(maxskill)
        
        with SkillIcon {
            if (skill == _skill) _skill = -1
        }
		
		if scr_skill_can_appear(_skill) return _skill
    }
	
	return _return_default ? mut_last_wish : -1
}