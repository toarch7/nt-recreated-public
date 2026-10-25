event_inherited()

list = array_filter(asset_get_ids(asset_object),
	function(_object) {
		return (object_is_ancestor(_object, enemy) || object_is_ancestor(_object, prop))
			&& _object != crystaltype && _object != Nothing && _object != Nothing2 && _object != bossenemy
	})

setup = true

duration = 0

projectile_hitids = {}

name = "N/A"

result = {}