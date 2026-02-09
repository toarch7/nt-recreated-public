/// @description Render & selection

var	_start_x = gui_w div 6,
	_start_y = LETTERBOX_SIZE + 40,
	_half = LETTERBOX_SIZE div 2,
	_drawx = _start_x,
	_drawy = -scroll + _start_y,
	_width = gui_w - _drawx,
	_height = gui_h,
	_xstep = sprite_get_width(sprSkillIcon) + 4,
	_ystep = sprite_get_height(sprSkillIcon) + 4,
	_mx = gui_x,
	_my = gui_y,
	_ypos = 0,
	_any = false

draw_align(fa_center, fa_middle)

var _dx = gui_w div 2,
	_dy = _drawy - 30,
	_count = scrCustomModeCountMutations()

deferred_draw = undefined

draw_sprite(sprCustomModeWeaponSplat, 0, _dx, _dy)
draw_text_nt(_dx, _dy + 6, loc_fmt("CustomMode.Skill.Start:Selected", "SELECTED %", _count))

var _mutlist = scrCustomParam("skill_start"),
	_half_w = 1 + sprite_get_width(sprSkillIcon) div 2,
	_half_h = 1 + sprite_get_height(sprSkillIcon) div 2

tooltip_pop = approach(tooltip_pop, 0, timescale)

for(var i = 1; i <= maxskill; ++i) {
	var _dx = _drawx,
		_dy = _drawy + _ypos,
		_enabled = array_contains(_mutlist, i),
		_pointed = (!dragging && point_in_rectangle(_mx, _my,
			_dx - _half_w, _dy - _half_h, _dx + _half_w - 1, _dy + _half_h - 1)),
		_color = ((_enabled || _pointed) ? (_enabled ? c_white : c_silver) : c_gray)
	
	if (_enabled) {
		draw_rectangle(_dx - _half_w, _dy - _half_h,
				_dx + _half_w - 1, _dy + _half_h - 1, false)
	}
	
	draw_sprite_ext(sprSkillIcon, i, _dx, _dy, 1, 1, 0, _color, 1)
	
	if (_enabled) {
		draw_sprite(sprCustomModeWeaponYes, 0, _dx, _dy)
	}
	
	if (_pointed && _my > LETTERBOX_SIZE && _my < (_height - LETTERBOX_SIZE)) {
		_any = true
		
		if (hovered_mutation != i) {
			hovered_mutation = i
			hover_duration = 0
			tooltip_pop = 1
		}
		else if (hover_duration < 30) {
			hover_duration += timescale
		}
		
		if (option_selected == i) {
			var _name = loc("Skills", i, "Name", scr_skill_get_name(i)),
				_text = loc("Skills", i, "Text", scr_skill_get_text(i))
			
			scrDrawTooltip(_dx, _dy - _half_h, _name, tooltip_pop, true)
			
			if (hover_duration >= 14) {
				var _ty = gui_h - LETTERBOX_SIZE div 2
				
				deferred_draw = method({
						"text": _text, "pos": _ty,
						"hover_duration": hover_duration
					},
					function() {
						if (hover_duration < 15) {
							snd_play(sndMutAppear)
							hover_duration =  15
							pos ++
						}
						
						draw_align(fa_center, fa_middle)
						draw_text_nt(gui_w div 2, pos, "@s" + text)
						draw_align()
					})
			}
		}
		
		if (mouse_ui_clicked()) {
			if (!is_touch()) option_selected = i
			
			if (_pointed && option_selected == i) {
				snd_play(sndClick, 1.1, 0.5)
				
				if (_enabled) {
					snd_play(sndMutant0Slct, 1, 0.5)
					var _index = array_get_index(_mutlist, i)
					array_delete(_mutlist, _index, 1)
				}
				else {
					snd_play(sndMutant0Cnfm, 1, 0.5)
					array_push(_mutlist, i)
				}
			}
			else if (_pointed) {
				option_selected = i
				snd_play(sndMutAppear)
			}
		}
	}
	
	_drawx += _xstep
	if (_drawx >= _width) {
		_drawx = _start_x
		_ypos += _ystep
	}
}

draw_align()

if (!_any) {
	if (mouse_ui_clicked()) {
		option_selected = -1
	}
	hovered_mutation = -1
	hover_duration = 0
}

free_touch = _any

height = _ypos + LETTERBOX_SIZE + 16
if ((height - _height) < 20) height = 0