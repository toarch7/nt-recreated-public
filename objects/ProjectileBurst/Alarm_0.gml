/// @description Shot delay logic

if !instance_exists(creator) {
	instance_destroy()
	exit
}

alarm[0] = time

x = creator.x
y = creator.y

direction = creator.gunangle

if (-- ammo) >= 0 {
	event_user(1)
}
else instance_destroy()
