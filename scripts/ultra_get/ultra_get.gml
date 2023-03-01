/// @description ultra_get(ultra)
/// @param ultra
function ultra_get(_ultra, _race = -1) {
    with Player {
		if ultra == _ultra && (race == _race or _race == -1)  {
			return 1
		}
	}
	
    return 0
}