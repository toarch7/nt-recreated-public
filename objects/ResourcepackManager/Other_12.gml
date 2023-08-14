/// @description Draw browser

var m = 0.8,
	
	dx = view_width * (1 - m),
	dy = 36,
	
	xx = dx,
	yy = dy,
	
	width = floor(view_width * m / 2) - 2,
	height = 36 + wheel_value,
	
	stepX = width + 2,
	stepY = height + 4

draw_set_font(fntSmall)

DrawAlignDefault;

for(var i = 0; i < array_length(items); i ++) {
	var _y = yy - ypos
	
	if view_height - _y > 0 && _y < view_height {
		var item = items[i],
			meta = item.meta
		
		draw_sprite_stretched_ext(sprAchievementSplash, 0, xx, _y, width, height, c_black, 0.7)
		
		draw_set_color(c_white)
		
		var spr = icon_map[$ item.name],
			offset = height - 8
		
		if spr == undefined {
			//if array_length(sprites) < 5 {
				var url = "https://raw.githubusercontent.com/" + item.owner + "/" + item.name + "/" + (item[$ "branch"] ?? "main") + "/icon.png",
					
					spr = sprite_add(url, 1, 0, 0, 0, 0)
				
				array_push(sprites, spr)
				icon_map[$ item.name] = spr
				
				print("requesting for", item.name, spr, url)
			//}
			
			spr = mskNone
		}
		
		draw_text_nt(xx + 8 + offset, _y + 8, string(i) + ". " + meta.name + "\n" + string(xx) + " " + string(yy))
		
		draw_sprite_ext(
				spr, 0,
				
				xx + 4,
				_y + 4,
				
				offset / sprite_get_width(spr),
				offset / sprite_get_height(spr),
				
				0, c_white, 1)
	}
	
	xx += stepX
	
	if xx + width > view_width {
		yy += stepY
		xx = dx
	}
}

max_height = max(yy - dy * 5, 0) // oh god

draw_text(32, 96, string(array_length(items)) + "\n" + string(ypos) + "\n" + string(max_height))

draw_set_font(fntM1)

var w = wheel_value

if mouse_wheel_up()
	wheel_value ++

if mouse_wheel_down()
	wheel_value --

if wheel_value != w
	print(wheel_value)