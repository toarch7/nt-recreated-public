if lockstep_stop
	exit

scrDrawSpiral()
	
// will draw portraits and the letterbox
scrMenuDrawPlayersOrdered(view_xview, view_yview, scrCampfireMenuDrawRacePortrait)

with CharSelect {
    x = view_xview + xstart
    y = view_yview + ystart
}

with GoButton {
	x = view_xview + xstart
    y = view_yview + ystart
}
