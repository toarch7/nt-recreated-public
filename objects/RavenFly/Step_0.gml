if sprite_index = sprRavenLift z -= 3
if sprite_index = sprRavenLand z += 3

if sprite_index != sprRavenFly && sprite_index != sprRavenLift && sprite_index != sprRavenLand sprite_index = sprRavenFly

if sprite_index = sprRavenFly {
    speed = 0
    x += lengthdir_x(6, point_direction(x, y, targetx, targety))
    y += lengthdir_y(6, point_direction(x, y, targetx, targety))
}

lifespan = 300