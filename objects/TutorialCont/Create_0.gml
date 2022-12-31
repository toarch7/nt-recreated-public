pos = 0

text[0] = "WALK USING @wLEFT MOVEMENT STICK"
text[1] = "PICK UP NEW WEAPON WITH @wACT. BUTTON"
text[2] = "SWAP WEAPONS WITH @wSWAP BUTTON#TRY IT A FEW TIMES!"
text[3] = "@wRMB BUTTON@s USES YOUR ABILITY#GIVE IT A GO!"
text[4] = "COOL, WE'RE DONE HERE!"

letterbox = 0

doin = 0

for (var xx = -4; xx <= 4; xx++) {
    for (var yy = -4; yy <= 4; yy++) {
        instance_create(10016 + xx * 32, 10016 + yy * 32, Floor)
    }
}

wave = 0

if global.pc_build or UberCont.opt_gamepad {
    alarm[0] = 45
}