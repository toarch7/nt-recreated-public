/// @function scrLevelUpScreenSubmit
/// @param selection_text
function scrLevelUpScreenSubmit(_selection_text=undefined) {
	instance_destroy(SkillIcon)
	instance_destroy(LevCont)

	if GameCont.skillpoints || GameCont.ultrapoints || GameCont.crownpoints {
	    instance_create(x, y, LevCont)
	}
	else {
	    instance_create(x, y, GenCont)
	}
	
	if is_string(_selection_text) {
		with instance_create(0, 0, SkillText) {
		    txt = _selection_text
		}
	}
	
	scrGameSave()
}