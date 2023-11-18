if instance_exists(GenCont)
	exit

with instance_create(x, y, ChestOpen)
	sprite_index = sprIDPDChestOpen

instance_create(x, y, FXChestOpen)

//var _spr = sprPopoAlert

repeat 6 {
	with instance_create(x, y, IDPDSpawn) {
		/*if freak {
			_spr = sprPopoFreakAlert
		}
		else if elite {
			_spr = sprPopoEliteAlert
		}*/
	}
}

//scrAlert(x, y, _spr, AlertType.Popo)