/// @description Bolt marrow

if instance_exists(enemy) && instance_exists(Player) {
    if speed > 0 && scr_skill_get(mut_bolt_marrow) && damage {
        var _target = instance_nearest(x, y, enemy)

        if point_distance(x, y, _target.x, _target.y) < marrow_distance {
            x = _target.x - hspeed
            y = _target.y - vspeed
        }
    }
}
