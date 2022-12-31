with MusCont alarm[1] = 1

scrDrop(0, 100)

sleep(50)
instance_create(x, y, BigDogExplo)
event_inherited()

with instance_nearest(x, y, Corpse)
instance_destroy()

scrAchievement(31)

if UberCont.april_fools {
    UberCont.cgot[13] = 1
    show_unlock_popup("@wBIG DOG UNLOCKED@s#FOR BEATING BIG DOG")
}