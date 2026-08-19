if lockstep_stop
	exit

if (!done && UberCont.letterbox) scrLetterbox(false)

with (TopCont) drawcontrols = false

with (Player) visible = false

if (alarm[0] == 10) y -= 75

instance_destroy(CrownObject)

instance_destroy(IDPDSpawn)

instance_destroy(WantPopo)

instance_destroy(WantVan)