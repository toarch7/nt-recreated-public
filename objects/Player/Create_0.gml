event_inherited()

race = Race.Fish
bskin = 0
index = 0
is_me = false
gunangle = 0
team = team_player
raddrop = 0
cantoxic = 1
patient = -1
size = 5
curse = false
bcurse = false
reload = 0
breload = 0
wep = wep_none
bwep = wep_none
can_shoot = true
bcan_shoot = false

scrAmmoInit()

last_hit = -1
inframes = 0
		
clicked = false
wepflip = 1
angle = 0
wkick = 0
bwkick = 0
bwepangle = 0
bwepflip = 1

bleed = 0
headloses = 0
right = false
wepright = false
back = false
wave = 0
roll = false
drawempty = 0
drawlowhp = 0

infammo = 0
hp_diff = 0

show_empty_cooldown = 0

rogue_ammo = 1
rogue_ammo_max = 3

hammerhead = 0
hammerhead_charges = 0
footstep = 0
footextra = 0
trigger_fingers_shine = 0
spirit = skill_get(mut_strong_spirit)
can_spirit = spirit
spirit_anim = 0
spirit_index = 0
aimassist_wait = 0
canwalk = true
wepangle = 0
canshield = 0
horrorbeam = 0
skeletongamble = 0
frogcharge = 0
froggas = 0
horrortime = 0
horrornorad = 0
can_pick = true
can_die = true

crosshair_x = x
crosshair_y = y

crosshair_alpha = 0

fainted = false

active_button_forever = 0

recontinues = 0

pref = function(name) {
	var _pinst = scr_playerinstance_find(index)
	return is_struct(_pinst) ? scr_player_pref(_pinst, name) : undefined
}

friction = 0.45
image_speed = 0.4
