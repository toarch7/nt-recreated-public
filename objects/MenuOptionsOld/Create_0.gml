
languages = ["en"]

restart = instance_exists(BackButton)

remap_pos = 0

remap_keys = {
    face1: "CONFIRM/PICKUP",
    face2: "BACK/CANCEL",
    face3: "SWAP WEAPON",
    shoulderr: "FIRE",
    shoulderl: "ABILITY",
    padu: "ARROW UP",
    padd: "ARROW DOWN",
    padl: "ARROW LEFT",
    padr: "ARROW RIGHT"
}

if !restart {
    instance_create(0, 0, BackButton)
}

foreach(UberCont.localizations_list, function(val, index) {
    array_push(languages, index);
})

resolution = UberCont.opt_resolution
language = UberCont.opt_language
pointed_item = 0
rp_warning = 0
clickable = 0
alarm[0] = 5

options = [
//0 - General
[{
    name: "AUDIO",
    value: 1,
    type: "category"
}, {
    name: "VIDEO",
    value: 2,
    type: "category"
}, {
    name: "GAME",
    value: 3,
    type: "category"
}, {
    name: "CONTROLS",
    value: 4,
    type: "category"
}, {
    name: "RESOURCEPACKS",
    value: 5,
    type: "category",
    onClick: function() {
        if !save_get_val("etc", "rp_warning", 0) {
			with MenuOptions rp_warning = 1
		}
		else {
			with instance_create(0, 0, ResourcepackManager)
				event_user(0)
		}
		
        return 1
    }
}, {
    name: "DATA",
    value: 5,
    type: "category"
}],

//1 - Sounds
[{
    name: "MASTER VOLUME",
    type: "slider",
    value: 1,
    group: "options",
    key: "sound"
}, {
    name: "MUSIC",
    type: "slider",
    value: 1,
    group: "options",
    key: "music"
}, {
    name: "AMBIENCE",
    type: "slider",
    value: 1,
    group: "options",
    key: "sfx"
}],

//2 - Video
[{
    name: "FULLSCREEN",
    type: "switch",
    value: 1,
    group: "visual",
    key: "resolution"
}, {
    name: "DYNAMIC CAMERA",
    type: "switch",
    value: 1,
    group: "visual",
    key: "activecam"
}, {
    name: "SCREENSHAKE",
    type: "slider",
    value: 1,
    group: "visual",
    key: "screenshake"
}, {
    name: "BETTER WALLS",
    type: "switch",
    value: 1,
    group: "visual",
    key: "walls"
}, {
    name: "PARTICLES",
    type: "switch",
    value: 0,
    invert: true,
    group: "visual",
    key: "particles"
}, {
    name: "BLOOM",
    type: "switch",
    value: 1,
    group: "visual",
    key: "bloom"
}, {
    name: "SIDE ART",
    type: "button",
    value: 1,
    group: "options",
    key: "sideart",
    onClick: function() {
        if UberCont.opt_resolution exit

        self.value++

        if self.value > 8 {
            self.value = 0
        }

        save_set_val(self.group, self.key, self.value)
    },

    onDraw: function(dx, dy) {
        //if UberCont.opt_resolution draw_set_color(c_uidark)

        draw_set_halign(fa_right)
        //draw_sprite(sprScoreSplat, 2, dx - UI_SPLAT_OFFSET, dy)
        draw_text_shadow(dx - 4, dy, loc(self.name) + ":")

        draw_sprite(sprScoreSplat, 2, dx + 32, dy)

        draw_set_halign(fa_center)
        draw_text_shadow(dx + 32, dy, string(self.value) + "/8")
        draw_set_halign(fa_left)

        draw_set_color(c_white)
    }
}, {
    name: "HUD",
    type: "switch",
    value: 1,
    group: "visual",
    key: "hud"
}],

//3 - Game
[{
    name: "CROSSHAIR",
    type: "button",
    value: 0,
    group: "visual",
    key: "crosshair",

    onClick: function() {
        self.value = self.value + 1

        if self.value > 8 {
            self.value = 0
        }

        UberCont.opt_crosshair = self.value
    },

    onDraw: function(dx, dy) {
        draw_set_halign(fa_right)

        //draw_sprite(sprScoreSplat, 2, dx - UI_SPLAT_OFFSET, dy)
        draw_text_shadow(dx - 4, dy, loc(self.name) + ":")

        draw_sprite(sprScoreSplat, 2, dx + 32, dy)

        draw_set_halign(fa_center)
        if self.value >= 8 {
            draw_text_shadow(dx + 32, dy, "(NO)")
        } else draw_sprite_ext(sprCrosshair, self.value, dx + 32, dy, 1, 1, 0, UberCont.opt_cursorcol, 1)

        draw_set_halign(fa_left)
    }
},

{
    name: "LANGUAGE",
    type: "list",
    value: "en",
    group: "etc",
    key: "language",
    list: languages,
    pos: 0
},

{
    name: "NICKNAME",
    type: "input",
    value: "unnamed",
    group: "etc",
    key: "name",
    message: "Enter your nickname:",

    callback: function(res, opt, optItself) {
        var result = res[? "result"]
        var namereq = -1;

        if result == ""
			exit

        result = string_replace_all(result, "<br>", "")
        result = string_replace_all(result, "&", "")
        result = string_replace_all(result, "+", " ")
        result = string_replace_all(result, "?", "")
        result = string_replace_all(result, "\\", "")

        if string_length(result) <= 2 {
            namereq = get_string_async("This nickname is too short.\nEnter valid nickname", "Seeker" + scrAddZero(random(999), 2))
        }

        if string_length(result) >= 15 {
            namereq = get_string_async("This nickname is too long (maximum 15 symbols).\nEnter valid nickname", "Seeker" + scrAddZero(random(999), 2))
        }

        if namereq > -1 && instance_exists(MenuOptions) {
            MenuOptions.async_options[$ string(namereq)] = opt

            exit
        }

        optItself.value = result
        save_set_val(opt[0], opt[1], result)
        scrOptionsUpdate()
    }
},

{
    name: "TIMER",
    type: "switch",
    value: 1,
    group: "visual",
    key: "timer"
}, {
    name: "BOSS INTROS",
    type: "switch",
    value: 1,
    group: "visual",
    key: "bossintro"
}, {
    name: "PAUSE BUTTON",
    type: "switch",
    value: 1,
    group: "options",
    key: "pausebutton"
}],

//4 - Controls
[
//{name: "8-WAY MOVEMENT", type: "switch", value: 0, group: "controls", key: "movement"},
{
    name: "AIM ASSIST",
    type: "switch",
    value: 1,
    group: "controls",
    key: "assist"
},
//{name: "AIM RELATING TO", type: "switch", value: 0, group: "controls", key: "assistpos", states: ["PLAYER", "CROSSHAIR"]},
{
    name: "SIMPLIFY",
    type: "switch",
    value: 0,
    group: "visual",
    key: "simplify"
}, {
    name: "GAMEPAD",
    type: "switch",
    value: 0,
    group: "options",
    key: "gamepad"
}, {
    name: "360 AIMBOT",
    type: "button",
    value: 0,
    group: "controls",
    key: "aimbot",
    onClick: function() {
        self.value = !self.value

        self.name = self.value ? "CASUAL GAMING" : "360 AIMBOT"
    },

    onDraw: function(dx, dy) {
        draw_set_halign(fa_right)
        draw_text_shadow(dx - 4, dy, loc(self.name) + ":")

        draw_sprite(sprScoreSplat, 2, dx + 32, dy)

        draw_set_halign(fa_center)
        draw_text_shadow(dx + 32, dy, scrOnOff(self.value))
        draw_set_halign(fa_left)
    }
}, {
    name: "VOLUME CONTROLS",
    type: "switch",
    value: 1,
    group: "controls",
    key: "volumecontrol"
}, {
    name: "SIZE SCALE",
    type: "slider",
    value: 0.5,
    group: "controls",
    key: "scale"
}, {
    name: "REMAP CONTROLS",
    type: "button",

    onClick: function() {
        MenuOptions.editing_mode = 1
        remap_pos = 0
		
        if !UberCont.opt_gamepad {
            instance_create(0, 0, ButtonAct)
            instance_create(0, 0, ButtonActive)
            instance_create(0, 0, ButtonSwap)
            instance_create(0, 0, JoystickMove)
            instance_create(0, 0, JoystickAttack)
        }
    },

    onDraw: function(dx, dy) {
        draw_set_halign(fa_center)
        //draw_sprite(sprScoreSplat, 2, dx, dy)
        draw_text_shadow(dx, dy, loc(self.name))
        draw_set_halign(fa_left)
    }
},

{
    name: "RESET CONTROLS",
    type: "button",

    onClick: function() {
        if !UberCont.opt_gamepad {
            with UberCont {
                ds_map_delete(saveData, "controls_JoystickMove_x")
                ds_map_delete(saveData, "controls_JoystickMove_y")
                ds_map_delete(saveData, "controls_JoystickAttack_x")
                ds_map_delete(saveData, "controls_JoystickAttack_y")
                ds_map_delete(saveData, "controls_ButtonActive_x")
                ds_map_delete(saveData, "controls_ButtonActive_y")
                ds_map_delete(saveData, "controls_ButtonAct_x")
                ds_map_delete(saveData, "controls_ButtonAct_y")
                ds_map_delete(saveData, "controls_ButtonSwap_x")
                ds_map_delete(saveData, "controls_ButtonSwap_y")
            }
        }
		else {
            scrGPadReset()

            var remap_keys = {
                face1: "CONFIRM/PICKUP",
                face2: "BACK/CANCEL",
                face3: "SWAP WEAPON",
                shoulderr: "FIRE",
                shoulderl: "ABILITY",
                padu: "ARROW UP",
                padd: "ARROW DOWN",
                padl: "ARROW LEFT",
                padr: "ARROW RIGHT"
            }

            var names = variable_struct_get_names(remap_keys)

            for (var i = 0; i < array_length(names); i++) {
                var name = names[i]
                save_set_val("gamepadkey", name, gpad[$ name])
            }
        }

        snd_play(sndMutant0Cnfm)
    },

    onDraw: function(dx, dy) {
        draw_set_halign(fa_center)
        //draw_sprite(sprScoreSplat, 2, dx, dy)
        draw_text_shadow(dx, dy, loc(self.name))
        draw_set_halign(fa_left)
    }
}],

// 5 - DATA
[
/*{name: "EXPORT DATA", type: "button", onClick: function() {
			
		}},
		
		{name: "IMPORT DATA", type: "button", onClick: function() {
			
		}},*/

{
    name: "RESET OPTIONS",
    type: "button",
    onClick: function() {
        with MenuOptions
        erasing_progress = 2

        snd_play(sndClick)
    }
},

{
    name: "ERASE PROGRESS",
    type: "button",
    onClick: function() {
        if !instance_exists(GameCont) {
            with MenuOptions {
                erasing_progress = 1
                wait = 10
            }

            snd_play(sndClick)
        }
    }
}]]

foreach(options, function(val) {
    for (var i = 0; i < array_length(val); i++) {
        var v = val[i];

        if !is_undefined(v[$ "value"]) && !is_undefined(v[$ "group"]) {
            v.value = save_get_val(v.group, v.key, v.value)
        }

        if !is_undefined(v[$ "name"]) && v.name == "DELETING IN" {
            v.value = 3
        }
    }
})

options[1, 0].value = clamp(options[1, 0].value, 0, 1)
options[1, 1].value = clamp(options[1, 1].value, 0, 1)
options[1, 2].value = clamp(options[1, 2].value, 0, 1)

if instance_exists(GameCont) {
    array_delete(options[0], 4, 2)
    print("removed some options")
}



category = 0

default_viewx = view_xview
default_viewy = view_yview

if !restart {
    with PauseButton {
        x -= view_xview
        y -= view_yview
    }

    view_xview = 0
    view_yview = 0
}

ingame = instance_exists(GameCont)
wait = 1
changeName = -1
pastebinRequest = -1
getSave = -1
downloadSave = -1
namereq = -1
editing_mode = 0
press = 0
erasing_progress = 0
gamepad_sel = 1

async_options = {}

sliderheld = 0

scrVolume()