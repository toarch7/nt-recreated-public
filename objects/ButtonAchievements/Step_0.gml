if lockstep_stop
	exit

event_inherited()

x = view_xview + view_width - sprite_width + 18
y = view_yview + LETTERBOX_SIZE + 12

if hover {
	if (mask_index == mskButtonAchievements) mask_index = mskButtonAchievementsMax
}
else {
	if (mask_index == mskButtonAchievementsMax) mask_index = mskButtonAchievements
}