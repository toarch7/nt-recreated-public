if lockstep_stop
	exit

image_blend = hover ? c_white : c_uigray

y -= hover

draw_self()

if (tooltip_pop != 0) {
	/// @loc:token [R:MainMenu] DiscordLink "JOIN OUR DISCORD!"
	scrDrawTooltip(x, bbox_top, loc("R:MainMenu:DiscordLink", "JOIN OUR DISCORD!"), tooltip_pop)
}

tooltip_pop = approach(tooltip_pop, hover ? 2 : 0, timescale)

y += hover
