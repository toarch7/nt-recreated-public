function scrTurnIntoSkeleton() {
    with GameCont {
        level = 1
        rad = 0
        ultra = 0
        ultrapoints = 0
        patient = -1
        race = other.race
        ds_list_clear(skills)
    }

    maxspeed = 3
    accuracy = 1.5
	
	scrPlayerRaceChange(Race.Skeleton, skin)
	
    with scr_playerinstance_find(index) {
		race = other.race
	}
	
    hurtframes = current_frame + 5
    snd_play_hit_big(sndMutant14Turn, 0.2)
    scrWeapons()
}