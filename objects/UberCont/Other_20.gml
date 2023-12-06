/// @description Start Discord auth

print("Start discord auth")

if server == -1 {
	print("TCP Server server started", server)
	server = network_create_server_raw(network_socket_tcp, 53134, 32)
}

if server != -1 {
	var url = "https://discord.com/api/oauth2/authorize?client_id=1139936421755494450&redirect_uri=http%3A%2F%2Flocalhost%3A53134%2Foauth2&response_type=code&scope=identify"

	url_open(url)

	auth_discord_login = false

	if sprite_exists(auth_discord_picture)
		sprite_delete(auth_discord_picture)

	auth_discord_picture = -1
}