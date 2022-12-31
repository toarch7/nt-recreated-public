function scrWeapons() {
    //WEAPONS
    wep_name[0] = ""
    wep_type[0] = 0
    wep_auto[0] = 0
    wep_load[0] = 1
    wep_cost[0] = 1
    wep_sprt[0] = mskNone
    wep_area[0] = -1
    wep_text[0] = ""

    wep_name[1] = "REVOLVER"
    wep_type[1] = 1
    wep_cost[1] = 1
    wep_sprt[1] = sprRevolver
    wep_area[1] = -1
    wep_auto[1] = false
    wep_load[1] = 6
    wep_text[1] = "trusty old @wrevolver@s"

    wep_name[2] = "TRIPLE MACHINEGUN"
    wep_type[2] = 1
    wep_cost[2] = 3
    wep_sprt[2] = sprTripleMachinegun
    wep_area[2] = 4
    wep_auto[2] = true
    wep_load[2] = 4
    wep_text[2] = "@wtriple machinegun@s, so much fun"

    wep_name[3] = "WRENCH"
    wep_type[3] = 0
    wep_cost[3] = 0
    wep_sprt[3] = sprWrench
    wep_area[3] = 1
    wep_auto[3] = false
    wep_load[3] = 22
    wep_text[3] = "hell"

    wep_name[4] = "MACHINEGUN"
    wep_type[4] = 1
    wep_cost[4] = 1
    wep_sprt[4] = sprMachinegun
    wep_area[4] = 0
    wep_auto[4] = true
    wep_load[4] = 5
    wep_text[4] = ""

    wep_name[5] = "SHOTGUN"
    wep_type[5] = 2
    wep_cost[5] = 1
    wep_sprt[5] = sprShotgun
    wep_area[5] = 0
    wep_auto[5] = false
    wep_load[5] = 17
    wep_text[5] = ""

    wep_name[6] = "CROSSBOW"
    wep_type[6] = 3
    wep_cost[6] = 1
    wep_sprt[6] = sprCrossbow
    wep_area[6] = 1
    wep_auto[6] = false
    wep_load[6] = 26
    wep_text[6] = ""

    wep_name[7] = "GRENADE LAUNCHER"
    wep_type[7] = 4
    wep_cost[7] = 1
    wep_sprt[7] = sprNader
    wep_area[7] = 1
    wep_auto[7] = false
    wep_load[7] = 20
    wep_text[7] = "be careful with those @wgrenades@s"

    wep_name[8] = "DOUBLE SHOTGUN"
    wep_type[8] = 2
    wep_cost[8] = 2
    wep_sprt[8] = sprSuperShotgun
    wep_area[8] = 5
    wep_auto[8] = false
    wep_load[8] = 28
    wep_text[8] = "@wdouble shotgun@s, double fun"

    wep_name[9] = "MINIGUN"
    wep_type[9] = 1
    wep_cost[9] = 1
    wep_sprt[9] = sprMinigun
    wep_area[9] = 6
    wep_auto[9] = true
    wep_load[9] = 1
    wep_text[9] = "time to rain @ybullets@s"

    wep_name[10] = "AUTO SHOTGUN"
    wep_type[10] = 2
    wep_cost[10] = 1
    wep_sprt[10] = sprAutoShotgun
    wep_area[10] = 6
    wep_auto[10] = true
    wep_load[10] = 4
    wep_text[10] = "just hold down the trigger"

    wep_name[11] = "AUTO CROSSBOW"
    wep_type[11] = 3
    wep_cost[11] = 1
    wep_sprt[11] = sprAutoCrossbow
    wep_area[11] = 7
    wep_auto[11] = true
    wep_load[11] = 8
    wep_text[11] = "225 @ybolts@s per minute"

    wep_name[12] = "SUPER CROSSBOW"
    wep_type[12] = 3
    wep_cost[12] = 5
    wep_sprt[12] = sprSuperCrossbow
    wep_area[12] = 8
    wep_auto[12] = false
    wep_load[12] = 30
    wep_text[12] = "5 @ybolts@s per shot"

    wep_name[13] = "SHOVEL"
    wep_type[13] = 0
    wep_cost[13] = 0
    wep_sprt[13] = sprShovel
    wep_area[13] = 4
    wep_auto[13] = false
    wep_load[13] = 35
    wep_text[13] = "dig"

    wep_name[14] = "BAZOOKA"
    wep_type[14] = 4
    wep_cost[14] = 1
    wep_sprt[14] = sprBazooka
    wep_area[14] = 5
    wep_auto[14] = false
    wep_load[14] = 30
    wep_text[14] = ""

    wep_name[15] = "STICKY LAUNCHER"
    wep_type[15] = 4
    wep_cost[15] = 1
    wep_sprt[15] = sprStickyNader
    wep_area[15] = 7
    wep_auto[15] = false
    wep_load[15] = 25
    wep_text[15] = "dont touch @wsticky nades@s"

    wep_name[16] = "SMG"
    wep_type[16] = 1
    wep_cost[16] = 1
    wep_sprt[16] = sprSmg
    wep_area[16] = 3
    wep_auto[16] = true
    wep_load[16] = 3
    wep_text[16] = ""

    wep_name[17] = "ASSAULT RIFLE"
    wep_type[17] = 1
    wep_cost[17] = 3
    wep_sprt[17] = sprARifle
    wep_area[17] = 2
    wep_auto[17] = false
    wep_load[17] = 11
    wep_text[17] = ""

    wep_name[18] = "DISC GUN"
    wep_type[18] = 3
    wep_cost[18] = 1
    wep_sprt[18] = sprDiscGun
    wep_area[18] = 3
    wep_auto[18] = true
    wep_load[18] = 8
    wep_text[18] = "we hereby sincerely apologize"

    wep_name[19] = "LASER PISTOL"
    wep_type[19] = 5
    wep_cost[19] = 1
    wep_sprt[19] = sprLaserGun
    wep_area[19] = 2
    wep_auto[19] = false
    wep_load[19] = 9
    wep_text[19] = "futuristic weaponry"

    wep_name[20] = "LASER RIFLE"
    wep_type[20] = 5
    wep_cost[20] = 1
    wep_sprt[20] = sprLaserRifle
    wep_area[20] = 5
    wep_auto[20] = true
    wep_load[20] = 7
    wep_text[20] = ""

    wep_name[21] = "SLUGGER"
    wep_type[21] = 2
    wep_cost[21] = 1
    wep_sprt[21] = sprSlugger
    wep_area[21] = 2
    wep_auto[21] = false
    wep_load[21] = 22
    wep_text[21] = ""

    wep_name[22] = "GATLING SLUGGER"
    wep_type[22] = 2
    wep_cost[22] = 1
    wep_sprt[22] = sprGatlingSlugger
    wep_area[22] = 9
    wep_auto[22] = true
    wep_load[22] = 7
    wep_text[22] = "time to gatle"

    wep_name[23] = "ASSAULT SLUGGER"
    wep_type[23] = 2
    wep_cost[23] = 3
    wep_sprt[23] = sprAssaultSlugger
    wep_area[23] = 5
    wep_auto[23] = false
    wep_load[23] = 35
    wep_text[23] = ""

    wep_name[24] = "ENERGY SWORD"
    wep_type[24] = 5
    wep_cost[24] = 2
    wep_sprt[24] = sprEnergySword
    wep_area[24] = 10
    wep_auto[24] = false
    wep_load[24] = 12
    wep_text[24] = "zzzwwoonggg"

    wep_name[25] = "SUPER SLUGGER"
    wep_type[25] = 2
    wep_cost[25] = 5
    wep_sprt[25] = sprSuperSlugger
    wep_area[25] = 10
    wep_auto[25] = false
    wep_load[25] = 32
    wep_text[25] = "no need to aim"

    wep_name[26] = "HYPER RIFLE"
    wep_type[26] = 1
    wep_cost[26] = 5
    wep_sprt[26] = sprHyperRifle
    wep_area[26] = 8
    wep_auto[26] = false
    wep_load[26] = 3
    wep_text[26] = "@bhyper@s time"

    wep_name[27] = "SCREWDRIVER"
    wep_type[27] = 0
    wep_cost[27] = 0
    wep_sprt[27] = sprScrewDriver
    wep_area[27] = 2
    wep_auto[27] = false
    wep_load[27] = 11
    wep_text[27] = "@wscrewdriver@s will fix it"

    wep_name[28] = "LASER MINIGUN"
    wep_type[28] = 5
    wep_cost[28] = 1
    wep_sprt[28] = sprLaserMinigun
    wep_area[28] = 9
    wep_auto[28] = true
    wep_load[28] = 2
    wep_text[28] = "energy bill off the charts"

    wep_name[29] = "BLOOD LAUNCHER"
    wep_type[29] = 4
    wep_cost[29] = 1
    wep_sprt[29] = sprBloodNader
    wep_area[29] = 10
    wep_auto[29] = true
    wep_load[29] = 12
    wep_text[29] = "built with spare parts"

    wep_name[30] = "SPLINTER GUN"
    wep_type[30] = 3
    wep_cost[30] = 1
    wep_sprt[30] = sprSplinterGun
    wep_area[30] = 5
    wep_auto[30] = false
    wep_load[30] = 19
    wep_text[30] = "this will hurt"

    wep_name[31] = "TOXIC BOW"
    wep_type[31] = 3
    wep_cost[31] = 1
    wep_sprt[31] = sprToxicBow
    wep_area[31] = 5
    wep_auto[31] = false
    wep_load[31] = 29
    wep_text[31] = "hold breath while firing"

    wep_name[32] = "SENTRY GUN"
    wep_type[32] = 1
    wep_cost[32] = 24
    wep_sprt[32] = sprSentryGun
    wep_area[32] = -1
    wep_auto[32] = true
    wep_load[32] = 60
    wep_text[32] = ""

    wep_name[33] = "WAVE GUN"
    wep_type[33] = 2
    wep_cost[33] = 2
    wep_sprt[33] = sprWaveGun
    wep_area[33] = 10
    wep_auto[33] = false
    wep_load[33] = 17
    wep_text[33] = "shoot em up"

    wep_name[34] = "PLASMA GUN"
    wep_type[34] = 5
    wep_cost[34] = 2
    wep_sprt[34] = sprPlasmaGun
    wep_area[34] = 5
    wep_auto[34] = true
    wep_load[34] = 16
    wep_text[34] = "fun fun"

    wep_name[35] = "PLASMA CANNON"
    wep_type[35] = 5
    wep_cost[35] = 8
    wep_sprt[35] = sprPlasmaCannon
    wep_area[35] = 11
    wep_auto[35] = false
    wep_load[35] = 40
    wep_text[35] = "fun fun fun fun"

    wep_name[36] = "ENERGY HAMMER"
    wep_type[36] = 5
    wep_cost[36] = 5
    wep_sprt[36] = sprEnergyHammer
    wep_area[36] = 10
    wep_auto[36] = false
    wep_load[36] = 20
    wep_text[36] = "break a leg"

    wep_name[37] = "JACKHAMMER"
    wep_type[37] = 4
    wep_cost[37] = 1
    wep_sprt[37] = sprJackHammer
    wep_area[37] = 5
    wep_auto[37] = true
    wep_load[37] = 12
    wep_text[37] = "break some legs"

    wep_name[38] = "FLAK CANNON"
    wep_type[38] = 2
    wep_cost[38] = 2
    wep_sprt[38] = sprFlakCannon
    wep_area[38] = 6
    wep_auto[38] = false
    wep_load[38] = 26
    wep_text[38] = "10/10"

    wep_name[39] = "GOLDEN REVOLVER"
    wep_type[39] = 1
    wep_cost[39] = 1
    wep_sprt[39] = sprGoldRevolver
    wep_area[39] = -1
    wep_auto[39] = false
    wep_load[39] = 5
    wep_text[39] = "@yB-)"

    wep_name[40] = "GOLDEN WRENCH"
    wep_type[40] = 0
    wep_cost[40] = 0
    wep_sprt[40] = sprGoldWrench
    wep_area[40] = 18
    wep_auto[40] = false
    wep_load[40] = 18
    wep_text[40] = "shiny @ywrench@s"

    wep_name[41] = "GOLDEN MACHINEGUN"
    wep_type[41] = 1
    wep_cost[41] = 1
    wep_sprt[41] = sprGoldMachinegun
    wep_area[41] = 18
    wep_auto[41] = true
    wep_load[41] = 5
    wep_text[41] = "expensive @ymachinegun@s"

    wep_name[42] = "GOLDEN SHOTGUN"
    wep_type[42] = 2
    wep_cost[42] = 1
    wep_sprt[42] = sprGoldShotgun
    wep_area[42] = 18
    wep_auto[42] = false
    wep_load[42] = 17
    wep_text[42] = "beautiful @yshotgun@s"

    wep_name[43] = "GOLDEN CROSSBOW"
    wep_type[43] = 3
    wep_cost[43] = 1
    wep_sprt[43] = sprGoldCrossbow
    wep_area[43] = 18
    wep_auto[43] = false
    wep_load[43] = 23
    wep_text[43] = "@yvelvet handles"

    wep_name[44] = "GOLDEN GRENADE LAUNCHER"
    wep_type[44] = 4
    wep_cost[44] = 1
    wep_sprt[44] = sprGoldNader
    wep_area[44] = 18
    wep_auto[44] = false
    wep_load[44] = 20
    wep_text[44] = "even the @wgrenades@s are @ygold@s"

    wep_name[45] = "GOLDEN LASER PISTOL"
    wep_type[45] = 5
    wep_cost[45] = 1
    wep_sprt[45] = sprGoldLaserGun
    wep_area[45] = 18
    wep_auto[45] = false
    wep_load[45] = 8
    wep_text[45] = "@ythis thing gets hot"

    wep_name[46] = "CHICKEN SWORD"
    wep_type[46] = 0
    wep_cost[46] = 0
    wep_sprt[46] = sprSword
    wep_area[46] = -1
    wep_auto[46] = false
    wep_load[46] = 18
    wep_text[46] = "chicken loves her @wsword@s"

    wep_name[47] = "NUKE LAUNCHER"
    wep_type[47] = 4
    wep_cost[47] = 3
    wep_sprt[47] = sprNukeLauncher
    wep_area[47] = 10
    wep_auto[47] = false
    wep_load[47] = 50
    wep_text[47] = "this is what started it all"

    wep_name[48] = "ION CANNON"
    wep_type[48] = 5
    wep_cost[48] = 6
    wep_sprt[48] = sprIonCannon
    wep_area[48] = -1
    wep_auto[48] = true
    wep_load[48] = 10
    wep_text[48] = "death from above"

    wep_name[49] = "QUADRUPLE MACHINEGUN"
    wep_type[49] = 1
    wep_cost[49] = 4
    wep_sprt[49] = sprQuadrupleMachinegun
    wep_area[49] = 12
    wep_auto[49] = true
    wep_load[49] = 4
    wep_text[49] = "the future is here"

    wep_name[50] = "FLAMETHROWER"
    wep_type[50] = 4
    wep_cost[50] = 1
    wep_sprt[50] = sprFlameThrower
    wep_area[50] = 5
    wep_auto[50] = true
    wep_load[50] = 12
    wep_text[50] = "burn burn burn"

    wep_name[51] = "DRAGON"
    wep_type[51] = 4
    wep_cost[51] = 1
    wep_sprt[51] = sprDragon
    wep_area[51] = 13
    wep_auto[51] = true
    wep_load[51] = 7
    wep_text[51] = "hot breath"

    wep_name[52] = "FLARE GUN"
    wep_type[52] = 4
    wep_cost[52] = 1
    wep_sprt[52] = sprFlareGun
    wep_area[52] = 6
    wep_auto[52] = false
    wep_load[52] = 25
    wep_text[52] = "signal for help"

    wep_name[53] = "ENERGY SCREWDRIVER"
    wep_type[53] = 5
    wep_cost[53] = 1
    wep_sprt[53] = sprEnergyScrewDriver
    wep_area[53] = 9
    wep_auto[53] = false
    wep_load[53] = 4
    wep_text[53] = "future fixing"

    wep_name[54] = "HYPER LAUNCHER"
    wep_type[54] = 4
    wep_cost[54] = 2
    wep_sprt[54] = sprHyperLauncher
    wep_area[54] = 14
    wep_auto[54] = false
    wep_load[54] = 7
    wep_text[54] = "point and click"

    wep_name[55] = "LASER CANNON"
    wep_type[55] = 5
    wep_cost[55] = 3
    wep_sprt[55] = sprLaserCannon
    wep_area[55] = 7
    wep_auto[55] = true
    wep_load[55] = 30
    wep_text[55] = "oh @wlaser cannon@s"

    wep_name[56] = "RUSTY REVOLVER"
    wep_type[56] = 1
    wep_cost[56] = 1
    wep_sprt[56] = sprRustyRevolver
    wep_area[56] = -1
    wep_auto[56] = false
    wep_load[56] = 7
    wep_text[56] = "rusty old @wrevolver@s"

    wep_name[57] = "LIGHTNING PISTOL"
    wep_type[57] = 5
    wep_cost[57] = 1
    wep_sprt[57] = sprLightningPistol
    wep_area[57] = 6
    wep_auto[57] = false
    wep_load[57] = 11
    wep_text[57] = "thunder"

    wep_name[58] = "LIGHTNING RIFLE"
    wep_type[58] = 5
    wep_cost[58] = 1
    wep_sprt[58] = sprLightningRifle
    wep_area[58] = 8
    wep_auto[58] = false
    wep_load[58] = 24
    wep_text[58] = "a storm is coming"

    wep_name[59] = "LIGHTNING SHOTGUN"
    wep_type[59] = 5
    wep_cost[59] = 2
    wep_sprt[59] = sprLightningShotgun
    wep_area[59] = 9
    wep_auto[59] = false
    wep_load[59] = 20
    wep_text[59] = "hurricane"

    wep_name[60] = "SUPER FLAK CANNON"
    wep_type[60] = 2
    wep_cost[60] = 8
    wep_sprt[60] = sprSuperFlakCannon
    wep_area[60] = 12
    wep_auto[60] = false
    wep_load[60] = 64
    wep_text[60] = "11/10"

    wep_name[61] = "SAWED-OFF SHOTGUN"
    wep_type[61] = 2
    wep_cost[61] = 2
    wep_sprt[61] = sprSawedOffShotgun
    wep_area[61] = 6
    wep_auto[61] = false
    wep_load[61] = 28
    wep_text[61] = "a true @wmelee weapon@s"

    wep_name[62] = "SPLINTER PISTOL"
    wep_type[62] = 3
    wep_cost[62] = 1
    wep_sprt[62] = sprSplinterPistol
    wep_area[62] = 6
    wep_auto[62] = false
    wep_load[62] = 8
    wep_text[62] = "watch your fingers"

    wep_name[63] = "SUPER SPLINTER GUN"
    wep_type[63] = 3
    wep_cost[63] = 2
    wep_sprt[63] = sprHeavySplinterGun
    wep_area[63] = 8
    wep_auto[63] = false
    wep_load[63] = 28
    wep_text[63] = "terror"

    wep_name[64] = "LIGHTNING SMG"
    wep_type[64] = 5
    wep_cost[64] = 1
    wep_sprt[64] = sprLightningSMG
    wep_area[64] = 13
    wep_auto[64] = true
    wep_load[64] = 7
    wep_text[64] = "heavy weather"

    wep_name[65] = "SMART GUN"
    wep_type[65] = 1
    wep_cost[65] = 1
    wep_sprt[65] = sprSmartGun
    wep_area[65] = 10
    wep_auto[65] = true
    wep_load[65] = 3
    wep_text[65] = "it thinks"

    wep_name[66] = "HEAVY CROSSBOW"
    wep_type[66] = 3
    wep_cost[66] = 2
    wep_sprt[66] = sprHeavyCrossbow
    wep_area[66] = 5
    wep_auto[66] = false
    wep_load[66] = 40
    wep_text[66] = "a true burden"

    wep_name[67] = "BLOOD HAMMER"
    wep_type[67] = 0
    wep_cost[67] = 0
    wep_sprt[67] = sprBloodHammer
    wep_area[67] = 10
    wep_auto[67] = false
    wep_load[67] = 21
    wep_text[67] = "drip"

    wep_name[68] = "LIGHTNING CANNON"
    wep_type[68] = 5
    wep_cost[68] = 8
    wep_sprt[68] = sprLightningCannon
    wep_area[68] = 13
    wep_auto[68] = false
    wep_load[68] = 34
    wep_text[68] = "typhoon"

    wep_name[69] = "POP GUN"
    wep_type[69] = 1
    wep_cost[69] = 1
    wep_sprt[69] = sprPopGun
    wep_area[69] = 3
    wep_auto[69] = true
    wep_load[69] = 2
    wep_text[69] = "how does this thing even work"

    wep_name[70] = "PLASMA RIFLE"
    wep_type[70] = 5
    wep_cost[70] = 2
    wep_sprt[70] = sprPlasmaRifle
    wep_area[70] = 8
    wep_auto[70] = true
    wep_load[70] = 10
    wep_text[70] = "fun fun fun"

    wep_name[71] = "POP RIFLE"
    wep_type[71] = 1
    wep_cost[71] = 2
    wep_sprt[71] = sprPopRifle
    wep_area[71] = 4
    wep_auto[71] = true
    wep_load[71] = 9
    wep_text[71] = "let's hope this works"

    wep_name[72] = "TOXIC LAUNCHER"
    wep_type[72] = 4
    wep_cost[72] = 1
    wep_sprt[72] = sprToxicLauncher
    wep_area[72] = 5
    wep_auto[72] = false
    wep_load[72] = 16
    wep_text[72] = "don't breathe"

    wep_name[73] = "FLAME CANNON"
    wep_type[73] = 4
    wep_cost[73] = 4
    wep_sprt[73] = sprFlameCannon
    wep_area[73] = 13
    wep_auto[73] = false
    wep_load[73] = 44
    wep_text[73] = "inferno"

    wep_name[74] = "LIGHTNING HAMMER"
    wep_type[74] = 0
    wep_cost[74] = 0
    wep_sprt[74] = sprLightningHammer
    wep_area[74] = 11
    wep_auto[74] = false
    wep_load[74] = 32
    wep_text[74] = "shock value"

    wep_name[75] = "FLAME SHOTGUN"
    wep_type[75] = 2
    wep_cost[75] = 1
    wep_sprt[75] = sprFlameShotgun
    wep_area[75] = 5
    wep_auto[75] = false
    wep_load[75] = 20
    wep_text[75] = "a burning sensation"

    wep_name[76] = "DOUBLE FLAME SHOTGUN"
    wep_type[76] = 2
    wep_cost[76] = 2
    wep_sprt[76] = sprDoubleFlameShotgun
    wep_area[76] = 7
    wep_auto[76] = false
    wep_load[76] = 28
    wep_text[76] = "incinerate them"

    wep_name[77] = "AUTO FLAME SHOTGUN"
    wep_type[77] = 2
    wep_cost[77] = 1
    wep_sprt[77] = sprAutoFlameShotgun
    wep_area[77] = 10
    wep_auto[77] = true
    wep_load[77] = 5
    wep_text[77] = "raining fire"

    wep_name[78] = "CLUSTER LAUNCHER"
    wep_type[78] = 4
    wep_cost[78] = 2
    wep_sprt[78] = sprClusterNader
    wep_area[78] = 7
    wep_auto[78] = false
    wep_load[78] = 26
    wep_text[78] = "small explosions"

    wep_name[79] = "GRENADE SHOTGUN"
    wep_type[79] = 4
    wep_cost[79] = 1
    wep_sprt[79] = sprGrenadeShotgun
    wep_area[79] = 7
    wep_auto[79] = false
    wep_load[79] = 16
    wep_text[79] = "don't get too close"

    wep_name[80] = "GRENADE RIFLE"
    wep_type[80] = 4
    wep_cost[80] = 1
    wep_sprt[80] = sprGrenadeRifle
    wep_area[80] = 9
    wep_auto[80] = false
    wep_load[80] = 10
    wep_text[80] = "distant explosions"

    wep_name[81] = "ROGUE RIFLE"
    wep_type[81] = 1
    wep_cost[81] = 2
    wep_sprt[81] = sprRogueRifle
    wep_area[81] = -1
    wep_auto[81] = false
    wep_load[81] = 6
    wep_text[81] = "loose cannon"

    wep_name[82] = "PARTY GUN"
    wep_type[82] = 4
    wep_cost[82] = 0
    wep_sprt[82] = sprPartyGun
    wep_area[82] = -1
    wep_auto[82] = false
    wep_load[82] = 20
    wep_text[82] = "woohoo!"

    wep_name[83] = "DOUBLE MINIGUN"
    wep_type[83] = 1
    wep_cost[83] = 2
    wep_sprt[83] = sprDoubleMinigun
    wep_area[83] = 14
    wep_auto[83] = true
    wep_load[83] = 1
    wep_text[83] = "sea of @ybullets@s"

    wep_name[84] = "GATLING BAZOOKA"
    wep_type[84] = 4
    wep_cost[84] = 1
    wep_sprt[84] = sprGatlingBazooka
    wep_area[84] = 12
    wep_auto[84] = true
    wep_load[84] = 10
    wep_text[84] = "explosions"

    wep_name[85] = "AUTO GRENADE SHOTGUN"
    wep_type[85] = 4
    wep_cost[85] = 1
    wep_sprt[85] = sprAutoGrenadeShotgun
    wep_area[85] = 14
    wep_auto[85] = true
    wep_load[85] = 8
    wep_text[85] = "stay away"

    wep_name[86] = "ULTRA REVOLVER"
    wep_type[86] = 1
    wep_cost[86] = 2
    wep_sprt[86] = sprUltraRevolver
    wep_area[86] = 21
    wep_auto[86] = true
    wep_load[86] = 4
    wep_text[86] = "feeling @gultra@s"

    wep_name[87] = "ULTRA LASER PISTOL"
    wep_type[87] = 5
    wep_cost[87] = 3
    wep_sprt[87] = sprUltraLaserPistol
    wep_area[87] = 21
    wep_auto[87] = false
    wep_load[87] = 8
    wep_text[87] = "unstoppable"

    wep_name[88] = "SLEDGEHAMMER"
    wep_type[88] = 0
    wep_cost[88] = 0
    wep_sprt[88] = sprHammer
    wep_area[88] = 4
    wep_auto[88] = false
    wep_load[88] = 35
    wep_text[88] = "steel on steel"

    wep_name[89] = "HEAVY REVOLVER"
    wep_type[89] = 1
    wep_cost[89] = 2
    wep_sprt[89] = sprHeavyRevolver
    wep_area[89] = 9
    wep_auto[89] = false
    wep_load[89] = 5
    wep_text[89] = "heavy @ybullets@s"

    wep_name[90] = "HEAVY MACHINEGUN"
    wep_type[90] = 1
    wep_cost[90] = 2
    wep_sprt[90] = sprHeavyMachinegun
    wep_area[90] = 10
    wep_auto[90] = true
    wep_load[90] = 5
    wep_text[90] = "get some"

    wep_name[91] = "HEAVY SLUGGER"
    wep_type[91] = 2
    wep_cost[91] = 2
    wep_sprt[91] = sprHeavySlugger
    wep_area[91] = 10
    wep_auto[91] = false
    wep_load[91] = 13
    wep_text[91] = "get out of here"

    wep_name[92] = "ULTRA SHOVEL"
    wep_type[92] = 0
    wep_cost[92] = 0
    wep_sprt[92] = sprUltraShovel
    wep_area[92] = 21
    wep_auto[92] = false
    wep_load[92] = 15
    wep_text[92] = "perfection"

    wep_name[93] = "ULTRA SHOTGUN"
    wep_type[93] = 2
    wep_cost[93] = 3
    wep_sprt[93] = sprUltraShotgun
    wep_area[93] = 21
    wep_auto[93] = false
    wep_load[93] = 12
    wep_text[93] = "no chance"

    wep_name[94] = "ULTRA CROSSBOW"
    wep_type[94] = 3
    wep_cost[94] = 1
    wep_sprt[94] = sprUltraCrossbow
    wep_area[94] = 21
    wep_auto[94] = false
    wep_load[94] = 11
    wep_text[94] = "nowhere to hide"

    wep_name[95] = "ULTRA GRENADE LAUNCHER"
    wep_type[95] = 4
    wep_cost[95] = 1
    wep_sprt[95] = sprUltraGrenadeLauncher
    wep_area[95] = 21
    wep_auto[95] = false
    wep_load[95] = 16
    wep_text[95] = "they'll come"

    wep_name[96] = "PLASMA MINIGUN"
    wep_type[96] = 5
    wep_cost[96] = 2
    wep_sprt[96] = sprPlasmaMinigun
    wep_area[96] = 15
    wep_auto[96] = true
    wep_load[96] = 3
    wep_text[96] = "all the fun"

    wep_name[97] = "DEVASTATOR"
    wep_type[97] = 5
    wep_cost[97] = 8
    wep_sprt[97] = sprDevastator
    wep_area[97] = 16
    wep_auto[97] = false
    wep_load[97] = 60
    wep_text[97] = "..."

    wep_name[98] = "GOLDEN PLASMA GUN"
    wep_type[98] = 5
    wep_cost[98] = 2
    wep_sprt[98] = sprGoldPlasmaGun
    wep_area[98] = 20
    wep_auto[98] = true
    wep_load[98] = 16
    wep_text[98] = "@ybeautiful alloys"

    wep_name[99] = "GOLDEN SLUGGER"
    wep_type[99] = 2
    wep_cost[99] = 1
    wep_sprt[99] = sprGoldSlugger
    wep_area[99] = 20
    wep_auto[99] = false
    wep_load[99] = 20
    wep_text[99] = "@ypriceless hardwood"

    wep_name[100] = "GOLDEN SPLINTER GUN"
    wep_type[100] = 3
    wep_cost[100] = 1
    wep_sprt[100] = sprGoldSplinterGun
    wep_area[100] = 20
    wep_auto[100] = false
    wep_load[100] = 19
    wep_text[100] = "even the @yammo@s is expensive"

    wep_name[101] = "GOLDEN SCREWDRIVER"
    wep_type[101] = 0
    wep_cost[101] = 0
    wep_sprt[101] = sprGoldScrewdriver
    wep_area[101] = 20
    wep_auto[101] = false
    wep_load[101] = 9
    wep_text[101] = "@yivory handle"

    wep_name[102] = "GOLDEN BAZOOKA"
    wep_type[102] = 4
    wep_cost[102] = 1
    wep_sprt[102] = sprGoldBazooka
    wep_area[102] = 20
    wep_auto[102] = false
    wep_load[102] = 28
    wep_text[102] = "worth its weight in @ygold"

    wep_name[103] = "GOLDEN ASSAULT RIFLE"
    wep_type[103] = 1
    wep_cost[103] = 3
    wep_sprt[103] = sprGoldAssaultRifle
    wep_area[103] = 20
    wep_auto[103] = false
    wep_load[103] = 9
    wep_text[103] = "bursts of @ygold"

    wep_name[104] = "SUPER DISC GUN"
    wep_type[104] = 3
    wep_cost[104] = 5
    wep_sprt[104] = sprSuperDiscGun
    wep_area[104] = 11
    wep_auto[104] = true
    wep_load[104] = 12
    wep_text[104] = "many apologies"

    wep_name[105] = "HEAVY AUTO CROSSBOW"
    wep_type[105] = 3
    wep_cost[105] = 2
    wep_sprt[105] = sprAutoHeavyCrossbow
    wep_area[105] = 16
    wep_auto[105] = true
    wep_load[105] = 13
    wep_text[105] = "weighs you down"

    wep_name[106] = "HEAVY ASSAULT RIFLE"
    wep_type[106] = 1
    wep_cost[106] = 6
    wep_sprt[106] = sprHeavyAssaultRifle
    wep_area[106] = 13
    wep_auto[106] = false
    wep_load[106] = 9
    wep_text[106] = "go for it"

    wep_name[107] = "BLOOD CANNON"
    wep_type[107] = 4
    wep_cost[107] = 4
    wep_sprt[107] = sprBloodCannon
    wep_area[107] = 12
    wep_auto[107] = true
    wep_load[107] = 19
    wep_text[107] = "fully organic"

    wep_name[108] = "DOG SPIN ATTACK"
    wep_type[108] = 1
    wep_cost[108] = 15
    wep_sprt[108] = mskNone
    wep_area[108] = -1
    wep_auto[108] = false
    wep_load[108] = 120
    wep_text[108] = ""

    wep_name[109] = "DOG MISSILE"
    wep_type[109] = 4
    wep_cost[109] = 1
    wep_sprt[109] = mskNone
    wep_area[109] = -1
    wep_auto[109] = false
    wep_load[109] = 1
    wep_text[109] = ""

    wep_name[110] = "INCINERATOR"
    wep_type[110] = 1
    wep_cost[110] = 3
    wep_sprt[110] = sprIncinerator
    wep_area[110] = 16
    wep_auto[110] = true
    wep_load[110] = 2
    wep_text[110] = "..."

    wep_name[111] = "SUPER PLASMA CANNON"
    wep_type[111] = 5
    wep_cost[111] = 24
    wep_sprt[111] = sprSuperPlasmaCannon
    wep_area[111] = 16
    wep_auto[111] = false
    wep_load[111] = 260
    wep_text[111] = "comedy"

    wep_name[112] = "SEEKER PISTOL"
    wep_type[112] = 3
    wep_cost[112] = 1
    wep_sprt[112] = sprSeekerPistol
    wep_area[112] = 7
    wep_auto[112] = false
    wep_load[112] = 16
    wep_text[112] = "no hiding"

    wep_name[113] = "SEEKER SHOTGUN"
    wep_type[113] = 3
    wep_cost[113] = 3
    wep_sprt[113] = sprSeekerShotgun
    wep_area[113] = 9
    wep_auto[113] = false
    wep_load[113] = 28
    wep_text[113] = "no escape"

    wep_name[114] = "ERASER"
    wep_type[114] = 2
    wep_cost[114] = 2
    wep_sprt[114] = sprEraser
    wep_area[114] = 8
    wep_auto[114] = false
    wep_load[114] = 20
    wep_text[114] = "goodbye head"

    wep_name[115] = "GUITAR"
    wep_type[115] = 0
    wep_cost[115] = 0
    wep_sprt[115] = sprGuitar
    wep_area[115] = -1
    wep_auto[115] = false
    wep_load[115] = 21
    wep_text[115] = "there's no reason to fight"

    wep_name[116] = "BOUNCER SMG"
    wep_type[116] = 1
    wep_cost[116] = 1
    wep_sprt[116] = sprBouncerSMG
    wep_area[116] = 6
    wep_auto[116] = true
    wep_load[116] = 3
    wep_text[116] = "watch your back"

    wep_name[117] = "BOUNCER SHOTGUN"
    wep_type[117] = 1
    wep_cost[117] = 6
    wep_sprt[117] = sprBouncerShotgun
    wep_area[117] = 6
    wep_auto[117] = true
    wep_load[117] = 18
    wep_text[117] = "they're everywhere"

    wep_name[118] = "HYPER SLUGGER"
    wep_type[118] = 2
    wep_cost[118] = 1
    wep_sprt[118] = sprHyperSlugger
    wep_area[118] = 15
    wep_auto[118] = false
    wep_load[118] = 10
    wep_text[118] = "time to hyper"

    wep_name[119] = "SUPER BAZOOKA"
    wep_type[119] = 4
    wep_cost[119] = 5
    wep_sprt[119] = sprSuperBazooka
    wep_area[119] = 11
    wep_auto[119] = false
    wep_load[119] = 40
    wep_text[119] = "this is getting silly"

    wep_name[120] = "FROG PISTOL"
    wep_type[120] = 1
    wep_cost[120] = 2
    wep_sprt[120] = sprFrogBlaster
    wep_area[120] = -1
    wep_auto[120] = false
    wep_load[120] = 7
    wep_text[120] = "always"

    wep_name[121] = "BLACK SWORD"
    wep_type[121] = 0
    wep_cost[121] = 0
    wep_sprt[121] = sprBlackSword
    wep_area[121] = -1
    wep_auto[121] = false
    wep_load[121] = 16
    wep_text[121] = "chicken fears her @wsword@s"

    wep_name[122] = "GOLDEN NUKE LAUNCHER"
    wep_type[122] = 4
    wep_cost[122] = 3
    wep_sprt[122] = sprGoldNukeLauncher
    wep_area[122] = 12
    wep_auto[122] = false
    wep_load[122] = 40
    wep_text[122] = "@yexcessive"

    wep_name[123] = "GOLDEN DISC GUN"
    wep_type[123] = 3
    wep_cost[123] = 1
    wep_sprt[123] = sprGoldDiscgun
    wep_area[123] = 12
    wep_auto[123] = true
    wep_load[123] = 8
    wep_text[123] = "@ygo in style"

    wep_name[124] = "HEAVY GRENADE LAUNCHER"
    wep_type[124] = 4
    wep_cost[124] = 2
    wep_sprt[124] = sprHeavyGrenadeLauncher
    wep_area[124] = 8
    wep_auto[124] = false
    wep_load[124] = 26
    wep_text[124] = "watch out"

    wep_name[125] = "GUN GUN"
    wep_type[125] = 5
    wep_cost[125] = 40
    wep_sprt[125] = sprGunGun
    wep_area[125] = 19
    wep_auto[125] = false
    wep_load[125] = 90
    wep_text[125] = "make it"

    maxwep = 125

    wep_lout[1] = sprRevolverLoadout
    wep_lout[39] = sprGoldRevolverLoadout
    wep_lout[40] = sprGoldHammerLoadout
    wep_lout[41] = sprGoldMachinegunLoadout
    wep_lout[42] = sprGoldShotgunLoadout
    wep_lout[43] = sprGoldCrossbowLoadout
    wep_lout[44] = sprGoldNaderLoadout
    wep_lout[45] = sprGoldLaserPistolLoadout
    wep_lout[46] = sprChickenSwordLoadout
    wep_lout[56] = sprRustyRevolverLoadout
    wep_lout[81] = sprRogueRifleLoadout
    wep_lout[98] = sprGoldPlasmaGunLoadout
    wep_lout[99] = sprGoldSluggerLoadout
    wep_lout[100] = sprGoldSplinterGunLoadout
    wep_lout[101] = sprGoldScrewdriverLoadout
    wep_lout[102] = sprGoldBazookaLoadout
    wep_lout[103] = sprGoldAssaultRifleLoadout
    wep_lout[108] = mskNone
    wep_lout[109] = mskNone
    wep_lout[122] = sprGoldNukeLauncherLoadout
    wep_lout[123] = sprGoldDiscgunLoadout

    wep_rads[86] = 4
    wep_rads[87] = 14
    wep_rads[93] = 14
    wep_rads[94] = 12
    wep_rads[95] = 16
    wep_rads[92] = 16

    wep_name[255] = "GOLDEN FROG PISTOL"
    wep_type[255] = 1
    wep_auto[255] = 0
    wep_load[255] = 6
    wep_cost[255] = 1
    wep_sprt[255] = sprGoldFrogBlaster
    wep_area[255] = -1
    wep_text[255] = "ALWAYS BELIEVE IN YOUR SOUL"
    wep_lout[255] = sprGoldToxicGunLoadout
    wep_rads[255] = 0

    wep_swap[0] = sndSwapPistol
    wep_swap[1] = sndSwapPistol
    wep_swap[2] = sndSwapMachinegun
    wep_swap[3] = sndSwapHammer
    wep_swap[4] = sndSwapMachinegun
    wep_swap[5] = sndSwapShotgun
    wep_swap[6] = sndSwapBow
    wep_swap[7] = sndSwapExplosive
    wep_swap[8] = sndSwapShotgun
    wep_swap[9] = sndSwapMachinegun
    wep_swap[10] = sndSwapShotgun
    wep_swap[11] = sndSwapBow
    wep_swap[12] = sndSwapBow
    wep_swap[13] = sndSwapHammer
    wep_swap[14] = sndSwapExplosive
    wep_swap[15] = sndSwapExplosive
    wep_swap[16] = sndSwapPistol
    wep_swap[17] = sndSwapMachinegun
    wep_swap[18] = sndSwapBow
    wep_swap[19] = sndSwapEnergy
    wep_swap[20] = sndSwapEnergy
    wep_swap[21] = sndSwapShotgun
    wep_swap[22] = sndSwapShotgun
    wep_swap[23] = sndSwapShotgun
    wep_swap[24] = sndSwapEnergy
    wep_swap[25] = sndSwapShotgun
    wep_swap[26] = sndSwapMachinegun
    wep_swap[27] = sndSwapSword
    wep_swap[28] = sndSwapEnergy
    wep_swap[29] = sndSwapExplosive
    wep_swap[30] = sndSwapBow
    wep_swap[31] = sndSwapBow
    wep_swap[32] = sndSwapMachinegun
    wep_swap[33] = sndSwapShotgun
    wep_swap[34] = sndSwapEnergy
    wep_swap[35] = sndSwapEnergy
    wep_swap[36] = sndSwapHammer
    wep_swap[37] = sndSwapMotorized
    wep_swap[38] = sndSwapExplosive
    wep_swap[39] = sndSwapPistol
    wep_swap[40] = sndSwapHammer
    wep_swap[41] = sndSwapMachinegun
    wep_swap[42] = sndSwapShotgun
    wep_swap[43] = sndSwapBow
    wep_swap[44] = sndSwapExplosive
    wep_swap[45] = sndSwapEnergy
    wep_swap[46] = sndSwapSword
    wep_swap[47] = sndSwapExplosive
    wep_swap[48] = sndSwapEnergy
    wep_swap[49] = sndSwapMachinegun
    wep_swap[50] = sndSwapFlame
    wep_swap[51] = sndSwapDragon
    wep_swap[52] = sndSwapFlame
    wep_swap[53] = sndSwapEnergy
    wep_swap[54] = sndSwapExplosive
    wep_swap[55] = sndSwapEnergy
    wep_swap[56] = sndSwapPistol
    wep_swap[57] = sndSwapEnergy
    wep_swap[58] = sndSwapEnergy
    wep_swap[59] = sndSwapEnergy
    wep_swap[60] = sndSwapExplosive
    wep_swap[61] = sndSwapShotgun
    wep_swap[62] = sndSwapBow
    wep_swap[63] = sndSwapBow
    wep_swap[64] = sndSwapEnergy
    wep_swap[65] = sndSwapMachinegun
    wep_swap[66] = sndSwapBow
    wep_swap[67] = sndSwapHammer
    wep_swap[68] = sndSwapEnergy
    wep_swap[69] = sndSwapMachinegun
    wep_swap[70] = sndSwapEnergy
    wep_swap[71] = sndSwapMachinegun
    wep_swap[72] = sndSwapExplosive
    wep_swap[73] = sndSwapFlame
    wep_swap[74] = sndSwapHammer
    wep_swap[75] = sndSwapShotgun
    wep_swap[76] = sndSwapShotgun
    wep_swap[77] = sndSwapShotgun
    wep_swap[78] = sndSwapExplosive
    wep_swap[79] = sndSwapExplosive
    wep_swap[80] = sndSwapExplosive
    wep_swap[81] = sndSwapPistol
    wep_swap[82] = sndSwapFlame
    wep_swap[83] = sndSwapMachinegun
    wep_swap[84] = sndSwapExplosive
    wep_swap[85] = sndSwapExplosive
    wep_swap[86] = sndSwapPistol
    wep_swap[87] = sndSwapEnergy
    wep_swap[88] = sndSwapHammer
    wep_swap[89] = sndSwapPistol
    wep_swap[90] = sndSwapMachinegun
    wep_swap[91] = sndSwapShotgun
    wep_swap[92] = sndSwapHammer
    wep_swap[93] = sndSwapShotgun
    wep_swap[94] = sndSwapBow
    wep_swap[95] = sndSwapExplosive
    wep_swap[96] = sndSwapEnergy
    wep_swap[97] = sndSwapEnergy
    wep_swap[98] = sndSwapEnergy
    wep_swap[99] = sndSwapShotgun
    wep_swap[100] = sndSwapBow
    wep_swap[101] = sndSwapSword
    wep_swap[102] = sndSwapExplosive
    wep_swap[103] = sndSwapMachinegun
    wep_swap[104] = sndSwapBow
    wep_swap[105] = sndSwapBow
    wep_swap[106] = sndSwapMachinegun
    wep_swap[107] = sndSwapExplosive
    wep_swap[108] = sndSwapExplosive
    wep_swap[109] = sndSwapExplosive
    wep_swap[110] = sndSwapMachinegun
    wep_swap[111] = sndSwapEnergy
    wep_swap[112] = sndSwapBow
    wep_swap[113] = sndSwapBow
    wep_swap[114] = sndSwapShotgun
    wep_swap[115] = sndSwapGuitar
    wep_swap[116] = sndSwapPistol
    wep_swap[117] = sndSwapPistol
    wep_swap[118] = sndSwapShotgun
    wep_swap[119] = sndSwapExplosive
    wep_swap[120] = sndSwapPistol
    wep_swap[121] = sndSwapSword
    wep_swap[122] = sndSwapExplosive
    wep_swap[123] = sndSwapBow
    wep_swap[124] = sndSwapExplosive
    wep_swap[125] = sndSwapEnergy
    wep_swap[126] = sndSwapPistol
    wep_swap[127] = sndSwapPistol

    wep_swap[255] = sndSwapPistol

    // 0 - melee, 1 - bullets, 2 - shells, 3 - bolts, 4 - explosives, 5 - energy
    typ_ammo = [0, 32, 8, 7, 6, 10]

    with Player {
        if race == 1 {
            other.typ_ammo[1] += 8
            other.typ_ammo[2] += 2
            other.typ_ammo[3] += 2
            other.typ_ammo[4] += 2
            other.typ_ammo[5] += 3
        }
    }

    typ_amax = [
    1000,
    255 + skill_get(10) * 300,
    55 + skill_get(10) * 44,
    55 + skill_get(10) * 44,
    55 + skill_get(10) * 44,
    55 + skill_get(10) * 44]

    typ_name = ["MELEE", "BULLETS", "SHELLS", "BOLTS", "EXPLOSIVES", "ENERGY"]
}