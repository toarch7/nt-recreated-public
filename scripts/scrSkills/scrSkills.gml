enum Mut
{
	None = 0,
	RhinoSkin = 1,
	ExtraFeet = 2,
	PlutoniumHunger = 3,
	RabbitPaw = 4,
	ThroneButt = 5,
	LuckyShot = 6,
	Bloodlust = 7,
	GammaGuts = 8,
	SecondStomach = 9,
	BackMuscle = 10,
	ScarierFace = 11,
	Euphoria = 12,
	LongArms = 13,
	BoilingVeins = 14,
	ShotgunShoulders = 15,
	RecycleGlands = 16,
	LaserBrain = 17,
	LastWish = 18,
	EagleEyes = 19,
	ImpactWrists = 20,
	BoltMarrow = 21,
	Stress = 22,
	TriggerFingers = 23,
	SharpTeeth = 24,
	Patience = 25,
	HammerHead = 26,
	StrongSpirit = 27,
	OpenMind = 28,
	HeavyHeart = 29
}

function scrSkills() {
    skill_name[Mut.None] = ""
    skill_text[Mut.None] = ""
    skill_msnd[Mut.None] = sndMut
    skill_tips[Mut.None] = ""

    skill_name[Mut.RhinoSkin] = "RHINO SKIN"
    skill_text[Mut.RhinoSkin] = "+4 @rMAX HP"
    skill_msnd[Mut.RhinoSkin] = sndMutRhinoSkin
    skill_tips[Mut.RhinoSkin] = "thick skin"

    skill_name[Mut.ExtraFeet] = "EXTRA FEET"
    skill_text[Mut.ExtraFeet] = "MORE @wSPEED#@sWALK NORMALY ON ALL TERRAIN"
    skill_msnd[Mut.ExtraFeet] = sndMutExtraFeet
    skill_tips[Mut.ExtraFeet] = "run forever"

    skill_name[Mut.PlutoniumHunger] = "PLUTONIUM HUNGER"
    skill_text[Mut.PlutoniumHunger] = "ATTRACT @wDROPS@s AND @gRADS@s FROM FURTHER"
    skill_msnd[Mut.PlutoniumHunger] = sndMutPlutoniumHunger
    skill_tips[Mut.PlutoniumHunger] = "need those rads"

    skill_name[Mut.RabbitPaw] = "RABBIT PAW"
    skill_text[Mut.RabbitPaw] = "MORE @rHP@s AND @yAMMO@s DROPS"
    skill_msnd[Mut.RabbitPaw] = sndMutRabbitPaw
    skill_tips[Mut.RabbitPaw] = "feeling lucky"

    skill_name[Mut.ThroneButt] = "THRONE BUTT"
    skill_text[Mut.ThroneButt] = "UPGRADES YOUR @wSPECIAL ABILITY"
	skill_msnd[Mut.ThroneButt] = sndMutThroneButt
    skill_tips[Mut.ThroneButt] = "sit on the throne"

    skill_name[Mut.LuckyShot] = "LUCKY SHOT"
    skill_text[Mut.LuckyShot] = "SOME KILLS REGENERATE @yAMMO"
    skill_msnd[Mut.LuckyShot] = sndMutLuckyShot
    skill_tips[Mut.LuckyShot] = "AMMO everywhere"

    skill_name[Mut.Bloodlust] = "BLOODLUST"
    skill_text[Mut.Bloodlust] = "SOME KILLS REGENERATE @rHP"
    skill_msnd[Mut.Bloodlust] = sndMutBloodLust
    skill_tips[Mut.Bloodlust] = "drink blood"

    skill_name[Mut.GammaGuts] = "GAMMA GUTS"
    skill_text[Mut.GammaGuts] = "@wENEMIES@s TOUCHING YOU TAKE DAMAGE"
    skill_msnd[Mut.GammaGuts] = sndMutGammaGuts
    skill_tips[Mut.GammaGuts] = "skin glows"

    skill_name[Mut.SecondStomach] = "SECOND STOMACH"
    skill_text[Mut.SecondStomach] = "MORE @rHP@s FROM MEDKITS"
    skill_msnd[Mut.SecondStomach] = sndMutSecondStomach
    skill_tips[Mut.SecondStomach] = "stomach rumbles"

    skill_name[Mut.BackMuscle] = "BACK MUSCLE"
    skill_text[Mut.BackMuscle] = "HIGHER @yAMMO@s MAX"
    skill_msnd[Mut.BackMuscle] = sndMutBackMuscle
    skill_tips[Mut.BackMuscle] = "great strength"

    skill_name[Mut.ScarierFace] = "SCARIER FACE"
    skill_text[Mut.ScarierFace] = "LESS @wENEMY @rHP"
    skill_msnd[Mut.ScarierFace] = sndMutScarierFace
    skill_tips[Mut.ScarierFace] = "mirrors will break"

    skill_name[Mut.Euphoria] = "EUPHORIA"
    skill_text[Mut.Euphoria] = "SLOWER @wENEMY@s BULLETS"
    skill_msnd[Mut.Euphoria] = sndMutEuphoria
    skill_tips[Mut.Euphoria] = "time passes slowly"

    skill_name[Mut.LongArms] = "LONG ARMS"
    skill_text[Mut.LongArms] = "MORE @wMELEE@s RANGE"
    skill_msnd[Mut.LongArms] = sndMutLongArms
    skill_tips[Mut.LongArms] = "more reach"

    skill_name[Mut.BoilingVeins] = "BOILING VEINS"
    skill_text[Mut.BoilingVeins] = "@wNO DAMAGE@s FROM EXPLOSIONS AND FIRE#WHEN UNDER 4 @rHP"
    skill_msnd[Mut.BoilingVeins] = sndMutBoilingVeins
    skill_tips[Mut.BoilingVeins] = "temperature is rising"

    skill_name[Mut.ShotgunShoulders] = "SHOTGUN SHOULDERS"
    skill_text[Mut.ShotgunShoulders] = "@wSHELLS@s BOUNCE FURTHER"
    skill_msnd[Mut.ShotgunShoulders] = sndMutShotgunFingers
    skill_tips[Mut.ShotgunShoulders] = "shells are friends"

    skill_name[Mut.RecycleGlands] = "RECYCLE GLANDS"
    skill_text[Mut.RecycleGlands] = "MOST HIT @wBULLETS@s BECOME @yAMMO"
    skill_msnd[Mut.RecycleGlands] = sndMutRecycleGland
    skill_tips[Mut.RecycleGlands] = "no need to aim"

    skill_name[Mut.LaserBrain] = "LASER BRAIN"
    skill_text[Mut.LaserBrain] = "@wENERGY@s WEAPONS DEAL MORE @wDAMAGE@s"
    skill_msnd[Mut.LaserBrain] = sndMutLaserBrain
    skill_tips[Mut.LaserBrain] = "neurons everywhere"

    skill_name[Mut.LastWish] = "LAST WISH"
    skill_text[Mut.LastWish] = "GET FULL @rHEALTH @sAND SOME @yAMMO"
    skill_msnd[Mut.LastWish] = sndMutLastWish
    skill_tips[Mut.LastWish] = "listen"

    skill_name[Mut.EagleEyes] = "EAGLE EYES"
    skill_text[Mut.EagleEyes] = "BETTER ACCURACY"
    skill_msnd[Mut.EagleEyes] = sndMutEagleEyes
    skill_tips[Mut.EagleEyes] = "every shot connects"

    skill_name[Mut.ImpactWrists] = "IMPACT WRISTS"
    skill_text[Mut.ImpactWrists] = "CORPSES FLY & HIT HARDER"
    skill_msnd[Mut.ImpactWrists] = sndMutImpactWrists
    skill_tips[Mut.ImpactWrists] = "see them fly"

    skill_name[Mut.BoltMarrow] = "BOLT MARROW"
    skill_text[Mut.BoltMarrow] = "HOMING @wBOLTS"
    skill_msnd[Mut.BoltMarrow] = sndMutBoltMarrow
    skill_tips[Mut.BoltMarrow] = "bolts everywhere"

    skill_name[Mut.Stress] = "STRESS"
    skill_text[Mut.Stress] = "HIGHER RATE OF FIRE#AS @rHP@s GETS LOWER"
    skill_msnd[Mut.Stress] = sndMutStress
    skill_tips[Mut.Stress] = "shaking"

    skill_name[Mut.TriggerFingers] = "TRIGGER FINGERS"
    skill_text[Mut.TriggerFingers] = "KILLS LOWER YOUR RELOAD TIME"
    skill_msnd[Mut.TriggerFingers] = sndMutTriggerFingers
    skill_tips[Mut.TriggerFingers] = ""

    skill_name[Mut.SharpTeeth] = "SHARP TEETH"
    skill_text[Mut.SharpTeeth] = "DAMAGE TAKEN IS DEALT TO#ALL ENEMIES ON SCREEN"
    skill_msnd[Mut.SharpTeeth] = sndMutSharpTeeth
    skill_tips[Mut.SharpTeeth] = ""

    skill_name[Mut.Patience] = "PATIENCE"
    skill_text[Mut.Patience] = "@gMUTATE@s LATER"
    skill_msnd[Mut.Patience] = sndMutPatience
    skill_tips[Mut.Patience] = ""

    skill_name[Mut.HammerHead] = "HAMMER HEAD"
    skill_text[Mut.HammerHead] = "BREAK THROUGH LIMITED AMOUNT OF WALLS"
    skill_msnd[Mut.HammerHead] = sndMutHammerhead
    skill_tips[Mut.HammerHead] = ""

    skill_name[Mut.StrongSpirit] = "STRONG SPIRIT"
    skill_text[Mut.StrongSpirit] = "PREVENT DEATH ONCE#RECHARGE AT FULL @rHP@s IN NEXT LEVEL"
    skill_msnd[Mut.StrongSpirit] = sndMutStrongSpirit
    skill_tips[Mut.StrongSpirit] = "NOT TODAY"

    skill_name[Mut.OpenMind] = "OPEN MIND"
    skill_text[Mut.OpenMind] = "EXTRA CHEST SPAWN"
    skill_msnd[Mut.OpenMind] = sndMutOpenMind
    skill_tips[Mut.OpenMind] = "DID YOU WAIT FOR IT?"

    skill_name[Mut.HeavyHeart] = "HEAVY HEART"
    skill_text[Mut.HeavyHeart] = "MORE WEAPON DROPS"
    skill_msnd[Mut.HeavyHeart] = sndMutHeavyHeart
    skill_tips[Mut.HeavyHeart] = ""

    maxskill = 28
	
	if instance_exists(Player) && instance_exists(GameCont) {
        var _thronebutt_text = ""
		
        if instance_exists(CoopController) {
			with Player {
				var _race_name = loc(scrRaceGetName(race)),
					_butt_text = loc(scrRaceGetThroneButtDescription(race))
				
				_thronebutt_text = _race_name + " - " + _butt_text + "\n"
			}
			_thronebutt_text = string_trim_end(_thronebutt_text)
        }
		else {
			with Player {
				_thronebutt_text = loc(scrRaceGetThroneButtDescription(race))
			}
		}
		
        skill_text[mut_throne_butt] = _thronebutt_text
    }
}