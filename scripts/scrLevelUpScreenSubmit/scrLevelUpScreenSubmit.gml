/// @function scrLevelUpScreenSubmit
/// @param selection_text
function scrLevelUpScreenSubmit(_selection_text=undefined) {
	if is_string(_selection_text) {
		var _ypos = view_yview + view_height - string_height(_selection_text) - 76
		with (instance_create(view_xview_center, _ypos, SkillText)) txt = _selection_text
	}
	
	instance_destroy(SkillIcon)
	instance_destroy(UltraIcon)
	instance_destroy(CrownIcon)
	instance_destroy(LevCont)

	if GameCont.skillpoints || GameCont.ultrapoints || GameCont.crownpoints {
	    instance_create(x, y, LevCont)
	}
	else {
	    instance_create(x, y, GenCont)
	}
	
	with (Player) scrUnlocksPlayerEquipment(id)
	
	scrSavegameSave()
}