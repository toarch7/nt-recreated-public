/// @function scrAchievementUnlock
/// @param {Real|Enum.Achievement} achievement_id
function scrAchievementUnlock(_achievement_id) {
	assert(_achievement_id >= 0 && _achievement_id <= achievementmax)
	
    if save_get_value("achievement", string(_achievement_id)) exit
		
	if UberCont.opt_achievs {
	    with instance_create(instance_number(AchievementSplash), 0, AchievementSplash) {
	        str1 = chiev_name[_achievement_id]
	        str2 = chiev_text[_achievement_id]
	        ok = instance_number(AchievementSplash) <= 1
	        achiev = _achievement_id
	    }
	}
	
	save_set_value("achievement", string(_achievement_id), 1)
}

/// @function scrAchievementIsUnlocked
/// @param {Real|Enum.Achievement} achievement_id
function scrAchievementIsUnlocked(_achievement_id) {
	assert(_achievement_id >= 0 && _achievement_id <= achievementmax)
	return save_get_value("achievement", string(_achievement_id))
}