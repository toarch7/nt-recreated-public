if instance_exists(CoopController)
	exit

if async_load[? "type"] != network_type_data
	exit

var buff = async_load[? "buffer"]

try {

	var response = buffer_read(buff, buffer_text)

	var code = string_split_array(response, "\r\n")[0]

	code = string_split_array(code, " ")[1]

	if string_starts(code, "/oauth2") {
		code = string_copy(code, string_pos("=", code) + 1, string_length(code))

		if code != "" && code != "/oauth2" {
			var postfields = {
				client_id: DISCORD_APP_CLIENT_ID,
				client_secret: DISCORD_APP_CLIENT_SECRET,
				grant_type: "authorization_code",
				redirect_uri: "http://localhost:53134/oauth2",
				scope: "identify"
			}

			postfields.code = code

			var headermap = ds_map_create()
			headermap[? "Content-type"] = "application/x-www-form-urlencoded"

			var a = url_encode_query(postfields)

			auth_discord_request_post = scrHttpRequest("https://discord.com/api/oauth2/token", "POST", headermap, a)

			ds_map_destroy(headermap)
		}

		var buffer = buffer_create(1, buffer_grow, 1),
			document = file_read("auth.html");

		var document_body = buffer_create(1, buffer_grow, 1)
		buffer_write(document_body, buffer_text, document)
		buffer_resize(document_body, buffer_tell(document_body))
		var content_length = buffer_get_size(document_body)
		buffer_delete(document_body)

		buffer_write(buffer, buffer_text, "HTTP/1.1 200 OK\r\n")
		buffer_write(buffer, buffer_text, "Content-Type: text/html\r\n")
		buffer_write(buffer, buffer_text, "Content-Length: " + string(content_length) + "\r\n\r\n")
		buffer_write(buffer, buffer_text, document)

		buffer_resize(buffer, buffer_tell(buffer))

		var a = network_send_raw(async_load[? "id"], buffer, buffer_get_size(buffer))

		buffer_delete(buffer)
	}
}
catch(e) {
	print(e.longMessage)
}