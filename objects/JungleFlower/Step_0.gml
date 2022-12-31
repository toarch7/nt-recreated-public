if feed >= 4 {
    GameCont.area = 105
    GameCont.subarea = 0

    with enemy {
        hp = 0
    }

    with instance_create(x, y, Portal) type = 1

    with Player {
        if skill_get(18) {
            skill_set(18, 0)
            GameCont.skillpoints++ds_list_delete(GameCont.skills, ds_list_find_index(GameCont.skills, 18))
        }
    }

    instance_destroy()
}

depth = 0