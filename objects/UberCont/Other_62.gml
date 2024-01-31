if async_load[? "http_status"] != 200
or !is_string(async_load[? "result"])
	exit

if async_load[? "id"] == update_request {
    if !is_undefined(async_load[? "result"]) && async_load[? "result"] != -1 {
        var result = json_decode(async_load[? "result"])
		
        if !is_undefined(result) {
			var vname = BETA ? "versionBeta": "version"
			
            if result[? vname] > GAME_BUILD {
				var str = loc_sfmt("A Build version #% is now available.\nOpen the download page?", string(result[? vname]))
				
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

if async_load[? "id"] == daily_request {
	result = json_decode(async_load[? "result"])
	
	if !is_undefined(result) {
	    daily_seed = scrReal(result[? "seed"])
	    daily_time = scrReal(result[? "time"])
		
	    can_daily = daily_seed > 0 && save_get_value("etc", "seed", "-1") != daily_seed
	}
	else daily_request = -1
}

if async_load[? "id"] == weekly_request {
	result = json_decode(async_load[? "result"])
	
	if is_undefined(result) {
	    weekly_request = tb_api("weekly")
	    exit
	}
	
	if !is_undefined(result) {
	    weekly_data = result
		
		if weekly_data[? "seed"] != undefined {
			scrValidateWeeklyLoadout(weekly_data)
		    can_weekly = 1
		}
		else {
			can_weekly = 0
			weekly_data = undefined
			print("Failed to retrieve weeklydata")
		}
	}
	else weekly_request = -1
}

if async_load[? "id"] == auth_discord_request_post {
	var result = json_decode(async_load[? "result"])

	auth_discord_token = result[? "access_token"]
	auth_discord_logged = true

	save_set_value("etc", "auth_discord_token", auth_discord_token)
	
	if server != -1
		network_destroy(server)

	scrSave()
}

if async_load[? "id"] == auth_discord_request_api {
	if async_load[? "http_status"] == 200 {
		var result = json_decode(async_load[? "result"])

		auth_discord_username = result[? "username"]
		auth_discord_id = result[? "id"]

		auth_discord_picture = sprite_add("https://cdn.discordapp.com/avatars/" + auth_discord_id + "/" + result[? "avatar"], 1, 0, 0, 0, 0)
	}
}
