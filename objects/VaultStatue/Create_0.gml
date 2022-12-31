max_hp = 50
size = 2
rad = 0

spr_idle = sprVaultStatue
spr_hurt = sprVaultStatueHurt
spr_dead = sprVaultStatueDead

event_inherited()

spr_shadow = mskNone

image_speed = .4

snd_hurt = sndHitRock
snd_dead = sndWallBreak

instance_create(x - 16, y - 16, Floor)

if random(4) < 3 instance_create(x - 16 - 32, y - 16 - 32, Floor)

if random(4) < 3 instance_create(x - 16 + 32, y - 16 + 32, Floor)

if random(4) < 3 instance_create(x - 16 - 32, y - 16 + 32, Floor)

if random(4) < 3 instance_create(x - 16 + 32, y - 16 - 32, Floor)

instance_create(x - 16 - 64, y - 16, Floor)
instance_create(x - 16 - 64, y - 16 - 32, Floor)
instance_create(x - 16 - 64, y - 16 - 64, Floor)
instance_create(x - 16 - 64, y - 16 + 32, Floor)
instance_create(x - 16 - 64, y - 16 + 64, Floor)

instance_create(x - 16 + 64, y - 16, Floor)
instance_create(x - 16 + 64, y - 16 - 32, Floor)
instance_create(x - 16 + 64, y - 16 - 64, Floor)
instance_create(x - 16 + 64, y - 16 + 32, Floor)
instance_create(x - 16 + 64, y - 16 + 64, Floor)

instance_create(x - 16, y - 16 + 64, Floor)
instance_create(x - 16 - 32, y - 16 + 64, Floor)
instance_create(x - 16 + 32, y - 16 + 64, Floor)

instance_create(x - 16, y - 16 - 64, Floor)
instance_create(x - 16 - 32, y - 16 - 64, Floor)
instance_create(x - 16 + 32, y - 16 - 64, Floor)

instance_create(x - 16, y - 16 - 32, Floor)
instance_create(x - 16, y - 16 + 32, Floor)
instance_create(x - 16 - 32, y - 16, Floor)
instance_create(x - 16 + 32, y - 16, Floor)