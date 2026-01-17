history = struct_secure_load(game_directory + "dailyruns.dat")

if is_undefined(history) {
    history = {
        daily: {},
        weekly: {},

        kills: [0, 0]
    }
} else if is_undefined(history[$ "kills"]) {
    history.kills = [0, 0]
}

viewtype = "daily"

if UberCont.weekly_run {
	viewtype = "weekly"
}

dailykeys = struct_keys(history.daily)
weeklykeys = struct_keys(history.weekly)

array_sort(dailykeys, function(a, b) {
    var history = DailyList.history
    return sign(scrReal(history.daily[$ b][$ "timestamp"]) - scrReal(history.daily[$ a][$ "timestamp"]))
})

array_sort(weeklykeys, function(a, b) {
    var history = DailyList.history
    return sign(scrReal(history.weekly[$ b][$ "timestamp"]) - scrReal(history.weekly[$ a][$ "timestamp"]))
})

alpha = 0

scrUltras()

frame = 0

page = 0
time = 0

__draw_weapon = function(_weapon, _x, _y) {
	var _sprite = scr_weapon_get_sprite(_weapon)
	if (!sprite_exists(_sprite)) exit
	
	var _ox = sprite_get_xoffset(_sprite),
		_oy = sprite_get_yoffset(_sprite),
		_w = sprite_get_width(_sprite),
		_h = sprite_get_height(_sprite)
	
	sprite_set_offset(_sprite, _w div 2, _h div 2)
	
	draw_sprite(_sprite, 0, _x, _y)
	
	sprite_set_offset(_sprite, _ox, _oy)
}