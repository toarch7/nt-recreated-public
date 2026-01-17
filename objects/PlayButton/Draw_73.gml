
if (num == 4 && !available && !appear && mouse_ui_hovered(id, false, false)) {
	if (!tooltip) {
		tooltip = true
		tooltip_pop = 1
	}
	else if (tooltip_pop) tooltip_pop --
	
	/// @loc:token [R:MainMenu] CustomModeTBA "CUSTOM MODE WILL BE AVAILABLE#IN FUTURE UPDATES"
	scrDrawTooltip(x, bbox_top, loc("R:MainMenu:CustomModeTBA", "CUSTOM MODE WILL BE AVAILABLE#IN FUTURE UPDATES"), tooltip_pop)
}
else if (tooltip) tooltip = false
