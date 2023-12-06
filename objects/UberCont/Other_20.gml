/// @description Start Discord auth

print("Start Discord auth", server)

if server == -1 {
	server = network_create_server_raw(network_socket_tcp, 53134, 32)
	print("TCP Server server started", server)
}

if server != -1 {
	var url = "https://discord.com/api/oauth2/authorize?client_id=1139936421755494450&redirect_uri=http%3A%2F%2Flocalhost%3A53134%2Foauth2&response_type=code&scope=identify"

	url_open(url)

	auth_discord_logged = false

	if sprite_exists(auth_discord_picture)
		sprite_delete(auth_discord_picture)

	auth_discord_picture = -1
}