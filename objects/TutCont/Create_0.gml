enum TutorialStep {
	Walking = 1,
	PickingUp,
	Shooting,
	Swapping,
	Power,
	Fin,
	
	NUM_TUTORIAL_STEPS
}

letterbox = false
step_current = TutorialStep.Walking
step_complete = false

#region Generate area

var w = choose(3, 4),
	h = choose(3, 4)

for (var xx = -w; xx <= w; xx ++) {
    for (var yy = -h; yy <= h; yy ++) {
		if (abs(xx) == w && abs(yy) == h) && irandom(2)
			continue
		
        instance_create(10000 + xx * 32, 10000 + yy * 32, Floor)
    }
}

var ang = 45

repeat 4 {
	var f = instance_nearest(10000 + ldrx(196, ang), 10000 + ldry(196, ang), Floor)
	
	if instance_exists(f) {
		instance_create(f.x + 16, f.y + 16, TutorialTarget)
	}
	
	ang += 90
}

#endregion

complete_step = function(_step) {
	if (step_current == _step && !step_complete) {
		step_complete = true
		alarm[0] = 30
	}
}


circle_active = false
drawx = view_width / 2
drawy = view_height / 2

wave = 0

/// @loc:token [Tutorial] Touch:1 "WALK USING @wMOVEMENT STICK"
text[TutorialStep.Walking, 0] = "WALK USING @wMOVEMENT STICK"
text[TutorialStep.Walking, 1] = "WALK USING @w%1,%2,%3,%4#@s OR THE @wARROW KEYS"
text[TutorialStep.Walking, 2] = "WALK USING @w% LEFT JOYSTICK"

/// @loc:token [Tutorial] Touch:2 "PICK UP NEW WEAPON USING THE @wINTERACT BUTTON"
text[TutorialStep.PickingUp, 0] = "PICK UP NEW WEAPON USING THE @wINTERACT BUTTON"
text[TutorialStep.PickingUp, 1] = "PICK UP A NEW WEAPON WITH @w%"
text[TutorialStep.PickingUp, 2] = "PICK UP NEW WEAPON WITH @w% BUTTON"

/// @loc:token [Tutorial] Touch:3 "AIM USING THE @wATTACK JOYSTICK@s#TOUCHING THEN RELEASING WILL FIRE"
text[TutorialStep.Shooting, 0] = "AIM USING THE @wATTACK JOYSTICK@s#TOUCHING THEN RELEASING WILL FIRE"
text[TutorialStep.Shooting, 1] = "AIM USING THE MOUSE, @wLEFT BUTTON@s FIRES"
text[TutorialStep.Shooting, 2] = "AIM USING @1(butsmall:aim), @1(butsmall:fire) FIRES"

/// @loc:token [Tutorial] Touch:4 "SWAP WEAPONS USING THE @wSWAP BUTTON#TRY IT A FEW TIMES!"
text[TutorialStep.Swapping, 0] = "SWAP WEAPONS USING THE @wSWAP BUTTON#TRY IT A FEW TIMES!"
text[TutorialStep.Swapping, 1] = "SWAP WEAPONS WITH @w%@s#TRY IT A FEW TIMES!"
text[TutorialStep.Swapping, 2] = "SWAP WEAPONS WITH @1(butsmall:swap)#TRY IT A FEW TIMES!"

/// @loc:token [Tutorial] Touch:5 "@wABILITY BUTTON@s USES YOUR SPECIAL SKILL#@wGIVE IT A GO!"
text[TutorialStep.Power, 0] = "@wABILITY BUTTON@s USES YOUR SPECIAL SKILL#@wGIVE IT A GO!"
text[TutorialStep.Power, 1] = "@wRIGHT MOUSE BUTTON@s USES YOUR ABILITY#GIVE IT A GO!"
text[TutorialStep.Power, 2] = "(butsmall:spec) USES YOUR ABILITY#GIVE IT A GO!"

text[TutorialStep.Fin, 0] = loc("Tutorial:Default:6", "COOL, WE'RE DONE HERE!")
