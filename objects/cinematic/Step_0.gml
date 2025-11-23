if lockstep_stop
	exit

with TopCont
drawcontrols = 0

with Player
visible = 0

if alarm[0] == 10 y -= 75

with Crown
instance_destroy()

with IDPDSpawn
instance_destroy()

with WantPopo
instance_destroy()

with WantVan
instance_destroy()