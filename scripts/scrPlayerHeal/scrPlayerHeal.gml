/// @function scrPlayerHeal
/// @param player
/// @param amount
/// @param create_popup=false
function scrPlayerHeal(_player, _amount, _create_popup=false) {
	if _amount == 0 exit
	_amount = round(_amount)
	
	with _player {
		var _is_full = false
		
		if _amount > 0 {
			if hp < max_hp {
				hp += _amount
				if hp >= max_hp {
					_is_full = true
				}
			}
			else _is_full = true
		}
		else projectile_hit_self(-_amount)
		
		if _create_popup {
			if _is_full && _amount > 0 {
				scrPopupCreate(x, y, loc("MAX HP"))
			}
			else scrPopupCreate(x, y, scrAmountChangeString(_amount) + " " + loc("HP"))
		}
	}
}