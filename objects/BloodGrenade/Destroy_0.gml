snd_play(sndMeatExplo)
snd_play(sndBloodLauncherExplo)
ang = random_angle
instance_create(x + lengthdir_x(24, ang), y + lengthdir_y(24, ang), MeatExplosion)
instance_create(x + lengthdir_x(24, ang + 120), y + lengthdir_y(24, ang + 120), MeatExplosion)
instance_create(x + lengthdir_x(24, ang + 240), y + lengthdir_y(24, ang + 240), MeatExplosion)


with instance_create(x, y, BloodStreak)
image_angle = other.ang

with instance_create(x, y, BloodStreak)
image_angle = other.ang + 120

with instance_create(x, y, BloodStreak)
image_angle = other.ang + 240