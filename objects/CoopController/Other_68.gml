var _ip = async_load[? "ip"]
var _port = async_load[? "port"]

try {
    if async_load[? "type"] == network_type_data {
        var data = async_load[? "buffer"]
        var data_type = buffer_read(data, buffer_u8)
        var share = 1

        switch data_type {
            case event.udp_connect:
                if is_undefined(connectedports[$ _port]) && array_length(playerindexes) < 3 {
                    var freeid = network_get_free_id()
					
                    connectedports[$ _port] = _ip
                    portindexes[$ _port] = freeid
					
                    array_push(playerindexes, freeid)
					
                    snd_play(sndRestart)
					
                    buffer_seek(global.buffer, buffer_seek_start, 0)
					
                    buffer_write(global.buffer, buffer_u8, event.connect)
                    buffer_write(global.buffer, buffer_u8, freeid)
					
                    network_send_udp(socket, _ip, _port, global.buffer, buffer_tell(global.buffer))
                }
				
                share = 0
                break

            case event.connect:
                var _index = buffer_read(data, buffer_u8)

                index = _index
                global.index = index

                snd_play(sndRestart)

                if instance_exists(CoopMenu) {
                    CoopMenu.text = "CONNECTED!#WAITING FOR HOST TO START THE GAME..."
                }

                loading_text = ""

                alarm[1] = -1

                share = 0
                break

            case event.start:
                var _indexes = buffer_read(data, buffer_string)
                playerindexes = json_parse(_indexes)

                instance_create(0, 0, GameCont)

                UberCont.playerinstances[$ "0"] = new PlayerInstance(0, 0, 0)

                for (var i = 0; i < array_length(playerindexes); i++) {
                    var _ind = playerindexes[i]

                    UberCont.playerinstances[$ string(_ind)] = new PlayerInstance(_ind, 0, 0)
                }

                global.seed = buffer_read(data, buffer_u32)
                random_set_seed(global.seed)

                for (var i = 0; i <= 12; i++) {
                    global.rng_state[i] = global.seed
                }

                with SpiralCont instance_destroy()

                UberCont.daily_run = 0
                UberCont.weekly_run = 0

                instance_create(0, 0, MenuGen)

                with FloorMaker instance_destroy()
                with ChestOpen instance_destroy()

                with CoopMenu {
                    server = -1

                    instance_destroy()
                }

                share = 0
                break

            case event.update_playerinstance:
                var _index = buffer_read(data, buffer_u8)
                var inst = playerinstance_get(_index)
                var _skin = inst.skin,
                    _race = inst.race

                    inst.read(data)

                    if inst.skin != _skin or inst.race != _race {
                        with Menu ports_x[_index] = 150
                    }

                if inst.race != _race {
                    var snd_slct = asset_get_index("sndMutant" + string(inst.race) + "Slct")

                    if inst.race == 13 {
                        snd_slct = sndBigDogIntro
                    }

                    snd_play(snd_slct)
                }
                break

            case event.run_start:
                global.seed = buffer_read(data, buffer_u32)
                random_set_seed(global.seed)

                scrRunStart()
                break

            case event.restart:
                global.seed = buffer_read(data, buffer_u32)
                UberCont.want_restart = 1
                break
			
			case event.inputs:
				var _index = buffer_read(data, buffer_u8),
					_inputs = buffer_read(data, buffer_u32),
					_dir_move = buffer_read(data, buffer_f16),
					_dir_fire = buffer_read(data, buffer_f16),
					_crosshair = buffer_read(data, buffer_u8)
				
				ds_stack_push(inputs[_index], _inputs, _dir_move, _dir_fire, _crosshair)
				
				break
        }

        if global.is_server {
            if share && array_length(playerindexes) > 1 {
                var _keys = struct_keys(connectedports)

                for (var i = 0; i < array_length(_keys); i++) {
                    var port = _keys[i],
                        _prt = real(port)
					
                    if _port != _prt {
                        network_send_udp(socket, connectedports[$ port], _prt, data, buffer_tell(data))
                    }
                }
            }

            portdelays[$ _port] = get_timer()
        }
    }
}
catch (exception) {
    print("CoopController exception:", exception.message)
    errorcount++
}