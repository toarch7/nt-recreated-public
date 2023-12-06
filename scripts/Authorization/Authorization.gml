globalvar auth_discord_token, auth_discord_login, auth_discord_username, auth_discord_picture, auth_discord_id;

auth_discord_login = false
auth_discord_username = ""
auth_discord_picture = -1
auth_discord_id = -1

auth_discord_token = undefined

function scrAuthorizationInit() {
	print("Auth init call")
	
	server = -1
	server_connections = {}

	auth_discord_request_post = -1
	auth_discord_request_api = -1

	auth_discord_token = save_get_value("etc", "auth_discord_token")

	if is_string(auth_discord_token)
		auth_discord_login = true
	
	print(">", auth_discord_login, auth_discord_token)
}

function auth_discord_api_request(api, _method = "GET", body = undefined) {
	var headers = ds_map_create()
	headers[? "Authorization"] = "Bearer " + auth_discord_token

	if body != undefined {
		body = json_stringify(body)
	}
	else body = -1

	var r = scrHttpRequest("https://discord.com/api/" + api, _method, headers, body)

	ds_map_destroy(headers)

	return r
}