function scrMenuButtonName(_sprite_index = sprite_index, _image_index = image_index) {
	static _L = function(_key, _default) {
		for(var i = 1; i < argument_count - 1; ++i) {
			_key += ":" + string(argument[i])
		}
		
		if (loc_exists(_key)) {
			var _string = loc(_key, _default)
			
			if (_string != _default) {
				return _string
			}
		}
		
		return undefined
	}
	
    switch _sprite_index {
        case sprMainMenuButtons:
            switch _image_index {
                case 0: return _L("MainMenu:Play", "PLAY")
                case 1: return _L("MainMenu:Coop", "CO-OP")
                case 2: return _L("MainMenu:Settings", "SETTINGS")
                case 3: return _L("MainMenu:Stats", "STATS")
                case 4: return _L("MainMenu:Quit", "QUIT")
            }
            break

        case sprPlayButtons:
            switch _image_index {
                case 0: return _L("PlayMenu:Normal", "NORMAL")
                case 1: return _L("PlayMenu:Daily", "DAILY")
                case 2: return _L("PlayMenu:Weekly", "WEEKLY")
                case 3: return _L("PlayMenu:Hardmode", "HARD")
                case 4: return loc("PlayMenu:Custom", "CUSTOM")
            }
            break

        case sprBigName:
        case sprBigNameCentered:
        case sprBigNameCenteredB:
			return _L("Races", _image_index, "Name", scrRaceGetName(_image_index))
            break

        case sprPauseButton:
            switch _image_index {
                case 0: return _L("PauseMenu:BackToMenu", "MENU")
                case 1: return _L("PauseMenu:Retry", "RETRY")
                case 6: return _L("PauseMenu:Retry2", "RETRY")
                case 2: return _L("PauseMenu:Settings", "SETTINGS")
                case 3: return _L("PauseMenu:Continue", "CONTINUE")
				case 4: return _L("PauseMenu:Back", "BACK")
				case 5: return _L("PauseMenu:Quit", "QUIT")
				case 7: return _L("PauseMenu:Bok", "BOK!")
            }
            break

        case sprOptionsButtons:
            switch _image_index {
                case 0: return _L("Options:AudioOptions", "AUDIO")
                case 1: return _L("Options:VideoOptions", "VIDEO")
                case 2: return _L("Options:GameOptions", "GAME")
                case 3: return _L("Options:ControlOptions", "CONTROLS")
            }
            break

        case sprCoopButton:
            switch _image_index {
                case 0: return _L("R:CoopLobby:Host", "HOST")
                case 1: return _L("R:CoopLobby:Join", "JOIN")
            }
            break
		
		case sprBossName:
            var _boss_name = "???"
			switch _image_index {
				        case 0:  _boss_name = _L("Bosses:BigBandit", "BIG#BANDIT") break
				        case 1:  _boss_name = _L("Bosses:BigDog", "BIG#DOG") break
				        case 2:  _boss_name = _L("Bosses:LilHunter", "LIL#HUNTER") break
				        case 3:  _boss_name = _L("Bosses:Throne1", "THRONE") break
				        case 4:  _boss_name = _L("Bosses:Throne2", "THRONE#II") break
				        case 5:  _boss_name = _L("Bosses:BallMom", "MOM") break
				case 6: case 9:  _boss_name = _L("Bosses:HyperCrystal", "HYPER#CRYSTAL") break
				        case 7:  _boss_name = _L("Bosses:TechnoMancer", "TECHNO#MANCER") break
				        case 8:  _boss_name = _L("Bosses:Captain", "CAPTAIN") break
				        case 10: _boss_name = _L("Bosses:GunGod", "GUN#GOD") break
			}
			return is_string(_boss_name) ? string_replace(_boss_name, "#", "# ") : undefined
		
		case sprGameOverResult: return _L("R:GameOver:Results", "RESULTS")
		
		case sprLevelUpText: return _L("LevCont:LevelUp", "LEVEL UP")
		
		case sprLevelUltraText: return _L("LevCont:LevelUltra", "LEVEL ULTRA")
		
		case sprPickCrownText: return _L("LevCont:SelectCrown:1", "PICK A CROWN")
    }

    return undefined
}