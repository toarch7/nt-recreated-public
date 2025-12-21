if !instance_is(self, WepstickAttack) && instance_number(object_index) > 1 {
	instance_destroy(); exit
}

index = -1
smoothrad = 0

self[$ "key"] ??= object_get_name(object_index)

event_user(10)