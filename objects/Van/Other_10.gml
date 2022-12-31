event_inherited()
speed = 0
if ((drive == 0) && (drivespeed > 0)) drivespeed -= 1
if (drivespeed == 0) meleedamage = 0
if (drivespeed > 0) x += (right * drivespeed)
if (freak == 1) {
    instance_create(((x + random(64)) - 32), ((y + random(64)) - 32), Smoke)
    instance_create(((x + random(64)) - 32), ((y + random(64)) - 32), BlueFlame)
}