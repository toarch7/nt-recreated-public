/// @description see_object(target,looker)
/// @param target
/// @param looker
function see_object(argument0, argument1) {
    return
    instance_exists(argument0) && instance_exists(argument1) && !collision_line(argument1.x, argument1.y, argument0.x, argument0.y, Wall, 0, 1)
}