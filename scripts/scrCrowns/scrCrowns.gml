function scrCrowns() {
    crown_name[0] = "RANDOM"
    crown_text[0] = "???"
    crown_have[0] = 1
    crown_tips[0] = ""
    crown_sond[0] = sndCrownRandom

    crown_name[1] = "NO CROWN"
    crown_text[1] = "A BARE HEAD#IS A FAIR HEAD"
    crown_have[1] = 1
    crown_tips[1] = ""
    crown_sond[1] = sndCrownNone

    crown_name[2] = "CROWN OF DEATH"
    crown_text[2] = "BIGGER @wEXPLOSIONS#@s-1 @rMAX HP@s"
    crown_have[2] = 1
    crown_tips[2] = choose("boom", "health is important")
    crown_sond[2] = sndCrownDeath

    crown_name[3] = "CROWN OF LIFE"
    crown_text[3] = "NO @rHP DROPS@s#@rBIG HP CHESTS@s MORE COMMON"
    crown_have[3] = 1
    crown_tips[3] = "heart matters"
    crown_sond[3] = sndCrownLife

    crown_name[4] = "CROWN OF HASTE"
    crown_text[4] = "@wPICKUPS@s FADE FAST#ARE WORTH MORE"
    crown_have[4] = 1
    crown_tips[4] = "no time for jokes"
    crown_sond[4] = sndCrownHaste

    crown_name[5] = "CROWN OF GUNS"
    crown_text[5] = "NO AMMO DROPS#MORE WEAPON DROPS"
    crown_have[5] = 1
    crown_tips[5] = "guns are your friend"
    crown_sond[5] = sndCrownGuns

    crown_name[6] = "CROWN OF HATRED"
    crown_text[6] = "TAKE @wDAMAGE@s AND GAIN @gRADS@s#WHEN OPENING @wCHESTS@s"
    crown_have[6] = 1
    crown_tips[6] = "something is wrong"
    crown_sond[6] = sndCrownHatred

    crown_name[7] = "CROWN OF BLOOD"
    crown_text[7] = "MORE @wENEMIES@s#FEWER @gRADS@s"
    crown_have[7] = 1
    crown_tips[7] = choose("get ready", "bring it")
    crown_sond[7] = sndCrownBlood

    crown_name[8] = "CROWN OF DESTINY"
    crown_text[8] = "FREE @gMUTATION@s#NARROW FUTURE"
    crown_have[8] = 1
    crown_tips[8] = "no such thing as free will"
    crown_sond[8] = sndCrownDestiny

    crown_name[9] = "CROWN OF LOVE"
    crown_text[9] = "@yAMMO@s CHESTS ONLY"
    crown_have[9] = 1
    crown_tips[9] = "you really like these @wweapons@s"
    crown_sond[9] = sndCrownLove

    crown_name[10] = "CROWN OF LUCK"
    crown_text[10] = "START @wAREAS@s AT 1 @rHP@s#CHANCE @wENEMIES@s HAVE 1 @rHP@s"
    crown_have[10] = 1
    crown_tips[10] = choose("the future brings death", "it's all the same")
    crown_sond[10] = sndCrownLuck

    crown_name[11] = "CROWN OF CURSES"
    crown_text[11] = "A LOT MORE @pCURSED CHESTS@s"
    crown_have[11] = 1
    crown_tips[11] = "why"
    crown_sond[11] = sndCrownCurse

    crown_name[12] = "CROWN OF RISK"
    crown_text[12] = "MORE @wDROPS@s WHEN AT FULL @rHP@s#LESS @wDROPS@s WHEN NOT"
    crown_have[12] = 1
    crown_tips[12] = "good"
    crown_sond[12] = sndCrownRisk

    crown_name[13] = "CROWN OF PROTECTINON"
    crown_text[13] = "@wWEAPONS@s CONTAIN @rHP@s#INSTEAD OF @yAMMO@s"
    crown_have[13] = 1
    crown_tips[13] = "safety first"
    crown_sond[13] = sndCrownProtection

    crownmax = 13
}