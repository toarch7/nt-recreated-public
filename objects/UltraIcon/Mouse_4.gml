if selected {
    event_user(0)
} else {
    LevCont.splat = 1

    with UltraIcon {
        selected = (id == other.id)
    }
}