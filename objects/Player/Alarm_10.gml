alarm[10] = 30

scrUnlocksPlayerEquipment(id)

if scr_player_ultra_get(id, Race.Horror, UltraSkill.Anomaly) && !instance_exists(GenCont) && !instance_exists(Portal) {
    var _enemy_hp = 0
		
    with enemy {
	    if (object_index != Van) {
			_enemy_hp += hp
			if (_enemy_hp > 150) break
		}
	}
		
    if (_enemy_hp <= 150) {
		with (enemy) hp = 0
        snd_play_hit_big(sndHorrorPortal)
		scr_screenshake(15)
	}
}
	
if instance_exists(Floor) && id == instance_find(Player, 0) {
	with (enemy) {
		if (!position_meeting(x, y, Floor) && !scrEnemyIsBoss(id)) hp = 0
	}
}