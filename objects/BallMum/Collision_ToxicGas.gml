if hp < max_hp {
    with other {
        instance_destroy()
    }

    hp++
}