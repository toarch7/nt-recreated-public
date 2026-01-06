function scrEnemyApplyCreationEffects() {
	gml_pragma("forceinline")
	if scr_skill_get(mut_scarier_face) {
		hp = floor(hp * 0.8)
		
		if max_hp > hp {
			max_hp = hp
		}
	}
	
	if UberCont.hardmode {
		raddrop = floor(raddrop * 0.5)
	}
	
	if scrCrownCheck(crwn_blood) {
		raddrop -= 1
	}
	
	if scrCrownCheck(crwn_luck) && random(1) <= 0.1 && !scrEnemyIsBoss(id) {
		hp = 1
	}
}

function scrEnemyIsBoss(_enemy) {
	gml_pragma("forceinline")
	return instance_exists(_enemy) && object_is_ancestor(_enemy.object_index, bossenemy)
}