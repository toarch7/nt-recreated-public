#region make menu

image_speed = 0

if global.is_server {
	var _offset = LETTERBOX_SIZE - sprite_get_bbox_height(sprGoButton)
    instance_create(view_width, view_height - _offset div 2, GoButton)
}

crown = crwn_none
race = Race.Random

char = array_create(Race.NUM_ALL_RACE_TYPES, noone)

scrCampfireMenuCreate()

with Campfire {
	scr_camera_set_position(x, y)
	break
}

var _slot_index = 0,
	_slot_height = sprite_get_height(sprCharSelect),
	_slot_ystart = view_height - _slot_height - ((LETTERBOX_SIZE - _slot_height) div 2),
	_slot_step_size = 20,
	_slot_xstart = 8,
	_slot_x = _slot_xstart;

for (var _race_id = Race.Random; _race_id < Race.NUM_ALL_RACE_TYPES; ++_race_id) {
	if scrRaceIsHidden(_race_id) && !scr_race_is_unlocked(_race_id) continue
	
	// relative to the camera
	_slot_x = _slot_xstart + _slot_step_size * _slot_index
	
    with instance_create(_slot_x, _slot_ystart, CharSelect) {
        slot_index = _slot_index
        race = _race_id
    }
	
	_slot_index ++
}

with GoButton {
	if _slot_x >= bbox_left {
		instance_destroy()
	}
}

#endregion

portrait_offsets = array_create(INPUT_MAX_PLAYERS, 0)
textappear = array_create(INPUT_MAX_PLAYERS, 2)
splatindex = 0

loadout_open = false
loadout_crown = crwn_none
loadout_frame = 0
loadout_arrow_pointed = false
loadout_crown_pointed = false
loadout_skin_pointed = false
loadout_weapon_pointed = false

weekly = false

if scrGameIsWeeklyRun() {
	scrMenuPrepareWeeklyLoadout()
	weekly = true
}

unlock_hint = ""
unlock_hint_pop = 0

if !instance_exists(MusCont) {
	instance_create(0, 0, MusCont)
}

with MusCont {
	audio_stop_sound(amb)
	amb = custom_sound_check(amb0)
	snd_play_loop(amb)
}

event_user(0)

menu_hid_offset = 0

if instance_exists(char[race]) {
	with char[race] {
	    view_xview = x - view_width / 2
	    view_yview = y - view_height / 2
	}
	
	scr_camera_set_position(view_xview, view_yview)
}

loadout_wep = 0
loadout_bwep = 0

gpadmode = false
gpadpointed = 0

mousex = gui_w / 2
mousey = gui_h / 2

event_perform(ev_step, ev_step_begin)

seed_prompt = -1
seed_pointed = false
seed_splat = 0
seed_text = "random"

if global.custom_seed {
	seed_text = string(global.custom_seed)
}

alarm[10] = 5