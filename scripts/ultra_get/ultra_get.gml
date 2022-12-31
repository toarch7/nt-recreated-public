/// @description ultra_get(ultra)
/// @param ultra
function ultra_get(argument0) {
    if instance_exists(Player) {
        return Player.ultra == argument0
    }

    return 0



}