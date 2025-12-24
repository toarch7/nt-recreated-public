if sprite_index == sprRavenLift {
    sprite_index = sprRavenFly
    alarm[0] = max(point_distance(x, y, targetx, targety) / 6, 1)
	if (alarm[0] < 1) alarm[0] = 1
}
else if (sprite_index == sprRavenLand) {
	event_user(0)
}