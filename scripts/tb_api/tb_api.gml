#macro URL_TBAPI "https://raw.githubusercontent.com/toarch7/torcherdev/main/"

// Makes a http request to retrieve needed info
// about daily/weekly preset
//
// example usage:
// tb_api("daily") -> "https://raw.githubusercontent.com/toarch7/torcherdev/main/dailydata.json"
//

function tb_api(type) {
    return scrHttpGet(URL_TBAPI + type + "data.json")
}

function scrValidateWeeklyLoadout(map) {
	random_set_seed(real(map[? "seed"]))
	
	map[? "week"] = date_get_week(date_current_datetime())
	
	
	if map[? "char"] > 15
		map[? "char"] = irandom(11) + 1
	
	
	if map[? "bskin"] > 1
		map[? "bskin"] = choose(0, 1)
	
	
	if map[? "crown"] > 13
		map[? "crown"] = irandom_range(2, 13)
	
	
	if map[? "wep"] > 125 {
		map[? "wep"] = choose(
			irandom_range(2, 36),
			irandom_range(47, 55),
			irandom_range(57, 97),
			irandom_range(104, 125) )
	}
}