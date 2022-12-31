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
                    buffer_write(global.buffer, buffer_string, json_stringify(global.coopoptions))
                    network_send_udp(socket, _ip, _port, global.buffer, buffer_tell(global.buffer))
                }

                share = 0
                break

            case event.connect:
                var _index = buffer_read(data, buffer_u8)
                var _opts = buffer_read(data, buffer_string)

                global.coopoptions = json_parse(_opts)

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

            case event.crownpick:
                var _index = buffer_read(data, buffer_u8)
                var _crown = buffer_read(data, buffer_u8)

                with Menu loadout_crown = _crown
                with GameCont crown = _crown

                with CrownIcon
                if crown == _crown {
                    selected = 1
                    event_user(0)
                }
                break

            case event.crownselect:
                var _index = buffer_read(data, buffer_u8)
                var _crown = buffer_read(data, buffer_u8)

                with LevCont splat = 1
                snd_play(sndMenuSelect)

                with CrownIcon {
                    selected = (crown == _crown)
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

            case event.hitmekill:
                var _ind = real(buffer_read(data, buffer_string))

                with enemy
                if index == _ind {
                    x = real(buffer_read(data, buffer_string))
                    y = real(buffer_read(data, buffer_string))
                    direction = real(buffer_read(data, buffer_string))
                    speed = real(buffer_read(data, buffer_string))
                    hp = real(buffer_read(data, buffer_string))

                    global.coopenemylist[$ string(index)] = undefined

                    instance_destroy()

                    break
                }
                break

            case event.setarea:
                var _area = buffer_read(data, buffer_u8)
                var _subarea = buffer_read(data, buffer_u8)
                var _hard = buffer_read(data, buffer_u8)
                var _loops = buffer_read(data, buffer_u8)
                var _rads = real(buffer_read(data, buffer_string))
                var _skillpoints = buffer_read(data, buffer_u8)
                var _kills = real(buffer_read(data, buffer_string))
                var _level = buffer_read(data, buffer_u8)
                var _ultrapoints = buffer_read(data, buffer_u8)
                var _crownpoints = buffer_read(data, buffer_u8)

                with GameCont {
                    area = _area
                    subarea = _subarea
                    hard = _hard
                    loops = _loops
                    rad = _rads
                    skillpoints = _skillpoints
                    kills = _kills
                    level = _level
                    ultrapoints = _ultrapoints
                    crownpoints = _crownpoints

                    room_restart()
                }
                break

            case event.skillpick:
                var _index = buffer_read(data, buffer_u8)
                var _skill = buffer_read(data, buffer_u8)

                with SkillIcon {
                    selected = 0
                }

                with SkillIcon
                if skill == _skill {
                    selected = 1
                    event_user(0)
                }
                break

            case event.skillselect:
                var _index = buffer_read(data, buffer_u8)
                var _skill = buffer_read(data, buffer_u8)

                with SkillIcon
                selected = 0

                with SkillIcon
                if skill == _skill {
                    selected = 1
                }

                with LevCont
                splat = 1

                snd_play(sndMenuSelect)
                break

            case event.ultrapick:
                var _index = buffer_read(data, buffer_u8)
                var _num = buffer_read(data, buffer_u8)

                with UltraIcon {
                    selected = 0
                }

                with UltraIcon
                if num == _num {
                    selected = 1
                    event_user(0)
                }

                with Player {
                    if race == 6 {
                        GameCont.gocrib = 1
                        room_restart()
                    }
                }
                break

            case event.ultraselect:
                var _index = buffer_read(data, buffer_u8)
                var _num = buffer_read(data, buffer_u8)

                with UltraIcon {
                    selected = (num == _num)
                }

                with LevCont
                splat = 1

                snd_play(sndMenuSelect)
                break

            case event.floorclear:
                var _x = real(buffer_read(data, buffer_string))
                var _y = real(buffer_read(data, buffer_string))

                with enemy {
                    instance_destroy()
                }

                if GameCont.area != 0 {
                    instance_create(_x, _y, Portal)
                } else {
                    instance_create(_x, _y, Nothing2Appear)
                }
                break

                #region event.syncing
            case event.syncplayer:
                var ind = buffer_read(data, buffer_u8),
                    b = data

                    KeyCont.dir_move[ind] = real(buffer_read(b, buffer_string))
                    KeyCont.dir_fire[ind] = real(buffer_read(b, buffer_string))
                    KeyCont.moving[ind] = buffer_read(b, buffer_f16)
                    KeyCont.gamepad[ind] = buffer_read(b, buffer_u8)
                    KeyCont.aimassist[ind] = buffer_read(b, buffer_u8)

                    var keys = ["fire", "spec", "pick", "swap", "paus", "horn"]

                for (var i = 0; i < array_length(keys); i++) {
                    KeyCont[$ "press_" + keys[i]][ind] = buffer_read(b, buffer_u8)
                    KeyCont[$ "release_" + keys[i]][ind] = buffer_read(b, buffer_u8)
                    KeyCont[$ "hold_" + keys[i]][ind] = buffer_read(b, buffer_u8)
                }

                KeyCont.crosshair[ind] = buffer_read(b, buffer_u8)
                KeyCont.activeforever[ind] = buffer_read(b, buffer_u8)

                var _index = buffer_read(data, buffer_s8)
                var _x = real(buffer_read(data, buffer_string))
                var _y = real(buffer_read(data, buffer_string))
                var _hp = real(buffer_read(data, buffer_string))
                var _spirit = buffer_read(data, buffer_u8)
                var _wep = real(buffer_read(data, buffer_string))
                var _bwep = real(buffer_read(data, buffer_string))
                var _curse = buffer_read(data, buffer_u8)
                var _bcurse = buffer_read(data, buffer_u8)
                var _amm = []

                for (var i = 1; i <= 5; i++) {
                    _amm[i] = real(buffer_read(data, buffer_string))
                }

                with Player
                if index == _index {
                    x = _x
                    y = _y

                    hp = _hp

                    can_die = 0
                    spirit = _spirit

                    if !hp && !spirit {
                        can_die = 1
                    }

                    wep = _wep
                    bwep = _bwep

                    ammo = _amm

                    curse = _curse
                    bcurse = _bcurse
                }
                break

            case event.syncai:
                ai_seed = buffer_read(data, buffer_u16)
                random_set_seed(ai_seed)
                var _ai_seed = ai_seed

                var nenemies = real(buffer_read(data, buffer_string))

                repeat nenemies {
                    var ind = real(buffer_read(data, buffer_string))

                    with enemy {
                        if index == ind {
                            for (var i = 3; i <= 11; i++) {
                                if alarm[i] {
                                    alarm[i]--

                                    if !alarm[i] {
                                        event_perform(ev_alarm, i)
                                    }
                                }
                            }

                            if wkick > 0 wkick -= 1
                            else if wkick < 0 wkick += 1

                            #region ANIMATE - ME - PLZ
                            if spr_chrg != -1 {
                                if sprite_index != spr_hurt && sprite_index != spr_chrg {
                                    sprite_index = spr_idle
                                }

                                if sprite_index = spr_hurt or sprite_index = spr_chrg {
                                    if image_index > 2 {
                                        sprite_index = spr_idle
                                    }
                                }
                            } else {
                                if spr_fire != -1 {
                                    if speed <= 0 {
                                        if sprite_index != spr_hurt && sprite_index != spr_fire {
                                            sprite_index = spr_idle
                                        }
                                    } else {
                                        if sprite_index != spr_hurt && sprite_index != spr_fire {
                                            sprite_index = spr_walk
                                        }
                                    }

                                    if sprite_index = spr_hurt {
                                        if image_index > 2 {
                                            sprite_index = spr_idle
                                        }
                                    }
                                } else {
                                    if speed <= 0 {
                                        if sprite_index != spr_hurt {
                                            sprite_index = spr_idle
                                        }
                                    } else {
                                        if sprite_index != spr_hurt {
                                            sprite_index = spr_walk
                                        }
                                    }
                                    if sprite_index = spr_hurt {
                                        if image_index > 2 {
                                            sprite_index = spr_idle
                                        }
                                    }
                                }
                            }#endregion

                            x = real(buffer_read(data, buffer_string))
                            y = real(buffer_read(data, buffer_string))
                            speed = real(buffer_read(data, buffer_string))
                            direction = real(buffer_read(data, buffer_string))
                            hp = real(buffer_read(data, buffer_string))
                            alarm[0] = real(buffer_read(data, buffer_string))
                            if alarm[0] == 0 event_perform(ev_alarm, 0) alarm[1] = real(buffer_read(data, buffer_string))
                            if alarm[1] == 0 event_perform(ev_alarm, 1) alarm[2] = real(buffer_read(data, buffer_string))
                            if alarm[2] == 0 event_perform(ev_alarm, 2)

                            if inframes inframes--

                            scrTarget()

                            event_user(0)

                            x += vspeed
                            y += vspeed
                        }
                    }
                }

                share = 0
                break

                #endregion

            case event.unpause:
                scrUnpause()

                with JoystickMove event_perform(ev_create, 0)
                with ButtonActive event_perform(ev_create, 0)
                with ButtonAct event_perform(ev_create, 0)
                with ButtonSwap event_perform(ev_create, 0)

                with PauseButton instance_destroy()
                with BackButton instance_destroy()
                break

            case event.set_config:
                var _opts = buffer_read(data, buffer_string)
                global.coopoptions = json_parse(_opts)

                snd_play(sndClick)
                break

            case event.ping:
                network_send_udp(socket, _ip, _port, data, buffer_tell(data))
                localdelay = get_timer()
                share = 0
                break

            case event.syncportal:
                var _x = real(buffer_read(data, buffer_string))
                var _y = real(buffer_read(data, buffer_string))

                var p = instance_find(Portal, 0)

                if p with p {
                    x = real(_x)
                    y = real(_y)
                }
                break

            case event.verifyenemy:
                var _index = buffer_read(data, buffer_string)

                if enemy_find_index(_index) == undefined {
                    debugstr = print("unknown enemy ind", _index, "found, destroying it")

                    buffer_seek(global.buffer, buffer_seek_start, 0)
                    buffer_write(global.buffer, buffer_u8, event.enemyremove)
                    buffer_write(global.buffer, buffer_string, string(_index))
                    buffer_write(global.buffer, buffer_string, json_stringify(global.coopenemylist))
                    buffer_send(global.buffer)
                }

                share = 0
                break

            case event.enemyremove:
                var _index = buffer_read(data, buffer_string)
                var _actuallist = buffer_read(data, buffer_string)

                if enemy_find_index(_index) != undefined {
                    global.coopenemylist = json_parse(_actuallist)

                    with enemy_find_index(_index) {
                        instance_destroy(id, 0)
                    }
                }

                share = 0
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

} catch (exception) {
    print("CoopController exception:", exception.message)
    errorcount++
}