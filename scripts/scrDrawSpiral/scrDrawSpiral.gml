function scrDrawSpiral() {
	try {
        draw_set_color(c_black)

        var is_menu = object_index == Menu

        if !is_menu {
            draw_rectangle(view_xview, view_yview, (view_xview + view_width), (view_yview + view_height), 0)
        }

        with Spiral {
            if !is_menu && lanim > 0 && lanim < 6 {
                if lsound == 0 {
                    lsound = 1
                    snd_play_pitch(choose(sndPortalLightning1, sndPortalLightning2, sndPortalLightning3, sndPortalLightning4, sndPortalLightning5, sndPortalLightning6, sndPortalLightning7, sndPortalLightning8), 0.2)
                }

                draw_sprite_ext(sprPortalLightning, lanim, view_xview + x, view_yview + y, image_xscale, image_yscale, (image_angle + langle), c_white, 1)
                draw_sprite_ext(sprPortalLightning, lanim, view_xview + x, view_yview + y, image_xscale, image_yscale, (image_angle + langle), c_black, (0.4 - (image_xscale / 2)))
            }

            draw_sprite_ext(sprite_index, - 1, view_xview + x, view_yview + y, (image_xscale * 10), (image_yscale * 10), (image_angle + 45), c_white, 1)
            draw_sprite_ext(sprite_index, - 1, view_xview + x, view_yview + y, (image_xscale * 10), (image_yscale * 10), (image_angle + 45), c_black, (0.8 - image_xscale))
        }

        if !is_menu {
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
                    if instance_exists(Crown) {
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
            var _w = 36

            if instance_exists(ResourcepackManager) _w = 32

            draw_set_color(c_black)
            draw_rectangle(view_xview, view_yview, view_xview + view_width, view_yview + _w, 0)
            draw_rectangle(view_xview, view_yview + view_height, view_xview + view_width, view_yview + view_height - _w, 0)
            draw_set_color(c_white)
        }

        draw_set_color(c_white)
    } catch (e) {
        print(e.message)
    }
}