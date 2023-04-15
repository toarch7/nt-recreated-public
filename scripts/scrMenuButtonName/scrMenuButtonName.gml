function scrMenuButtonName(spr = sprite_index, img = image_index) {
    switch spr {
        case sprMenuButton:
            switch img {
                case 0:
                    return "PLAY"
                case 1:
                    return "CO-OP"
                case 2:
                    return "SETTINGS"
                case 3:
                    return "STATS"
                case 4:
                    return "QUIT"
                case 5:
                    return "ACHIEVS"
            }
            break

        case sprPlayButtons:
            switch img {
                case 0:
                    return "NORMAL"
                case 1:
                    return "DAILY"
                case 2:
                    return "WEEKLY"
                case 3:
                    return "HARD"
            }
            break

        case sprBigNames:
        case sprBigNameCentered:
        case sprBigNameCenteredB:
            switch img {
                case 0:
                    return "RANDOM"
                case 1:
                    return "FISH"
                case 2:
                    return "CRYSTALL"
                case 3:
                    return "EYES"
                case 4:
                    return "MELTING"
                case 5:
                    return "PLANT"
                case 6:
                    return "Y.V."
                case 7:
                    return "STEROIDS"
                case 8:
                    return "ROBOT"
                case 9:
                    return "CHICKEN"
                case 10:
                    return "REBEL"
                case 11:
                    return "HORROR"
                case 12:
                    return "ROGUE"
                case 13:
                    return "BIG DOG"
                case 14:
                    return "SKELETON"
                case 15:
                    return "FROG"
                case 16:
                    return "CUZ"
            }
            break

        case sprPauseButtons:
            switch img {
                case 0:
                    return "MENU"
                case 1:
                    return "RETRY"
                case 6:
                    return "RETRY"
                case 2:
                    return "SETTINGS"
                case 3:
                    return "CONTINUE"
				case 4:
					return "BACK"
				case 5:
					return "QUIT"
				case 7:
					return "BOK!"
            }
            break

        case sprOptionButtons:
            switch img {
                case 0:
                    return "AUDIO"
                case 1:
                    return "VIDEO"
                case 2:
                    return "GAME"
                case 3:
                    return "CONTROLS"
            }
            break

        case sprCoopButton:
            switch img {
                case 0:
                    return "HOST"
                case 1:
                    return "JOIN"
            }
            break
		
		case sprBossName:
			switch img {
				case 0:
					return "BIG# BANDIT"
				case 1:
					return "BIG# DOG"
				case 2:
					return "LIL# HUNTER"
				case 3:
					return "THRONE"
				case 4:
					return "THRONE# II"
				case 5:
					return "MOM"
				case 6:
				case 9:
					return "HYPER# CRYSTAL"
				case 7:
					return "TECHNOMANCER"
				case 8:
					return "CAPTAIN"
			}
			
			break
		
		case sprGameOverResults:
			return "RESULTS"
    }

    return ""
}