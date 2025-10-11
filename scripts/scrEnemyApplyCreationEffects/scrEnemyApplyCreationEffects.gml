function scrEnemyApplyCreationEffects() {
	if skill_get(mut_scarier_face) {
		hp = floor(hp * 0.8)
		
		if hp > max_hp {
			max_hp = hp
		}
	}
	
	if global.hardmode {
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
	with _enemy {
		return object_index == BanditBoss || object_index == ScrapBoss || object_index == LilHunter
			|| object_index == HyperCrystal || object_index == TechnoMancer || object_index == Last
			|| object_index == Nothing && object_index == Nothing2 || object_index == FrogQueen
	}
}