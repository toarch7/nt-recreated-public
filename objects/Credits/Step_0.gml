if lockstep_stop
	exit

var _force = false

if (show >= array_length(credittext) && !audio_is_playing(custom_sound_check(musCredits)) && instance_exists(Logo)) {
    with (Logo) {
		visible = false
	}
	visible = false
}

//
if (scr_keyboard_check_held(vk_shift)) timer = 0

//
if (mouse_ui_clicked() && timer > 0 && (!is_touch() || scroll_speed == 0)) {
	_force = true
}

if (largetext) {
	if (mouse_wheel_down()) {
		if (scroll_speed) scroll_speed = 0
		scroll_speed -= 7.5
	}
	if (mouse_wheel_up()) {
		if (!scroll_speed) scroll_speed = 0
		scroll_speed += 7.5
	}
}

if (scroll_speed != 0) {
	scroll = clamp(scroll + scroll_speed, 0, height)
	scroll_speed = t_lerp(scroll_speed, 0, 0.2)
	scroll_delay = 29
}

if (scroll_delay > 0 && scroll > 0) scroll_delay -= timescale

if ((_force || timer > 0) && !instance_exists(Logo)) {
	if (scroll > 0 || scroll_delay > 0) {
		if (!scroll_delay) {
			scroll -= timescale
			timer = min(5, scroll)
		}
		else timer = 5
	}
	else {
		timer -= timescale
	}
	
	if (_force || !timer) {
		if ((show + 2) >= array_length(credittext)) {
			with instance_create(0, 0, Logo) {
				image_index = 7
				alarm[0] = -1
				alarm[1] = -1
			}
		}
		else {
			show ++
			text = credittext[show]
			
			height = font_get_string_height(text)
			
			if (height > (gui_h - LETTERBOX_SIZE)) {
				largetext = true
				height += gui_h
				scroll = height
			}
			else {
				scroll = 0
				largetext = false
			}
			timer = 180
		}
		
		if (instance_exists(Logo) || !visible) {
			visible = false
			exit
		}
		
		if (instance_exists(SpiralCont) && ((show >= 2 && show <= 7) || show == 11)) {
			with (instance_create(SpiralCont.x, SpiralCont.y, SpiralDebris)) {
				depth = -10000
				sprite_index = sprCreditsTeam
				image_index = ((other.show != 11) ? (other.show - 2) : 6)
				image_speed = 0
				visible = true
			}
		}
	}
}