global.__next_network_id = 0

function scr_network_instance() {
	netid = ++global.__next_network_id
}

function scr_network_reset_session_ids() {
	global.__next_network_id = 0
}