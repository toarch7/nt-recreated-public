instance_create(x, y, MeatExplosion)

ang = random_angle

instance_create(x + lengthdir_x(24, ang), y + lengthdir_y(24, ang), MeatExplosion)
instance_create(x + lengthdir_x(24, ang + 120), y + lengthdir_y(24, ang + 120), MeatExplosion)
instance_create(x + lengthdir_x(24, ang + 240), y + lengthdir_y(24, ang + 240), MeatExplosion)

instance_create(x, y, Scorchmark)