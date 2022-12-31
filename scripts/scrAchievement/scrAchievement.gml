function scrAchievement(argument0) {
    if !UberCont.chiev_have[argument0] {
        if UberCont.opt_achievs {
            with instance_create(instance_number(AchievementSplash), 0, AchievementSplash) {
                str1 = UberCont.chiev_name[argument0]
                str2 = UberCont.chiev_text[argument0]
                ok = instance_number(AchievementSplash) <= 1
                achiev = argument0
            }
        }

        UberCont.chiev_have[argument0] = 1
        save_set_val("achievement", string(argument0), 1)
    }
}