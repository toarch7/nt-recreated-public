function scrSkills() {
    skill_name[0] = ""
    skill_text[0] = ""
    skill_msnd[0] = sndMut
    skill_tips[0] = ""

    skill_name[1] = "RHINO SKIN"
    skill_text[1] = "+4 @rMAX HP"
    skill_msnd[1] = sndMutRhinoSkin
    skill_tips[1] = "thick skin"

    skill_name[2] = "EXTRA FEET"
    skill_text[2] = "MORE @wSPEED#@sWALK NORMALY ON ALL TERRAIN"
    skill_msnd[2] = sndMutExtraFeet
    skill_tips[2] = "run forever"

    skill_name[3] = "PLUTONIUM HUNGER"
    skill_text[3] = "ATTRACT @wDROPS@s AND @gRADS@s FROM FURTHER"
    skill_msnd[3] = sndMutPlutoniumHunger
    skill_tips[3] = "need those rads"

    skill_name[4] = "RABBIT PAW"
    skill_text[4] = "MORE @rHP@s AND @yAMMO@s DROPS"
    skill_msnd[4] = sndMutRabbitPaw
    skill_tips[4] = "feeling lucky"

    skill_name[5] = "THRONE BUTT"
    skill_text[5] = "UPGRADES YOUR @wSPECIAL ABILITY"

    if instance_exists(Player) && instance_exists(GameCont) {
        var _tb = ""

        if instance_exists(CoopController) {
            with Player {
                if _tb != ""
                _tb += "#"
                _tb += loc(race_name[race]) + " - " + loc(race_butt[race])
            }
        } else with Player _tb = loc(race_butt[race])

        skill_text[5] = _tb
    }

    skill_msnd[5] = sndMutThroneButt
    skill_tips[5] = "sit on the throne"

    skill_name[6] = "LUCKY SHOT"
    skill_text[6] = "SOME KILLS REGENERATE @yAMMO"
    skill_msnd[6] = sndMutLuckyShot
    skill_tips[6] = "AMMO everywhere"

    skill_name[7] = "BLOODLUST"
    skill_text[7] = "SOME KILLS REGENERATE @rHP"
    skill_msnd[7] = sndMutBloodLust
    skill_tips[7] = "drink blood"

    skill_name[8] = "GAMMA GUTS"
    skill_text[8] = "@wENEMIES@s TOUCHING YOU TAKE DAMAGE"
    skill_msnd[8] = sndMutGammaGuts
    skill_tips[8] = "skin glows"

    skill_name[9] = "SECOND STOMACH"
    skill_text[9] = "MORE @rHP@s FROM MEDKITS"
    skill_msnd[9] = sndMutSecondStomach
    skill_tips[9] = "stomach rumbles"

    skill_name[10] = "BACK MUSCLE"
    skill_text[10] = "HIGHER @yAMMO@s MAX"
    skill_msnd[10] = sndMutBackMuscle
    skill_tips[10] = "great strength"

    skill_name[11] = "SCARIER FACE"
    skill_text[11] = "LESS @wENEMY @rHP"
    skill_msnd[11] = sndMutScarierFace
    skill_tips[11] = "mirrors will break"

    skill_name[12] = "EUPHORIA"
    skill_text[12] = "SLOWER @wENEMY@s BULLETS"
    skill_msnd[12] = sndMutEuphoria
    skill_tips[12] = "time passes slowly"

    skill_name[13] = "LONG ARMS"
    skill_text[13] = "MORE @wMELEE@s RANGE"
    skill_msnd[13] = sndMutLongArms
    skill_tips[13] = "more reach"

    skill_name[14] = "BOILING VEINS"
    skill_text[14] = "@wNO DAMAGE@s FROM EXPLOSIONS AND FIRE#WHEN UNDER 4 @rHP"
    skill_msnd[14] = sndMutBoilingVeins
    skill_tips[14] = "temperature is rising"

    skill_name[15] = "SHOTGUN SHOULDERS"
    skill_text[15] = "@wSHELLS@s BOUNCE FURTHER"
    skill_msnd[15] = sndMutShotgunFingers
    skill_tips[15] = "shells are friends"

    skill_name[16] = "RECYCLE GLANDS"
    skill_text[16] = "MOST HIT @wBULLETS@s BECOME @yAMMO"
    skill_msnd[16] = sndMutRecycleGland
    skill_tips[16] = "no need to aim"

    skill_name[17] = "LASER BRAIN"
    skill_text[17] = "@wENERGY@s WEAPONS DEAL MORE @wDAMAGE@s"
    skill_msnd[17] = sndMutLaserBrain
    skill_tips[17] = "neurons everywhere"

    skill_name[18] = "LAST WISH"
    skill_text[18] = "GET FULL @rHEALTH @sAND SOME @yAMMO"
    skill_msnd[18] = sndMutLastWish
    skill_tips[18] = "listen"

    skill_name[19] = "EAGLE EYES"
    skill_text[19] = "BETTER ACCURACY"
    skill_msnd[19] = sndMutEagleEyes
    skill_tips[19] = "every shot connects"

    skill_name[20] = "IMPACT WRISTS"
    skill_text[20] = "CORPSES FLY & HIT HARDER"
    skill_msnd[20] = sndMutImpactWrists
    skill_tips[20] = "see them fly"

    skill_name[21] = "BOLT MARROW"
    skill_text[21] = "HOMING @wBOLTS"
    skill_msnd[21] = sndMutBoltMarrow
    skill_tips[21] = "bolts everywhere"

    skill_name[22] = "STRESS"
    skill_text[22] = "HIGHER RATE OF FIRE#AS @rHP@s GETS LOWER"
    skill_msnd[22] = sndMutStress
    skill_tips[22] = "shaking"

    skill_name[23] = "TRIGGER FINGERS"
    skill_text[23] = "KILLS LOWER YOUR RELOAD TIME"
    skill_msnd[23] = sndMutTriggerFingers
    skill_tips[23] = ""

    skill_name[24] = "SHARP TEETHS"
    skill_text[24] = "DAMAGE TAKEN IS DEALT TO#ALL ENEMIES ON SCREEN"
    skill_msnd[24] = sndMutSharpTeeths
    skill_tips[24] = ""

    skill_name[25] = "PATIENCE"
    skill_text[25] = "@gMUTATE@s LATER"
    skill_msnd[25] = sndMutPatience
    skill_tips[25] = ""

    skill_name[26] = "HAMMER HEAD"
    skill_text[26] = "BREAK TROUGH LIMITED AMOUNT OF WALLS"
    skill_msnd[26] = sndMutHammerHead
    skill_tips[26] = ""

    skill_name[27] = "STRONG SPIRIT"
    skill_text[27] = "PREVENT DEATH ONCE#RECHARGE AT FULL @rHP@s IN NEXT LEVEL"
    skill_msnd[27] = sndMutStrongSpirit
    skill_tips[27] = "NOT TODAY"

    skill_name[28] = "OPEN MIND"
    skill_text[28] = "EXTRA CHEST SPAWN"
    skill_msnd[28] = sndMutOpenMind
    skill_tips[28] = "DID YOU WAIT FOR IT?"

    skill_name[29] = "HEAVY HEART"
    skill_text[29] = "MORE WEAPON DROPS"
    skill_msnd[29] = sndMutHeavyHeart
    skill_tips[29] = ""

    maxskill = 28
}