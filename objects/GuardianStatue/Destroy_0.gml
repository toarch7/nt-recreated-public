if hp < max_hp {


    with GuardianStatue {
        if id != other.id instance_destroy()
    }

}

instance_create(x, y, CrownGuardian)

with CrownPickup
instance_destroy()