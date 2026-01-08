/// @description Draw details


var mx = device_mouse_x_to_gui(0),
	my = device_mouse_y_to_gui(0),
	
	L = LF("ResourcepackBrowser")

var item = clicked_item,
	owner = string(item.owner),
	meta = browsing ? item.meta : item,
	off = (1 - splat / (sprite_get_number(sprLoadoutOpen) - 1)) * 5,
	xoff = off * 90,
	scale = off / 30,
	tooltip = undefined,
	tooltip_x = 0,
	tooltip_y = 0

var icon = icon_map[$ item.full_name] ?? mskNone,
	avatar = icon_map[$ "avatar:" + owner] ?? mskNone

if sprite_exists(icon)
	draw_sprite_ext(icon, 0, 12 - xoff, 48, 32 / sprite_get_width(icon) + scale, 32 / sprite_get_height(icon) - scale, 0, c_white, 1)

draw_sprite_ext(avatar, 0, 12 - xoff, view_height - 48, 12 / sprite_get_width(avatar) + scale / 5, 12 / sprite_get_height(avatar) - scale / 5, 0, c_white, 1)

draw_set_color(url_pointed ? c_aqua : 0xdf6116)
var lx = 32 - xoff,
	ly = view_height - 38

var fname = item.full_name

if string_length(fname) > 50
	fname = string_copy(fname, 1, 47) + "..."

var width = font_get_string_width(fname) * 0.75

if item.external {
	draw_text_nt(lx, ly - 8 - url_pointed, fname + " @(sprTextLinkURL,0,0,-2)", 0.75)
	draw_sprite_stretched_ext(sprPixel, 0, lx, ly + 1, width, 1, draw_get_color(), 1)

	if !screenshot_view && point_in_rectangle(mx, my + 8, lx, ly, lx + width, ly + 8) {
		/// @loc:token [ResourcepackBrowser] FullviewOpenGitHub "SEE GITHUB PAGE"
		tooltip = L("FullviewOpenGitHub", "SEE GITHUB PAGE")
		tooltip_x = clamp(mx, lx, lx + width)
		tooltip_y = ly - 8 - url_pointed
		
		if !url_pointed {
			url_pointed = true
			snd_play(sndHover)
		}
		
		if mouse_ui_clicked() {
			snd_play(sndClick)
			url_open("https://github.com/" + item.full_name)
		}
	}
	else url_pointed = false
}

open_time ++

#region Text & descriptions
draw_set_color(c_white)
draw_align()

var w = view_width / 1.75

draw_text_ext_transformed(55 - xoff, 50, meta.name, 8, w, 1 + scale, 1 - scale, 0)

draw_set_color(c_uigray)
draw_text_ext_transformed(56 - xoff, 65, meta.descriptionShort, 8, w, 0.75 + scale, 0.75 - scale, 0)

draw_set_color(c_white)

if !surface_exists(text_surface)
	text_surface = surface_create(description_width, description_height)

var desch = string_height_ext(meta.description, 8, description_width),
	yy = 0, time_max = 90

if desch > description_height && open_time > time_max {
	var t = (open_time - time_max) / 5,
		d = desch - description_height,
		scroll = min(d, (t % (d + 10)))
	
	if t > (d + 10)
		open_time = time_max / 3
	
	yy = -scroll
}

text_scroll = lerp(text_scroll, yy, 0.3)

surface_set_target(text_surface)
draw_clear_alpha(c_black, 0)
draw_text_ext(0, text_scroll, meta.description, 8, description_width)
surface_reset_target()

draw_surface_ext(text_surface, 12 - xoff, 96, 0.75 + scale, 0.75 - scale, 0, c_white, 1)

#endregion

#region Screenshots
var image_width = floor(view_width * 0.2),
	image_height = floor(view_height * 0.2)

for(var i = 0; i < array_length(screenshots); i ++) {
	var spr = screenshots[i]
	
	if !sprite_exists(spr)
		continue
	
	var width = sprite_get_width(spr),
		height = sprite_get_height(spr),
		xscale = image_width / width,
		yscale = image_height / height,
		dx = 12 + i * (image_width + 10) - xoff,
		dy = view_height / 2 + 16
	
	draw_rectangle_color(dx - 1, dy - 1, dx + image_width, dy + image_height, c_black, c_uigray, c_black, c_uigray, false)
	
	draw_sprite_ext(spr, 0, dx, dy, xscale, yscale, 0, c_white, 1)
	
	if mouse_ui_clicked() && point_in_rectangle(mx, my, dx, dy, dx + image_width, dy + image_height) && !screenshot_view {
		screenshot_view = true
		screenshot_image = spr
		snd_play(sndClick)
	}
}

if screenshot_image == -1 {
	screenshot_type = 0
	screenshot_index = 1
	
	screenshot_image = self.load_screenshots()
}
else if !array_length(screenshots) && open_time > 30 {
	draw_set_halign(fa_center)
	
	/// @loc:token [ResourcepackBrowser] ViewNoScreenshots "@dNO SCREENSHOTS :("
	var str = L("FullviewNoScreenshots", "@dNO SCREENSHOTS :("),
		dx = view_height / 3 + font_get_string_width(str) / 2
	
	draw_text_nt(dx - off, view_height / 2 + 32, str)
}

draw_set_halign(fa_right)

#endregion

#region Extra info
var dx = view_width - 10,
	dy = 48

var created = unix_to_datatime(item.created div 1000),
	updated = unix_to_datatime(item.updated div 1000),
	
	str1 = date_ddmmYY_string(created),
	str2 = date_ddmmYY_string(updated)

draw_set_color(c_white)
/// @loc:token [ResourcepackBrowser] FullviewPackInfo "PACK INFO"
draw_text_nt(dx, dy - 5, L("FullviewPackInfo", "PACK INFO"))

draw_set_color(c_uigray)
/// @loc:token [ResourcepackBrowser] FullviewCreationInfo "CREATED ON:"
draw_text_nt(dx, dy + 10, L("FullviewCreationInfo", "CREATED ON:") + "\n " + str1)

if str1 != str2 {
	dy += 30
	/// @loc:token [ResourcepackBrowser] FullviewLastUpdate "LAST UPDATED:"
	draw_text_nt(dx, dy, L("FullviewLastUpdate", "LAST UPDATED:") + "\n " + str2)
}

if item[$ "installtime"] {
	var date = unix_to_datatime(item.installtime div 1000),
		str = date_ddmmYY_string(date)
	
	dy += 30
	
	draw_set_color(c_uigray)
	/// @loc:token [ResourcepackBrowser] FullviewInstallationDate "INSTALLED ON:"
	draw_text_nt(dx, dy, L("FullviewInstallationDate", "INSTALLED ON:") + "\n " + str1)
}

/// @loc:token [ResourcepackBrowser] FullviewStars "STARS:"
draw_text_nt(dx, dy + 30, L("FullviewStars", "STARS:") + "\n " + string(item.stars))

#endregion

#region Download/Disable/Enable
draw_set_halign(fa_right)
draw_set_color(download_pointed ? c_white : c_uigray)

draw_set_font(global.language_font_bigname_default)

/// @loc:token [ResourcepackBrowser] ButtonDownload "DOWNLOAD"
var str = L("ButtonDownload", "DOWNLOAD")

if !browsing {
	
	str = item.active
		/// @loc:token [ResourcepackBrowser] ButtonDisable "DISABLE"
		? L("ButtonDisable", "DISABLE")
		/// @loc:token [ResourcepackBrowser] ButtonEnable "ENABLE"
		: L("ButtonEnable", "ENABLE")
	
}

var width = font_get_string_width(str) / 2

var dx = view_width - 26,
	dy = view_height - 48

if browsing && item.external {
	draw_sprite_ext(sprResourcepackDownload, 0, dx - width - 32, dy - 2 - download_pointed, 0.75, 0.75, 0, draw_get_color(), 1)
}

draw_text_bigname(dx + 26, dy - download_pointed, str)

if !screenshot_view && point_in_rectangle(mx, my, dx - width - 32, dy, view_width, dy + 18) {
	if !download_pointed {
		download_pointed = true
		snd_play(sndHover)
	}
	
	if mouse_ui_clicked() {
		if !browsing {
			item.active ^= 1
			
			if !item.active {
				file_write(item.path + "disable.d", "")
			}
			else file_delete(item.path + "disable.d")
			
			reload_needed = 2
		}
		else self.direct_download(item.full_name, item.branch)
		
		snd_play(sndClick)
	}
}
else if download_pointed
	download_pointed = false

draw_set_color(c_white)
draw_set_halign(fa_left)
draw_reset_font()

#endregion

if (is_string(tooltip)) scrDrawTooltip(tooltip_x, tooltip_y, tooltip)
