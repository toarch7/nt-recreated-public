if lockstep_stop
	exit

if !position_meeting(x, y, Floor) instance_create(x, y, TopSmall)

if !position_meeting(x + 16, y, Floor) instance_create(x + 16, y, TopSmall)

if !position_meeting(x, y + 16, Floor) instance_create(x, y + 16, TopSmall)

if !position_meeting(x + 16, y + 16, Floor) instance_create(x + 16, y + 16, TopSmall)

instance_destroy()