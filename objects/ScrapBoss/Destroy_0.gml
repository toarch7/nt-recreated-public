with MusCont alarm[1] = 1

scrDrop(0, 100)

sleep(50)
instance_create(x, y, BigDogExplo)
event_inherited()

with instance_nearest(x, y, Corpse)
instance_destroy()

scrAchievementUnlock(31)

if UberCont.april_fools {
    UberCont.cgot[13] = 1
    scrShowUnlockPopup("@wBIG DOG UNLOCKED@s#FOR BEATING BIG DOG")
}