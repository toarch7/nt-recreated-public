if (other.typ != 0 && team != other.team) {
	instance_destroy(other.id)
	instance_destroy(id)
}