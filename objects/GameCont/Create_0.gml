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
ultrapoints = 0
last_hit = -1
rad = 0
level = 1
enemies = 0
timer = 0
tottimer = 0
seconds = 0
minutes = 0
banditbosses = 0
blacksword = 0
guitar = 0
horror = 0
vans = 0
spawn_vans = 0
destiny = 0
start = 0
proto = 0
ultra = 0
coopultra = 0
heavyheart = 0
wantheavy = 0
triedhq = 0
want_oasis = 0
gonna_oasis = 0
crownrad = 0
wasskeleton = 0
skills = ds_list_create()

patiencepick = 0
patienceskill = 0
patient = 0

waypoints = 0
waypnt[0] = 1
waysub[0] = 1
waylps[0] = 0

hqarea = 1
hqsubarea = 1

popolevel = 0
novans = 1

if !UberCont.continued_run {
    rng_init()
}

scrRaces()
scrCrowns()
scrSkills()
scrUltras()

alarm[10] = 30

if global.hardmode {
    loops++hard = 13
}

gocrib = 0
openminds = 0

win = 0

level_end = 0

// set tip as seen on new run
if save_get_val("etc", "saving_tip", 0) == -1 {
    save_set_val("etc", "saving_tip", 1)
}