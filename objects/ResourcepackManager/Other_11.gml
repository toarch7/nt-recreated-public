/// @description Draw browser

var xx = 8,
	yy = 40,
	
	mx = device_mouse_x_to_gui(0),
	my = device_mouse_y_to_gui(0),
	
	width = pack_width,
	height = 36,
	
	stepY = height + 4

scrDrawAlignDefault()

var start = ypos div 40,
	count = min(array_length(items), start + 5)

if last_min < start or last_max > count {
	if !dragging
		sound_play_pitchvol(sndHover, 1.1 + random(0.1), 0.3)
	
	last_min = start
	last_max = count
}

var dx = xx + width * 0.75 + 10

for(var i = start; i < count; i ++) {
	var item = items[i],
		meta = item.meta,
		_y = start * stepY - ypos + yy
	
	draw_sprite_stretched_ext(sprAchievementSplash, 0, xx, _y, width, height, c_black, 0.75)
		
	draw_set_color(c_white)
		
	var spr = icon_map[$ item.name],
		avatar = icon_map[$ "avatar:" + string(item.owner)],
		offset = height - 8
		
	if spr == undefined {
		spr = mskNone
		
		if item[$ "hasIcon"] {
			var url = "https://raw.githubusercontent.com/" + item.full_name + "/" + (item[$ "branch"] ?? "main") + "/icon.png",
				spr = sprite_add(url, 1, 0, 0, 0, 0)
			
			array_push(sprites, spr)
		}
		else {
			spr = sprResourcepackDefault
		}
		
		icon_map[$ item.name] = spr
	}
	
	if avatar == undefined {
		avatar = sprite_add("https://github.com/" + string(item.owner) + ".png?size=40", 1, 0, 0, 0, 0)
		
		array_push(sprites, avatar)
		
		icon_map[$ "avatar:" + string(item.owner)] = avatar
	}
	
	draw_text_shadow(xx + 8 + offset, _y + 8, meta.name)
	
	draw_set_color(c_white)
	
	draw_text_ext_transformed(xx + 12 + offset, _y + 20, meta.descriptionShort, 8, width - 8, 0.5, 0.5, 0)
	
	var update_text = "LONG#AGO"
	
	var updated = item.updated / 1000,
		time_current = unix_timestamp(),
		diff = time_current - updated
	
	if item[$ "promoted"]
		update_text = "NEW!"
	else if diff < 10800
		update_text = "JUST NOW"
	else if diff < 86400
		update_text = "TODAY"
	else if diff < 172800
		update_text = "YESTERDAY"
	else if diff < 259200
		update_text = "RECENTLY"
	else if diff < 604800
		update_text = "THIS#WEEK"
	else {
		var days = round(diff / 86400)
		
		if days < 365 {
			update_text = string_replace(loc("% D."), "%", string(days))
		}
	}
	
	draw_set_valign(fa_middle)
	draw_set_halign(fa_center)
	
	// Update
	if item.promoted {
		var str = loc(update_text),
			w = string_width(str)
		
		draw_sprite_stretched_ext(sprAchievementSplash, 0, dx + 52 - w / 2, _y + 2, w, 14, c_aqua, 0.3)
		
		draw_text_shadow_scale(dx + 54, _y + 9, str, 0.75)
	}
	else {
		draw_sprite_ext(sprResourcepackBrowserSort, 1, dx + 36, _y + 8, 0.75, 0.75, 0, c_white, 1)
		draw_text_shadow_scale(dx + 64, _y + 9, loc(update_text), 0.75)
	}
	
	// Stars
	draw_sprite_ext(sprResourcepackBrowserSort, 0, dx, _y + 8, 0.75, 0.75, 0, c_white, 1)
	draw_text_shadow_scale(dx + 12, _y + 9, string(min(99, item.stars)), 0.75)
	
	draw_set_halign(fa_left)
	
	var a = 0
	
	if spr == sprResourcepackDefault
		a = i
	
	if sprite_get_width(spr) > 1 {
		draw_sprite_ext(
			spr, a,
			
			xx + 4,
			_y + 4,
			
			offset / sprite_get_width(spr),
			offset / sprite_get_height(spr),
			
			0, c_white, 1)
	}
	else {
		draw_sprite(sprSaving, (get_timer() / 33333) * 0.5, xx + 18, _y + 18)
	}
	
	draw_sprite_ext(avatar, 0, dx - 12, _y + 20, 12 / sprite_get_width(avatar), 12 / sprite_get_height(avatar), 0, c_white, 1)
	draw_text_shadow_scale(dx + 4, _y + 28, item.owner, 0.65)
	
	draw_set_valign(fa_top)
	
	yy += stepY
}


