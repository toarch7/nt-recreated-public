function scrCreateMobileControls(){
	instance_create(0, 0, ButtonAct)
	instance_create(0, 0, ButtonActive)
	
	
	if UberCont.opt_wepstick {
		with instance_create(0, 0, WepstickAttack)
			primary = true
		
		with instance_create(0, 0, WepstickAttack)
			primary = false
		
		with WepstickAttack {
			key += primary ? "_A" : "_B"
			active = primary
			
			event_user(10)
			
			if !custom_position {
				if primary {
					x -= 48
					y += 12
				}
				else {
					y -= 12
				}
			}
		}
	}
	else {
		instance_create(0, 0, ButtonSwap)
		instance_create(0, 0, JoystickAttack)
	}
	
	instance_create(0, 0, JoystickMove)
	
	if UberCont.opt_splitfire
		instance_create(0, 0, ButtonAttack)
}