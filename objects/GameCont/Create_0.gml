skills = -1

if instance_number(object_index) > 1 {
    instance_destroy(id, 0) exit
}

area = 1
subarea = 0
race = 0
bskin = 0
hard = 0
crown = 0
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
last_hit = -1
rad = 0
max_rad = 60
level = 1
enemies = 0
timer = 0
tottimer = 0
seconds = 0
minutes = 0
banditbosses = 0
give_blacksword = 0
guitar = false
horror = false
vans = 0
spawn_vans = 0
destiny = 0
start = 0
proto = 0
// TODO: refactor to support multiple players ultras
ultra = 0
coopultra = 0
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

popolevel = 0
novans = true

underwater = false

if !UberCont.continued_run {
    scrRngStatesInit()
}

scrCrowns()
scrSkills()
scrUltras()

if global.hardmode {
    loops ++
	hard = 13
}

gocrib = false
fromcrib = false
openminds = 0
win = false

is_level_ended = false
levseed = global.seed

// set tip as seen on new run
if save_get_value("etc", "saving_tip", 0) == -1 {
    save_set_value("etc", "saving_tip", 1)
}