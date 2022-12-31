var enemies = []

with enemy
if team == other.team {
    instance_deactivate_object(id)
    array_push(enemies, id)
}

target = instance_nearest(x, y, enemy)

for (var i = 0; i < array_length(enemies); i++) {
    instance_activate_object(enemies[i])
}

alarm[2] = 7