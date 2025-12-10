alarm[10] = 10

try {
    if scrUltraCheckPlayerRace(id, Race.Horror, UltraSkill.Anomaly) && !instance_exists(GenCont) && !instance_exists(Portal) {
        var _enemy_hp = 0
		
        with enemy {
	        if (object_index != Van) {
				_enemy_hp += hp
				if (_enemy_hp > 150) break
			}
		}
		
        if _enemy_hp <= 150 {
			with (enemy) hp = 0
            snd_play_hit_big(sndHorrorPortal)
			scr_screenshake(15)
		}
    }
	
	if instance_exists(Floor) && id == instance_find(Player, 0) {
		with (enemy) {
			if (scrEnemyIsBoss(id) && !position_meeting(x, y, Floor)) hp = 0
		}
	}
	
    if UberCont.opt_walls {
        var _l = global.lis_walls_visible,
			_c = ds_list_size(_l)

        for (var i = _c - 1; i >= 0; --i) {
            with _l[| i] {
                visible = place_meeting(x, y + 16, Floor)
				
                if place_free(x - 16, y) l = 0 else l = 4
                if place_free(x + 16, y) w = 24 - l else w = 20 - l
                if place_free(x, y - 16) r = 0 else r = 4
                if place_free(x, y + 16) h = 24 - r else h = 20 - r
				
                if !position_meeting(x, y - 16, TopSmall) instance_create(x, y - 16, TopSmall)
                if !position_meeting(x, y + 16, TopSmall) instance_create(x, y + 16, TopSmall)
                if !position_meeting(x - 16, y, TopSmall) instance_create(x - 16, y, TopSmall)
                if !position_meeting(x + 16, y, TopSmall) instance_create(x + 16, y, TopSmall)

                if !position_meeting(x - 16, y - 16, TopSmall) instance_create(x - 16, y - 16, TopSmall)
                if !position_meeting(x + 16, y + 16, TopSmall) instance_create(x + 16, y + 16, TopSmall)
                if !position_meeting(x - 16, y + 16, TopSmall) instance_create(x - 16, y + 16, TopSmall)
                if !position_meeting(x + 16, y - 16, TopSmall) instance_create(x + 16, y - 16, TopSmall)
            }
        }
    }
} catch (e) {
    print(e.message)
}
