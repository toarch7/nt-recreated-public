if lockstep_stop
	exit

if hp <= 0 {
	instance_destroy()
	exit
}

if (inframes) inframes -= timescale

motion_add(direction, 0.8)

if scrTargetIsVisible(target) motion_add(mcr_target_direction, 0.4)

if (speed > 4) speed = 4