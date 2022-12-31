function scr_check_enemies() {
    return (instance_number(enemy) + instance_number(RavenFly) + instance_number(becomenemy) + instance_number(BigMaggotBurrow) + instance_number(WantBoss) - instance_number(Van) - instance_number(BigDogMissile)) > 0
}