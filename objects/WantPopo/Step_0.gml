if ((instance_number(enemy) < (enemies * spawnmoment)) || (instance_number(enemy) == 0)) {
    repeat 2 {
        instance_create(x, y, IDPDSpawn)
    }

    instance_destroy()
}