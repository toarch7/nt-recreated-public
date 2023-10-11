spr_shadow = shd24
spr_shadow_x = 0
spr_shadow_y = 0
inframes = 0

if !isset("spr_idle") spr_idle = -1

if !isset("spr_hurt") spr_hurt = -1

if !isset("spr_dead") spr_dead = -1

if !isset("spr_chrg") spr_chrg = -1

if !isset("spr_fire") spr_fire = -1

if !isset("index") index = -1

if BruteSync
	net_index = irandom(UINT_MAX)