/// @description Draw browser

var xx = 8 - splat * 100,
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
	
	self.sprites_cleanup()
}

var dx = xx + width * 0.75 + 10,
	press = mouse_ui_clicked()

if (my < 40 or my > view_height - 40)
or wait or speed or scroll or show_details
	press = false

if wait
	wait --

if press && mx_last != 0 && my_last != 0 {
	if point_distance(mx, my, mx_last, my_last) > 10
		press = false
}

for(var i = start; i < count; i ++) {
	var item = items[i],
		meta = browsing ? item.meta : item,
		_y = start * stepY - ypos + yy
	
	draw_sprite_stretched_ext(sprAchievementSplash, 0, xx, _y, width, height, c_black, 0.75)
		
	draw_set_color(c_white)
		
	var spr = icon_map[$ item.full_name],
		avatar = icon_map[$ "avatar:" + string(item.owner)],
		offset = height - 8
		
	if spr == undefined or !sprite_exists(spr) {
		spr = mskNone
		
		if item[$ "hasIcon"] {
			var url = "https://raw.githubusercontent.com/" + item.full_name + "/" + (item[$ "branch"] ?? "main") + "/icon.png"
			
			if !browsing && is_string(item[$ "path"])
				url = item.path + "icon.png"
			
			spr = sprite_add(url, 1, 0, 0, 0, 0)
			
			array_insert(sprites, 0, spr)
		}
		else {
			spr = sprResourcepackDefault
		}
		
		icon_map[$ item.full_name] = spr
	}
	
	if item.owner != "local" {
		if (avatar == undefined or !sprite_exists(avatar)) {
			avatar = sprite_add("https://github.com/" + string(item.owner) + ".png?size=40", 1, 0, 0, 0, 0)
			
			array_insert(sprites, 0, avatar)
			
			icon_map[$ "avatar:" + string(item.owner)] = avatar
		}
	}
	else avatar = mskNone
	
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
			update_text = string_replace(loc("% D.#AGO"), "%", string(days))
		}
	}
	
	draw_set_valign(fa_middle)
	draw_set_halign(fa_center)
	
	if item.external {
		// Update
		if item.promoted {
			var str = loc(update_text),
				w = string_width(str)
			
			draw_sprite_stretched_ext(sprAchievementSplash, 0, dx + 52 - w / 2, _y + 2, w, 14, c_aqua, 0.3)
			
			draw_text_shadow_scale(dx + 54, _y + 9, str, 0.75)
		}
		else {
			draw_sprite_ext(sprResourcepackBrowserSort, 1, dx + 36, _y + 8, 0.75, 0.75, 0, c_white, 1)
			draw_text_shadow_scale(dx + 64, _y + 9, loc(update_text), 0.67)
		}
		
		// Stars
		draw_sprite_ext(sprResourcepackBrowserSort, 0, dx, _y + 8, 0.75, 0.75, 0, c_white, 1)
		draw_text_shadow_scale(dx + 12, _y + 9, string(min(99, item.stars)), 0.67)
	}
	
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
	
	if !browsing && item[$ "priority"] != undefined {
		var change = 0
		
		draw_sprite(sprLoadoutArrow, 0, dx - 20, _y + 24)
		draw_sprite(sprLoadoutArrow, 1, dx - 20, _y + height)
		
		if press {
			if point_in_circle(mx, my, dx - 32, _y + 12, 12) {
				change = 1
			}
			else if point_in_circle(mx, my, dx - 32, _y + 28, 12) {
				change = -1
			}
			
			if change != 0 {
				item.priority += change
				
				file_write(item.path + "githubdata.json", json_stringify(item))
				
				press = false
				reload_needed = true
				snd_play(sndClick)
			}
		}
		
		draw_set_halign(fa_right)
		draw_set_valign(fa_middle)
		draw_text_shadow(dx - 44, _y + 18, string(item.priority))
		draw_set_halign(fa_left)
	}
	
	draw_set_valign(fa_top)
	
	
	if press && point_in_rectangle(mx, my, xx, _y, xx + width, _y + height) {
		clicked_item = item
		touch_duration = 1
	}
	
	yy += stepY
}

if touch_duration {
	touch_duration --
	
	if !touch_duration && !speed {
		if !browsing && is_string(clicked_item[$ "path"]) {
			if !directory_exists(clicked_item.path) {
				array_delete(Resourcepacks, array_indexof(Resourcepacks, clicked_item), 1)
				
				error = "PACK FILES ARE AMISS"
				
				exit
			}
		}
		
		snd_play(sndMenuLoadout)
		
		self.screenshots_cleanup()
		
		text_scroll = 0
		
		url_pointed = false
		show_details = true
		open_time = 0
		
		screenshot_view = false
		screenshot_image = -1
	}
}

