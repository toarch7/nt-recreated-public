if lockstep_stop
	exit

image_blend = hover ? c_white : c_uigray

y -= hover

draw_self()

if (hover) scrDrawTooltip(x, bbox_top, loc("JOIN OUR DISCORD!"))

y += hover
