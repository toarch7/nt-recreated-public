audio_stop_sound(snd)
snd_play_hit_big(sndBloodCannonEnd, 0.2)
instance_create(x, y, PortalClear)
ang = random(360)
with(instance_create((x + lengthdir_x(24, ang)), (y + lengthdir_y(24, ang)), MeatExplosion))
hit_id = other.hit_id
with(instance_create((x + lengthdir_x(24, (ang + 60))), (y + lengthdir_y(24, (ang + 120))), MeatExplosion))
hit_id = other.hit_id
with(instance_create((x + lengthdir_x(24, (ang + 120))), (y + lengthdir_y(24, (ang + 240))), MeatExplosion))
hit_id = other.hit_id
with(instance_create((x + lengthdir_x(24, (ang + 180))), (y + lengthdir_y(24, ang)), MeatExplosion))
hit_id = other.hit_id
with(instance_create((x + lengthdir_x(24, (ang + 240))), (y + lengthdir_y(24, (ang + 120))), MeatExplosion))
hit_id = other.hit_id
with(instance_create((x + lengthdir_x(24, (ang + 300))), (y + lengthdir_y(24, (ang + 240))), MeatExplosion))
hit_id = other.hit_id
with(instance_create(x, y, BloodStreak))
image_angle = other.ang
with(instance_create(x, y, BloodStreak))
image_angle = (other.ang + 120)
with(instance_create(x, y, BloodStreak))
image_angle = (other.ang + 240)