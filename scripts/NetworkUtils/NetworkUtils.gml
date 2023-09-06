function network_get_free_id() {
    if !ds_stack_empty(global.netidstack)
        return ds_stack_pop(global.netidstack)

    return global.netfreeid ++
}

function network_free_id(index) {
    ds_stack_push(global.netidstack, index)
}

function packet_begin(_event) {
	buffer_seek(global.buffer, buffer_seek_start, 0)
	buffer_write(global.buffer, buffer_u8, _event)
}

function packet_write(_type, _data) {
	buffer_write(global.buffer, _type, _data)
}

function packet_read(_type) {
	return buffer_read(global.buffer, _type)
}

function packet_send() {
	with CoopController {
		if global.is_server {
			for(var i = 0; i < array_length(sockets); i ++) {
				network_send_packet(sockets[i], global.buffer, buffer_tell(global.buffer))
			}
		}
		else {
			network_send_packet(socket, global.buffer, buffer_tell(global.buffer))
		}
	}
}

function packet_send_to(_socket) {
	network_send_packet(_socket, global.buffer, buffer_tell(global.buffer))
}

function buffer_send(buffer) {
    with CoopController {
        if global.is_server {
			for(var i = 0; i < array_length(sockets); i ++) {
				network_send_packet(sockets[i], buffer, buffer_tell(buffer))
			}
		}
		else {
			network_send_packet(socket, buffer, buffer_tell(buffer))
		}
    }
}

function network_lock() {
	if lockstep_stop
		exit
	
	lockstep_stop = true
	draw_enable_drawevent(false)
	
	instance_deactivate_all(false)
	instance_activate_object(CoopController)
	instance_activate_object(UberCont)
}

function network_unlock() {
	if !lockstep_stop
		exit
	
	lockstep_stop = false
	draw_enable_drawevent(true)
	
	if UberCont.paused {
		instance_activate_object(BackCont)
		instance_activate_object(GameCont)
		instance_activate_object(TopCont)
		instance_activate_object(PauseButton)
		instance_activate_object(MusCont)
		instance_activate_object(Console)
	}
	else instance_activate_all()
}

function network_is_locked() {
	return lockstep_stop
}

function network_clientcount() {
	if instance_exists(CoopController)
		return array_length(CoopController.sockets)
	
	return 0
}