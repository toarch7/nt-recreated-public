/// @function scrPlayerGiveAmmo
/// @param {Id.Instance} player
/// @param ammo_type
/// @param give_amount
/// @param create_popup=false
/// @description `amount` supports negative values
function scrPlayerGiveAmmo(_player, _ammo_type, _amount, _create_popup = false) {
	if _ammo_type <= Ammo.None || _amount == 0 exit
	
	with _player {
		var _is_full = false
		
		if (_amount > 0 && ammo[_ammo_type] < typ_amax[_ammo_type]) || (_amount < 0 && ammo[_ammo_type] > 0) {
			ammo[_ammo_type] += _amount
			
			if ammo[_ammo_type] >= typ_amax[_ammo_type] {
				ammo[_ammo_type] = typ_amax[_ammo_type]
				_is_full = true
			}
		}
		else _is_full = true
		
		if _create_popup {
			var _type_name = loc(typ_name[_ammo_type])
			
			if _is_full && _amount > 0 {
				scrPopupCreate(x, y, loc_sfmt("MAX %", _type_name))
			}
			else {
				scrPopupCreate(x, y, $"{scrAmountChangeString(_amount)} {_type_name}")
			}
		}
	}
}