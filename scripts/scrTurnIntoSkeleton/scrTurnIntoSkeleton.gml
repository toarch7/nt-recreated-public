function scrTurnIntoSkeleton() {
    with GameCont {
        level = 1
        rad = 0
        ultrapoints = 0
        patient = -1
        race = other.race
        ds_list_clear(skills)
		
		repeat (4) {
			var _ultra = scr_ultra_get_from_race(Race.Melting)
			
			if (_ultra != -1) {
				scr_ultra_set(Race.Melting, _ultra, false)
			}
		}
    }

    maxspeed = 3
    accuracy = 1.5
	
	scrPlayerRaceChange(Race.Skeleton, scr_loadout_race_get_skin(Race.Skeleton))
	
    with (scr_playerinstance_find(index)) race = other.race
	
	hurtframes = current_frame + 5
    sprite_index = spr_hurt
	image_index = 0
    
	snd_play_hit_big(sndMutant14Turn, 0.2)
    
	scrWeapons()
}