if lockstep_stop
	exit

if show >= array_length(credittext) && !audio_is_playing(custom_sound_check(musCredits)) && instance_exists(Logo) {
    visible = 0

    with Logo
    visible = 0
}

if keyboard_check(vk_shift) if alarm[0] > 1 alarm[0] = 1