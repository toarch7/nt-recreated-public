if (async_load[? "id"] == message) {
	if (os_type == os_android) {
		KillAndroidTask()
	}
	else {
		game_restart()
		game_end()
	}
}