event_inherited()
speed = 0

if (!drive && drivespeed > 0) drivespeed --

if (drivespeed <= 0) meleedamage = 0

if (drivespeed > 0) x += right * drivespeed

if (freak) {
    instance_create(x + orandom(32), y + orandom(32), Smoke)
    instance_create(x + orandom(32), y + orandom(32), BlueFlame)
}