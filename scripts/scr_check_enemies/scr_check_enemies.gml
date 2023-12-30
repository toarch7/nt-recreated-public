function scr_check_enemies() {
    return (instance_number(enemy) + instance_number(becomenemy) - instance_number(Van) - instance_number(BigDogMissile)) > 0
}