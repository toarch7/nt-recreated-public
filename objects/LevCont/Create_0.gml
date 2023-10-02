random_set_seed(global.seed)

for (var i = 0; i <= 15; i++) {
    mutseed[i] = irandom(999999)
}

random_set_seed(mutseed[(GameCont.level - GameCont.skillpoints)] + GameCont.wasskeleton * 10203 + ((GameCont.crown == 8) * 1000))

camera_set_pos(0, 0)

wave = 0

placeonpatience = 0

if GameCont.patiencepick {
    random_set_seed(global.seed + 200500)
    GameCont.patiencepick = 0
    placeonpatience = 1
}

if GameCont.area == 105 && GameCont.skillpoints == 1 {
    for (i = 0; i <= 12; i++) {
        global.rng_state[i] = global.seed + 15000
    }

    random_set_seed(global.seed + 15000)
}

if GameCont.crownpoints > 0 {
    scrCrowns()

    var dir0, dir1, dir2, dir3, dir4, dir5, dir6;

    dir0 = instance_create(view_xview + view_width / 2 - 112, view_yview + view_height - 20, CrownIcon)
    dir0.crown = 1
    dir1 = instance_create(view_xview + view_width / 2 - 80, view_yview + view_height - 20, CrownIcon)
    dir2 = instance_create(view_xview + view_width / 2 - 48, view_yview + view_height - 20, CrownIcon)
    dir3 = instance_create(view_xview + view_width / 2 - 16, view_yview + view_height - 20, CrownIcon)
    dir4 = instance_create(view_xview + view_width / 2 + 16, view_yview + view_height - 20, CrownIcon)
    dir5 = instance_create(view_xview + view_width / 2 + 48, view_yview + view_height - 20, CrownIcon)
    dir6 = instance_create(view_xview + view_width / 2 + 80, view_yview + view_height - 20, CrownIcon)

    with CrownIcon {
        x += 16
    }

    if !GameCont.loops {
        dir1.crown = 3
        dir2.crown = 5
        dir3.crown = 4
        dir4.crown = 8
        dir5.crown = 11
        dir6.crown = 12
    }
	else {
        dir1.crown = 2
        dir2.crown = 6
        dir3.crown = 7
        dir4.crown = 9
        dir5.crown = 10
        dir6.crown = 13
    }

    dir0.num = 0
    dir1.num = 1
    dir2.num = 2
    dir3.num = 3
    dir4.num = 4
    dir5.num = 5
    dir6.num = 6

    with CrownIcon
    creator = other.id
}
else if GameCont.skillpoints {
    scrSkills()

    var maxskills = 4

    if GameCont.crown == 8 {
        maxskills = 1
    }

    with Player {
        if race == 11 {
            maxskills ++
        }
    }

    var _num = 0

    repeat maxskills {
        with instance_create(0, 0, SkillIcon) {
            skill = scrDecideSkill()
            num = ++_num

            if !skill {
                instance_destroy()
            }
        }
    }

    if !skill_get(29) && !GameCont.wantheavy && GameCont.heavyheart >= 3 {
        if instance_exists(SkillIcon) {
            with instance_find(SkillIcon, 0) {
                skill = 29
            }
        }

        GameCont.wantheavy = 1
    }

    with SkillIcon {
        x = view_xview + view_width / 2 - (_num * 16) + num * 32 - 16
        y = view_yview + view_height - 20
    }
}
else if GameCont.ultrapoints {
    scrUltras()

    with instance_create(view_xview + view_width / 2 - 20, view_yview + view_height - 20, UltraIcon)
    num = 1

    with instance_create(view_xview + view_width / 2 + 20, view_yview + view_height - 20, UltraIcon)
    num = 2

    if GameCont.crown == 8 {
        with instance_find(UltraIcon, irandom(1)) {
            instance_destroy()
        }

        with UltraIcon {
            x = view_width / 2
        }
    }

    if !instance_exists(CoopController) {
        if instance_exists_var(Player, "race", 11) {
            with UltraIcon {
				x -= 20
			}
			
			with instance_create(view_xview + view_width / 2 + 40, view_yview + view_height - 20, UltraIcon) {
                num = 3

                if GameCont.crown == 8 {
                    x -= 20
                }
            }
        }
    } else {
        with UltraIcon {
            sprite_index = sprUltraIconCoop
            race = 0
        }
    }
}

if UberCont.daily_run && UberCont.april_fools {
    with SkillIcon {
        skill = 28
    }

    if instance_exists(UltraIcon) {
        GameCont.skillpoints++
		GameCont.ultrapoints = 0
    }

    with UltraIcon {
        with instance_create(x, y, SkillIcon) {
            skill = 28
            num = other.num
        }

        instance_destroy()
    }

    with CrownIcon {
        with instance_create(x, y, SkillIcon) {
            skill = 28
            num = other.num
        }

        instance_destroy()
    }
}

splat = 0

appear = view_height / 2

if instance_exists(SkillText) appear = 0

with SkillText
	y -= 40








if UberCont.opt_griller && instance_exists(SkillIcon) {
	with SkillIcon
		instance_destroy()
	
	var dx = view_xview + view_width / 2,
		dy = view_yview + view_height - 20
	
	var xx = dx,
		yy = dy,
		_num = 0
	
	for(var i = 1; i <= maxskill; i ++) {
		if skill_get(i)
			continue
		
		if xx >= view_width - 32 {
			xx = dx
			
			with SkillIcon
				y -= 32
		}
		
		with SkillIcon
			if y == yy x -= 12
		
		with instance_create(xx, yy, SkillIcon) {
			num = (_num ++)
			skill = i
		}
		
		xx += 12
	}
}


