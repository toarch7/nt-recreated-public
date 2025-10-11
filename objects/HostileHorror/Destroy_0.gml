instance_create(x, y, PortalClear)

raddrop += 25

event_inherited()

if instance_exists(Player) && hp <= 0 {
    scrRaceUnlock(Race.Horror)
}