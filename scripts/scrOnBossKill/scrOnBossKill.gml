function scrOnBossKill() {
	if (instance_is(self, TechnoMancer) && instance_number(object_index) > 1) exit
	
	var _object = object_index, _instance = id
	
	if (_object == LilHunterFly) _object = LilHunter
	
	with (Player) {
		if (!scr_player_is_local(index)) continue
		
		var _race = race
		
		switch (_object) {
			case BanditBoss:
				scrAchievementUnlock(Achievement.BOSS_BIGBANDIT)
				break
			case ScrapBoss:
				scrAchievementUnlock(Achievement.BOSS_BIGDOG)
				if (UberCont.april_fools) scrRaceUnlock(Race.BigDog)
				break
			case LilHunter:
				scrAchievementUnlock(Achievement.BOSS_LILHUNTER)
				break
			case Nothing:
				scrUnlocksThroneDefeat()
				scrAchievementUnlock(Achievement.BOSS_THRONE)
				break
			case Nothing2:
				scrAchievementUnlock(Achievement.BOSS_THRONE2)
				break
			case FrogQueen:
				if (_race == Race.Rebel) {
					scrRaceUnlockSkin(Race.Rebel, SkinLetter.B)
				}
				scrAchievementUnlock(Achievement.BOSS_MOM)
				break
			case HyperCrystal:
				if (_race == Race.Horror) {
					scrRaceUnlockSkin(Race.Horror, SkinLetter.B)
			    }
				scrAchievementUnlock(Achievement.BOSS_BIGBANDIT)
				break
			case TechnoMancer:
				if (_race == Race.Steroids) {
					scrRaceUnlockSkin(Race.Steroids, SkinLetter.B)
				}
				scrAchievementUnlock(Achievement.BOSS_TECHNOMANCER)
				break
			case Last:
				if (_race == Race.Rogue) {
					scrRaceUnlockSkin(Race.Rogue, SkinLetter.B)
				}
				scrAchievementUnlock(Achievement.BOSS_CAPTAIN)
				break
			case YVBoss:
				if (_race == Race.Cuz) {
					scrRaceUnlockSkin(Race.Venuz, SkinLetter.C)
				}
				break
		}
		
		#region Black Sword boss hit list
			// apparently you don't need to play as Chicken for this achievement. Oh well
			
			var _any = false
			
			with (Player) {
				if (/*race == Race.Chicken && */scrPlayerHasWeapon(id, wep_black_sword)) {
					_any = true
					break
				}
			}
			
			// count in thrown weps
			with (WepPickup) {
				if (wep == wep_black_sword && mask_index != mskWepPickup
					&& instance_is(creator, Player) && creator.race == Race.Chicken
				) {
					_any = true
				}
			}
		
			if (_any) {
				var _list = GameCont.swordbosskill,
					_object_name = object_get_name(_object)
				
				if (!array_contains(_list, _object_name)) array_push(_list, _object_name)
				
				if (array_contains(_list, nameof(BanditBoss)) && array_contains(_list, nameof(ScrapBoss)) && array_contains(_list, nameof(LilHunter))
					&& array_contains(_list, nameof(Nothing)) && array_contains(_list, nameof(Nothing2)) && array_contains(_list, nameof(FrogQueen))
					&& array_contains(_list, nameof(HyperCrystal)) && array_contains(_list, nameof(Last))
				) {
					scrRaceUnlockSkin(Race.Chicken, SkinLetter.C)
				}
			}
		#endregion
	}
}