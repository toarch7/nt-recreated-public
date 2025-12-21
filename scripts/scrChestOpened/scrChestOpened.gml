// called whenever chest is being opened
// return any value >=0.5 to prevent further event code
function scrChestOpened() {
	if instance_exists(GenCont)
		return true
	
	var p = instance_nearest(x, y, Player)
	
	if (!instance_exists(p)) exit
	
	// crown of hatred
	if instance_is(other, Player) && scrCrownCheck(Crown.Hatred) {
		with (p) {
			if (mask_index == mskNone) break
			
		    scr_hit_self(1, HitId.CrownOfHatred)
			
			var _amount = 16
			if instance_is(other, RadChest) {
				_amount = 24
			}
			
		    repeat _amount {
		        with (instance_create(x, y, Rad)) {
					motion_add(random_angle, 2 + random(4))
				}
			}
		}
	}
}