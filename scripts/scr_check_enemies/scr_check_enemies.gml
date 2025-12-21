/// @function scr_check_enemies
/// @param amount=0
function scr_check_enemies(_amount = 0) {
    return (instance_number(enemy) + instance_number(becomenemy) - instance_number(Van) - instance_number(BigDogMissile)) > _amount
}