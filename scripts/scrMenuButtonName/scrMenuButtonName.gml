function scrMenuButtonName(_sprite_index = sprite_index, _image_index = image_index) {
	static _L = function(_key, _default) {
		for(var i = 1; i < argument_count - 1; ++i) {
			_key += ":" + string(argument[i])
		}
		
		return loc_exists(_key) ? undefined : loc(_key, _default)
	}
	
    switch _sprite_index {
        case sprMainMenuButtons:
            switch _image_index {
                case 0: return loc("MainMenu:Play", "PLAY")
                case 1: return loc("MainMenu:Coop", "CO-OP")
                case 2: return loc("MainMenu:Settings", "SETTINGS")
                case 3: return loc("MainMenu:Stats", "STATS")
                case 4: return loc("MainMenu:Quit", "QUIT")
            }
            break

        case sprPlayButtons:
            switch _image_index {
                case 0: return loc("PlayMenu:Normal", "NORMAL")
                case 1: return loc("PlayMenu:Daily", "DAILY")
                case 2: return loc("PlayMenu:Weekly", "WEEKLY")
                case 3: return loc("PlayMenu:Hardmode", "HARD")
                case 4: return loc("PlayMenu:Custom", "CUSTOM")
            }
            break

        case sprBigName:
        case sprBigNameCentered:
        case sprBigNameCenteredB:
			return loc("Races", _image_index, "Name", scrRaceGetName(_image_index))
            break

        case sprPauseButton:
            switch _image_index {
                case 0: return loc("PauseMenu:BackToMenu", "MENU")
                case 1: return loc("PauseMenu:Retry", "RETRY")
                case 6: return loc("PauseMenu:Retry2", "RETRY")
                case 2: return loc("PauseMenu:Settings", "SETTINGS")
                case 3: return loc("PauseMenu:Continue", "CONTINUE")
				case 4: return loc("PauseMenu:Back", "BACK")
				case 5: return loc("PauseMenu:Quit", "QUIT")
				case 7: return loc("PauseMenu:Bok", "BOK!")
            }
            break

        case sprOptionsButtons:
            switch _image_index {
                case 0: return loc("Options:AudioOptions", "AUDIO")
                case 1: return loc("Options:VideoOptions", "VIDEO")
                case 2: return loc("Options:GameOptions", "GAME")
                case 3: return loc("Options:ControlsOptions", "CONTROLS")
            }
            break

        case sprCoopButton:
            switch _image_index {
                case 0: return loc("R:CoopLobby:Host", "HOST")
                case 1: return loc("R:CoopLobby:Join", "JOIN")
            }
            break
		
		case sprBossName:
            var _boss_name = "???"
			switch _image_index {
				        case 0:  _boss_name = loc("Bosses:BigBandit", "BIG#BANDIT") break
				        case 1:  _boss_name = loc("Bosses:BigDog", "BIG#DOG") break
				        case 2:  _boss_name = loc("Bosses:LilHunter", "LIL#HUNTER") break
				        case 3:  _boss_name = loc("Bosses:Throne1", "THRONE") break
				        case 4:  _boss_name = loc("Bosses:Throne2", "THRONE#II") break
				        case 5:  _boss_name = loc("Bosses:BallMom", "MOM") break
				case 6: case 9:  _boss_name = loc("Bosses:HyperCrystal", "HYPER#CRYSTAL") break
				        case 7:  _boss_name = loc("Bosses:TechnoMancer", "TECHNO#MANCER") break
				        case 8:  _boss_name = loc("Bosses:Captain", "CAPTAIN") break
				        case 10: _boss_name = loc("Bosses:GunGod", "HYPER#CRYSTAL") break
			}
			return string_replace(_boss_name, "#", "# ")
		
		case sprGameOverResult: return loc("R:GameOver:Results", "RESULTS")
		
		case sprLevelUpText: return loc("LevCont:LevelUp", "LEVEL UP")
		
		case sprLevelUltraText: return loc("LevCont:LevelUltra", "LEVEL ULTRA")
		
		case sprPickCrownText: return loc("LevCont:SelectCrown:1", "PICK A CROWN")
    }

    return undefined
}