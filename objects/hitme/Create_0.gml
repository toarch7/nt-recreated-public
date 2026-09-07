spr_shadow = shd24
spr_shadow_x = 0
spr_shadow_y = 0
team = team_none
nexthurt = 0
right = 1

if (!variable_instance_exists(id, "hitid")) hitid = HitId.None

self[$ "spr_idle"] ??= -1
self[$ "spr_hurt"] ??= -1
self[$ "spr_dead"] ??= -1
self[$ "spr_chrg"] ??= -1
self[$ "spr_fire"] ??= -1

self[$ "raddrop"] ??= 0
self[$ "size"] ??= 1