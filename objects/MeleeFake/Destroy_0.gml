var _object = self.__get_spawn_enemy_object()

event_perform_object(_object, ev_create, 0)

// normally this would be 8, but in base Nuclear Throne
// where MeleeFake drops x2 the amount of rads due to an oversight
raddrop = 16

event_perform_object(_object, ev_destroy, 0)