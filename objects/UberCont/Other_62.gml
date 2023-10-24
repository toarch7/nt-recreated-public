if async_load[? "id"] == update_request {
    if !is_undefined(async_load[? "result"]) && async_load[? "result"] != -1 {
        var result = json_decode(async_load[? "result"])
		
        if !is_undefined(result) {
			var vname = BETA ? "versionBeta": "version"
			
            if result[? vname] > GAME_BUILD {
				var str = loc_sfmt("New game build #% is now available.\nOpen download page?", string(result[? vname]))
				
                update_message = show_question_async(str)
            }
            
			leaderboards_allowed = result[? "leaderboardsAllowed"] ?? false
			
            update_info = result
			
			daily_request = tb_api("daily")
			weekly_request = tb_api("weekly")
			
			daily_grill = result[? "dailyGriller"] ?? false
			weekly_grill = result[? "weeklyGriller"] ?? false
			
			if is_string(result[? "updateURL"])
				update_url = result[? "updateURL"]
        }
    }
}

if async_load[? "id"] == daily_request && get_daily_times++ < 5 {
    if is_undefined(async_load[? "result"]) {
        daily_request = tb_api("daily")
        exit
    }

    if async_load[? "result"] == -1 {
        exit
    }

    result = json_decode(async_load[? "result"])

    if is_undefined(result) {
        daily_request = tb_api("daily")
        exit
    }

    if !is_undefined(result) {
        var text = json_decode(result)

        if is_undefined(text) exit

        if !is_undefined(text[? "default"]) {
            text = text[? "default"]
        }

        daily_seed = scrReal(text[? "seed"])
        daily_time = scrReal(text[? "time"])

        can_daily = daily_seed > 0 && save_get_value("etc", "seed", "-1") != daily_seed
    }
	else daily_request = -1
}

if async_load[? "id"] == weekly_request && async_load[? "result"] != -1 && get_daily_times < 5 {
    if is_undefined(async_load[? "result"]) {
        weekly_request = tb_api("weekly")
        exit
    }

    result = json_decode(async_load[? "result"])

    if is_undefined(result) {
        weekly_request = tb_api("weekly")
        exit
    }

    if !is_undefined(result) {
        weekly_data = result
		
		if weekly_data[? "seed"] != undefined {
	        can_weekly = 1
			
	        random_set_seed(real(weekly_data[? "seed"]))
			
	        weekly_data[? "week"] = date_get_week(date_current_datetime())
			
	        if weekly_data[? "char"] > 15 {
	            weekly_data[? "char"] = irandom(11) + 1
	        }
			
	        if weekly_data[? "bskin"] > 1 {
	            weekly_data[? "bskin"] = choose(0, 1)
	        }
			
	        if weekly_data[? "wep"] > 125 {
	            weekly_data[? "wep"] = choose(irandom_range(2, 36), irandom_range(47, 55), irandom_range(57, 97), irandom_range(104, 125))
	        }
			
	        if weekly_data[? "crown"] > 13 {
	            weekly_data[? "crown"] = irandom_range(2, 13)
	        }
		}
		else {
			can_weekly = 0
			weekly_data = undefined
			print("Failed to retrieve weeklydata")
		}
    }
	else weekly_request = -1
}
