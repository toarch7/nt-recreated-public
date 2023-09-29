if !instance_is(self, SwapstickAttack) && instance_number(object_index) > 1 {
	instance_destroy(); exit
}

index = -1

self[$ "key"] ??= object_get_name(object_index)

event_user(10)