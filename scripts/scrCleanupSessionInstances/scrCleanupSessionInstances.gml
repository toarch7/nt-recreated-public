/// @function scrCleanupSessionInstances
/// @param is_credits=false
/// @description passing `is_credits` destroys fewer instances, keeping the key run logic controllers
function scrCleanupSessionInstances(_is_credits = false) {
	if (_is_credits) {
		with (all) {
		    if (object_index == UberCont || object_index == GameCont || object_index == TopCont
				|| object_index == BackCont || object_index == Player || object_index == MusCont
				|| object_index == Console || object_index == input_controller_object
			) {
		        continue
		    }
			instance_destroy(id, false)
		}
	}
	else {
		with (all) {
		    if (object_index == UberCont || object_index == CoopController
				|| object_index == Console || object_index == input_controller_object
			) {
				continue
			}
			
			instance_destroy(id, false)
		}
	}
}