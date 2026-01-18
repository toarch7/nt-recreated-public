if instance_number(object_index) > 1 {
    instance_destroy(id, false) exit
}

scrAmmoInit()

area = 1
subarea = 0
hard = 0
crown = crwn_none
lastarea = 1
lastsubarea = 1
loops = 0
nochest = 0
noradch = 0
skillpoints = 0
crownpoints = 0
kills = 0
crownvisits = 0
junglevisits = 0
ultrapoints = 0
deathcause = -1
rad = 0
max_rad = 60
level = 1
enemies = 0
timer = 0
tottimer = 0
seconds = 0
minutes = 0
banditbosses = 0
blackswords = 0
guitar = false
horror = false
vans = 0
spawn_vans = 0
destiny = 0
start = 0
proto = 0
heavyheart = false
wantheavy = false
triedhq = false
want_oasis = false
gonna_oasis = false
crownrad = 0
wasskeleton = false
skills = ds_list_create()

patiencepick = 0
patienceskill = 0
patient = 0
codpick = false
waypoints = 0
waypnt[0] = 1
waysub[0] = 1
waylps[0] = 0
can_advance_stage = true
hqarea = 1
hqsubarea = 1
maxsubarea = 0
finalsubarea = false

hasfiredshots = false
haspickedweps = false
swordbosskill = []

same_weapon_signature = -1
same_weapons_for = 0

popolevel = 0
novans = true

underwater = false

if (!UberCont.continued_run) scrRngStatesInit()

scrUltrasReset()
scrCrowns()
scrSkills()
scrUltras()

if scrGameIsHardmode() {
	hard = 13
    loops ++
}

gocrib = false
fromcrib = false
win = false

is_level_ended = false
levseed = global.seed

persistentweps = undefined

// set tip as seen on new run
if (save_get_value("etc", "saving_tip", 0) == -1) {
    save_set_value("etc", "saving_tip", 1)
}