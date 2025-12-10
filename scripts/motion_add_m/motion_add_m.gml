/// @function motion_add_m
/// @param direction
/// @param speed
/// @param limit=16
function motion_add_m(_direction, _speed, _limit = 16) {
    motion_add(_direction, _speed)

    if speed > _limit {
        speed = _limit
    }
}