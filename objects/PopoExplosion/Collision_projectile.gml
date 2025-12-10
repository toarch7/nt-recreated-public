if lockstep_stop
	exit

// todo: make sure this is actually how it works
if object_is_ancestor(other.object_index, Grenade) exit

if team != other.team && other.typ != 0 {
    with (other) instance_destroy()
}