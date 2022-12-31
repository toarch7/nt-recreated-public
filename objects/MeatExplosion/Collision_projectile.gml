if team != other.team and(other.typ = 1 or other.typ = 2) {
    with other
    instance_destroy()
}