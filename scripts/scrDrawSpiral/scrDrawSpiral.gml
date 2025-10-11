#macro LETTERBOX_SIZE 36

function scrDrawSpiral() {
	try {
        draw_set_color(c_black)

        var _is_menu;

        if !instance_is(self, Menu) {
			draw_clear(c_black)
			_is_menu = false
		}
		else {
			_is_menu = true
		}
		
        with Spiral {
            if !_is_menu && lanim > 0 && lanim < 6 {
                if lsound == 0 {
                    lsound = 1
					
					var _sound_index = asset_get_index("sndPortalLightning" + string(1 + irandom(7)))
					
					if audio_exists(_sound_index) {
						snd_play(_sound_index, 0.9 + random(0.2), 1)
	                }
				}

                draw_sprite_ext(sprPortalLightning, lanim, view_xview + x, view_yview + y, image_xscale, image_yscale, (image_angle + langle), c_white, 1)
                draw_sprite_ext(sprPortalLightning, lanim, view_xview + x, view_yview + y, image_xscale, image_yscale, (image_angle + langle), c_black, (0.4 - (image_xscale / 2)))
            }

            draw_sprite_ext(sprite_index, - 1, view_xview + x, view_yview + y, (image_xscale * 10), (image_yscale * 10), (image_angle + 45), c_white, 1)
            draw_sprite_ext(sprite_index, - 1, view_xview + x, view_yview + y, (image_xscale * 10), (image_yscale * 10), (image_angle + 45), c_black, (0.8 - image_xscale))
        }

        if !_is_menu {
            with SpiralDebris {
                if sprite_exists(sprite_index) {
                    draw_sprite_ext(sprite_index, - 1, view_xview + x, view_yview + y, image_xscale, image_yscale, image_angle, c_white, 1)
                    draw_sprite_ext(sprite_index, - 1, view_xview + x, view_yview + y, image_xscale, image_yscale, image_angle, c_black, (1 - image_xscale))
                }
            }
        }

        with SpiralStar {
            if sprite_exists(sprite_index) {
                draw_sprite_ext(sprite_index, - 1, view_xview + x, view_yview + y, image_xscale, image_yscale, image_angle, c_white, 1)
                draw_sprite_ext(sprite_index, - 1, view_xview + x, view_yview + y, image_xscale, image_yscale, image_angle, c_black, (1 - image_xscale))
            }
        }

        if !instance_exists(Nothing2) && !instance_exists(Nothing2Corpse) && !instance_exists(Nothing2Death) {
            with SpiralCont {
                var fishx = view_xview + x
                var fishy = view_yview + y

                if type == 4 or type == 3 {
                    fishx = view_xview + view_width / 2
                    fishy = view_yview + view_height / 2
                }

                if !instance_exists(Credits) {
                    if instance_exists(CrownObject) {
                        spr_crwn = asset_get_index((("sprCrown" + string(GameCont.crown)) + "Idle"))

                        if sprite_exists(spr_crwn) {
                            draw_sprite_ext(spr_crwn, 1, (fishx + lengthdir_x((15 + (sin((image_angle / 60)) * 4)), ((-image_angle) / 5.3))), (fishy + lengthdir_y((15 + (sin((image_angle / 60)) * 4)), ((-image_angle) / 5.3))), (0.6 + (sin((image_angle / 200)) / 4)), (0.6 + (sin((image_angle / 200)) / 4)), ((-image_angle) * 2.2), c_white, 1)
                        }
                    }

                    var n = 0

                    with Player {
                        other.image_angle += n * 50
                        var spr_player = spr_hurt
                        draw_sprite_ext(spr_player, 1, fishx + n * 8, fishy + n * 6, (0.8 + (sin((other.image_angle / 200)) / 5)), (0.8 + (sin((other.image_angle / 200)) / 5)), ((-other.image_angle) * 2), c_white, 1)
                        other.image_angle -= n * 50
                        n++
                    }
                }
            }
        }

        if !instance_exists(NothingSpiral) && !instance_exists(Credits) && (instance_exists(MainMenuButton) or instance_exists(Logo) or instance_exists(DailyList) or instance_exists(DrawStats) or instance_exists(AchievementsMenu) or instance_exists(MenuOptions) or instance_exists(CoopMenu) or instance_exists(Player) or instance_exists(PlayButton) or instance_exists(MakeGame)) {
            scrDrawLetterbox()
		}

        draw_set_color(c_white)
    }
	catch (e) {
        print_error(e.message)
    }
}

function scrDrawLetterbox(_size = LETTERBOX_SIZE) {
	var _left = view_xview,
		_top = view_yview,
		_right = _left + view_width,
		_bottom = _top + view_height
	
	// TODO: needs to be replaced with sprLetterbox
    draw_set_color(c_black)
    draw_rectangle(_left, _top, _right, _top + _size, 0)
    draw_rectangle(_left, _bottom, _right, _bottom - _size, 0)
    draw_set_color(c_white)
}
