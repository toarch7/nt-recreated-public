pos = 0

text[0, 0] = "WALK USING @wMOVEMENT STICK"
text[0, 1] = "WALK USING @w% KEYS"
text[0, 2] = "WALK USING @w% LEFT JOYSTICK"

text[1, 0] = "PICK UP NEW WEAPON WITH @wACT. BUTTON"
text[1, 1] = "PICK UP NEW WEAPON WITH @w% KEY"
text[1, 2] = "PICK UP NEW WEAPON WITH @w% BUTTON"

text[2, 0] = "SWAP WEAPONS USING @wSWAP BUTTON#TRY IT A FEW TIMES!"
text[2, 1] = "SWAP WEAPONS USING @w%#TRY IT A FEW TIMES!"
text[2, 2] = "SWAP WEAPONS USING @w% BUTTON#TRY IT A FEW TIMES!"

text[3, 0] = "@wABILITY BUTTON@s USES YOUR SPECIAL SKILL#@wGIVE IT A GO!"
text[3, 1] = "@w%@s USES YOUR ABILITY#@wGIVE IT A GO!"
text[3, 2] = "@w% BUTTON@s USES YOUR ABILITY#@wGIVE IT A GO!"

text[4] = "COOL, WE'RE DONE HERE!"

letterbox = 0

doin = 0

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



wave = 0
