function scrDecideSkill() {
    var iter = 0
    var skill = -1
	
    do {
        var fine = 1

        skill = irandom(GameCont.maxskill)
        iter++
		
        with SkillIcon {
            if self.skill == skill {
                fine = 0
            }
        }

        var horrorexists = 0
		
        with Player {
			if race == 11 {
				horrorexists = 1
				break
			}
		}
		
        if !skill or skill_get(skill) or (skill == 18 && GameCont.crown == 8 && !horrorexists) {
            fine = 0
        }
    }
	until fine && iter < 100

    return skill
}