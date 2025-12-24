event_inherited()

hp = 8
max_hp = hp
lsthealth = hp
race = Race.Fish
bskin = 0
index = 0
is_me = false
maxspeed = 4
accuracy = 1
gunangle = 0
team = team_player
raddrop = 0
cantoxic = true
patient = -1
size = 5
curse = false
bcurse = false
reload = 0
breload = 0
wep = wep_none
bwep = wep_none
hitid = HitId.Player
totdamagetaken = 0

snd_hurt = sndMutant1Hurt
snd_dead = sndMutant1Dead
snd_lowa = sndMutant1LowA
snd_lowh = sndMutant1LowH
snd_crwn = sndMutant1Crwn
snd_chst = sndMutant1Chst
snd_wrld = sndMutant1Wrld
snd_thrn = sndMutant1Thrn
snd_valt = sndMutant1Valt
snd_spch = sndMutant1Spch
snd_cptn = sndMutant1Spch
spr_idle = sprMutant1Idle
spr_walk = sprMutant1Walk
spr_hurt = sprMutant1Hurt
spr_dead = sprMutant1Dead
spr_gosit = sprMutant1GoSit
spr_sit = sprMutant1Sit
spr_cry = -1

scrPlayerAmmoInit()
		
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
cuz_ammo = 1
cuz_ammo_max = 3
scrExtraWepsInit()

hammering = 0
hammerhead = 0
footstep = 0
footextra = 0
trigger_fingers_shine = 0
spirit = scr_skill_get(mut_strong_spirit)
spirit_anim = 0
spirit_index = 0
aimassist_wait = 0
wepangle = 0
horrorbeam = 0
skeletongamble = 0
frogcharge = 0
froggas = 0
horrortime = 0
horrornorad = 0
veinsthreshold = 4
specfiring = false
can_pick = true
can_die = true
can_spirit = spirit
can_walk = true
can_aim = true
can_shoot = true
bcan_shoot = false
can_spec = true
swapanim = 0

crosshair_x = x
crosshair_y = y

crosshair_alpha = 0

fainted = false

active_button_forever = 0

aimassist_target = noone

recontinued_times = 0

eyesloop = -1
horrorloop = -1

pref = function(name) {
	var _pinst = scr_playerinstance_find(index)
	return is_struct(_pinst) ? scr_player_pref(_pinst, name) : undefined
}

friction = 0.45
image_speed = 0.4
alarm[10] = 10