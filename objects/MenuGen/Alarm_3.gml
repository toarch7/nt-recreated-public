with Floor {
    if random(12) < 1 {
        if irandom(21) && distance_to_object(NightCactus) >= 16 {
            instance_create(x + 16, y + 16, NightCactus)
        } else instance_create(x + 16, y + 16, TopDecalNightDesert)
    }
}

scrMoveTopPots()