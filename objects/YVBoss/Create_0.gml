raddrop = 0
max_hp = ceil(350 * (1 + GameCont.loops / 3))
if player_count > 1 {
    max_hp = round(max_hp * (1 + player_count / 2))
}

size = 5
meleedamage = 0

right = choose(-1, 1)
back = 1

spr_idle = sprYVBossIdle
spr_walk = sprYVBossIdle
spr_hurt = sprYVBossHurt
spr_dead = sprYVBossDead

event_inherited()

intro = false
gunangle = random_angle
walk = 0

snd_hurt = sndMutant6Hurt
snd_dead = sndMutant6Dead

scrTarget()
if (instance_exists(target)) gunangle = mcr_target_direction;

sndhalfhp = false
sndtaunt = 0
tauntdelay = 0
hitid = HitId.GunGod
minigun_side = choose(1, -1)
can_shoot = true

alarm[1] = 20

// Start off shooting
wep = wep_golden_revolver
alarm[2] = 8
ammo = 5

change_weapon = function(_wep) {
	if (!scr_weapon_is_valid(_wep)) exit
	
	snd_play(wep_swap[_wep])
	snd_play(sndSwapGold)
	wep = _wep
		
	with (instance_create(x, y, WepSwap)) {
		creator = other.id
	}
}