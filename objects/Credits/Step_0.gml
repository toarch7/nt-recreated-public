if lockstep_stop
	exit

if show >= array_length(credittext) && !audio_is_playing(custom_sound_check(musCredits)) && instance_exists(Logo) {
    with (Logo) {
		visible = false
	}
	visible = false
}

if (scr_keyboard_check_held(vk_shift)) {
	if (alarm[0] > 1) alarm[0] = 1
}