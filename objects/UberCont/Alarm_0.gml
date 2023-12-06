alarm[0] = 30

//time stats
tot_time ++

if instance_exists(Player) {
    with Player {
        if is_me {
            UberCont.ctot_time[race]++
            break
        }
    }
}

if daily_time
    daily_time --

if auth_discord_logged {
	if auth_discord_picture == -1 && auth_discord_request_api == -1 {
		auth_discord_username = "LOADING..."
		auth_discord_request_api = auth_discord_api_request("users/@me")
	}
}
