if async_load[? "id"] == rp_bl_req {
    if !is_undefined(async_load[? "result"]) && async_load[? "result"] != -1 {
        var result = json_decode(async_load[? "result"])

        if !is_undefined(result) {
            rp_unlisted = result[? "unlisted"]
            rp_approved = result[? "approved"]

            rp_bl_req = -1
        }
    }
}

if async_load[? "id"] == update_request {
    if !is_undefined(async_load[? "result"]) && async_load[? "result"] != -1 {
        var result = json_decode(async_load[? "result"])
        show_debug_message(async_load[? "result"])

        if !is_undefined(result) {
            if result[? "version"] > GAME_BUILD {
                update_message = show_question_async("Update " + string(result[? "versionName"]) + " b" + string(result[? "version"]) + " available.\n Open download page?")
            }
            /*
			seedoffset = scrReal(result[? "seedOffset"])
			
			if !result[? "thronebutt"] {
				show_debug_message("Thronebutt is disabled, using offline method.")
				
				var date = date_current_datetime()
				var seed = date_get_day(date) * 4 + date_get_month(date) * 8 + date_get_year(date) * 16 + seedoffset
				
				random_set_seed(seed)
				seed = irandom(999999)
				
				daily_seed = seed
				daily_time = 86400
				can_daily = 1
				
				random_set_seed(date_get_week(date_current_datetime()) + (date_year * 100) + seedoffset)
				weekly_data = ds_map_create()
				weekly_data[? "char"] = irandom(11) + 1
				weekly_data[? "crown"] = 2 + irandom(11)
				weekly_data[? "bskin"] = irandom(1)
				weekly_data[? "seed"] = irandom(999999)
				weekly_data[? "active"] = 1
				weekly_data[? "week"] = date_get_week(date_current_datetime())
				weekly_data[? "seq"] = 430000
				
				var wep = -1
				
				do {
					wep = irandom(123) + 1
					
					if string_copy(wep, 1, 4) == "GOLD" or wep == 12 or wep == 109 or wep == 108 or wep == 1 or wep == 56 {
						wep = -1
					}
				} until wep != -1
				
				weekly_data[? "startwep"] = wep
				
				can_weekly = 1
			} else {
				show_debug_message("Thronebutt ok, requesting...")
			}
			*/
            update_info = result
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

        daily_seed = scrReal(text[? "seed"]) + seedoffset
        daily_time = scrReal(text[? "time"])

        can_daily = daily_seed > 0 && !opt_console
    } else daily_request = -1
}

if async_load[? "id"] == weekly_request && get_daily_times < 5 {
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

        can_weekly = 1

        if opt_console can_weekly = 0

        weekly_data[? "week"] = date_get_week(date_current_datetime())

        if !is_undefined(weekly_data[? "seed"]) {
            weekly_data[? "seed"] += seedoffset
        }
    } else weekly_request = -1
}