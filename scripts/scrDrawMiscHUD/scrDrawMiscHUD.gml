function scrDrawMiscHUD() {
	if (!instance_exists(Menu) && !(instance_exists(GameOver) && win)
		&& !instance_exists(MenuOptions) && !(instance_exists(Credits) && Credits.visible)
	) {
		var _cheat_scale = 1,
			_font_offset = font_get_height_diff(),
			_low_x = 16 * _cheat_scale,
			_low_y = view_height - (_font_offset + 10), //10) * _cheat_scale,
			_gamecont_text_drawn = false
		
		draw_set_color(c_white)
		
		draw_align(fa_right, fa_top)
		if UberCont.opt_showtimer {
			draw_text_nt(view_width - 2, _low_y, timer_string)
			_low_y -= font_get_string_height(timer_string)
			_gamecont_text_drawn = true
		}
		
		if UberCont.opt_showarea && !instance_exists(GenCont) && (!scrGameIsPaused() || UberCont.bossintro) && room == romGame {
			var _area_string = scrAreaGetMapName(GameCont.area, GameCont.subarea, GameCont.loops)
			draw_text_nt(view_width - 2, _low_y, _area_string)
			_low_y -= font_get_string_height(_area_string)
			_gamecont_text_drawn = true
		}
		draw_align()
	
		if (global.cheats || scr_debug_cheats_enabled()) {
			var _cheats;
			
			with (UberCont) _cheats = [
				global.__debug_immortality,
				global.__debug_infammo,
				global.__debug_noreload,
				opt_griller,
				opt_practice
			]
			
			var _count = array_length(_cheats)
			
			_low_y -= (!_gamecont_text_drawn && (scrGameIsPaused() || UberCont.version_text_drawn)) ? 16 : 8
			
			if (_count == 0) {
				draw_set_font(fntSmaller)
				draw_align(fa_right, fa_middle)
				
				var _string = "[cheats]"
				draw_text_nt(view_width - _low_x, _low_y, _string)
				
				_low_x -= font_get_string_width(_string)
				
				draw_reset_font()
				draw_align()
			}
			else {
				for(var i = 0; i < _count; i ++) {
					if (!_cheats[i]) continue
					
					draw_sprite_ext(sprCheatIndicatorHUD, i,
						view_width - _low_x, _low_y, _cheat_scale, _cheat_scale, 0, c_white, 1)
					
					_low_x += 16 * _cheat_scale
				}
			}
		}
	}
	
    if instance_exists(GameOver) || instance_exists(Player) || scrGameIsPaused() || room == romInit {
		// Ultras
		var _ultra_list = ultra_hud,
			_ultra_count = array_length(_ultra_list),
			_px = view_width - 12,
			_py = 13
		
		for(var i = 0; i < _ultra_count; ++i) {
			draw_sprite(sprEGIconHUD, _ultra_list[i], _px, _py)
			_px -= 16
			
			if _px <= 120 {
				_px = view_width - 12
				_py += 16
			}
		}
		
		// Skills
		_py --
		
		var _skill_count = ds_list_size(skills), _pos = 0
        for (var i = 0; i < _skill_count; ++i) {
            var _skill = skills[| i]
            
			if (_skill == patienceskill) continue
			
            if _skill == mut_patience {
                if patienceskill {
                    draw_sprite(sprSkillIconHUD, patienceskill, _px, _py)
                    draw_sprite(sprPatienceIconHUD, 0, _px, _py)
                }
				else {
					draw_sprite(sprSkillIconHUD, _skill, _px, _py)
				}
            }
			else {
				draw_sprite(sprSkillIconHUD, _skill, _px, _py)
			}
			
			_px -= 16
			if _px <= 120 {
				_px = view_width - 12
				_py += 16
			}
        }
    }
}


