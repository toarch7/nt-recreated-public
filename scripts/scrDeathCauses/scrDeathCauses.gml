globalvar deathcause_types;
deathcause_types = array_create(HitId.NUM_HIT_IDS, undefined)

enum HitId {
	None = -1,
	Bandit,
	Maggot,
	RadMaggot,
	BigMaggot,
	Scorpion,
	GoldenScorpion,
	BigBandit,
	Rat,
	BigRat,
	GreenRat,
	Gator,
	Frog,
	SuperFrog,
	BallguyMama,
	Assassin,
	Raven,
	Salamander,
	Sniper,
	BigDog,
	Spider,
	LaserCrystal,
	HyperCrystal,
	SnowBandit,
	Snowbot,
	Wolf,
	SnowTank,
	LilHunter,
	LilHunterDie,
	Freak,
	Explofreak,
	Rhinofreak,
	Necromancer,
	Technomancer,
	Guardian,
	Exploguardian,
	DogGuardian,
	Throne,
	Throne2,
	Bonefish,
	Crab,
	Turtle,
	VenusGrunt,
	VenusSarge,
	Fireballer,
	SuperFireballer,
	Jock,
	CursedSpider,
	CursedCrystal,
	Mimic,
	HpMimic,
	Grunt,
	Inspector,
	Shielder,
	CrownGuardian,
	Explosion,
	SmallExplosion,
	FireTrap,
	Shield,
	Toxin,
	Horror,
	Barrel,
	ToxicBarrel,
	GoldenBarrel,
	Car,
	VenusCar,
	VenusCarFixed,
	VenusCar2,
	IcyCar,
	ThrownCar,
	Mine,
	CrownOfDeath,
	RogueStrike,
	BloodLauncher,
	BloodCannon,
	BloodHammer,
	Disc,
	CurseEat,
	BigDogMissile,
	HalloweenBandit,
	LilHunterFly,
	ThroneDeath,
	JungleBandit,
	JungleAssassin,
	JungleFly,
	CrownOfHatred,
	IceFlower,
	CursedAmmoPickup,
	UnderwaterLightning,
	EliteGrunt,
	BloodGamble,
	EliteShielder,
	EliteShielderShield,
	EliteInspector,
	Captain,
	Van,
	BuffAlligator,
	Generator,
	LightningCrystal,
	GoldenSnowTank,
	GreenExplosion,
	SmallGenerator,
	GoldenDisc,
	BigDogExplosion,
	PopoFreak,
	Throne2Death,
	OasisBoss,
	PopoExplosion,
	Player,
	PlayerRevive,
	WeaponMimic,
	GunGod,
	NUM_HIT_IDS
}

function scrDeathCauses() {
    scrDeathCauseDefine(HitId.Bandit, sprBanditIdle, "BANDIT")
    scrDeathCauseDefine(HitId.Maggot, sprMaggotIdle, "MAGGOT")
    scrDeathCauseDefine(HitId.RadMaggot, sprRadMaggot, "RAD MAGGOT")
    scrDeathCauseDefine(HitId.BigMaggot, sprBigMaggotIdle, "BIG MAGGOT")
    scrDeathCauseDefine(HitId.Scorpion, sprScorpionIdle, "SCORPION")
    scrDeathCauseDefine(HitId.GoldenScorpion, sprGoldScorpionIdle, "GOLDEN SCORPION")
    scrDeathCauseDefine(HitId.BigBandit, sprBanditBossIdle, "BIG BANDIT")
    scrDeathCauseDefine(HitId.Rat, sprRatIdle, "RAT")
    scrDeathCauseDefine(HitId.BigRat, sprRatkingIdle, "BIG RAT")
    scrDeathCauseDefine(HitId.GreenRat, sprFastRatIdle, "GREEN RAT")
    scrDeathCauseDefine(HitId.Gator, sprGatorIdle, "GATOR")
    scrDeathCauseDefine(HitId.Frog, sprExploderIdle, "FROG")
    scrDeathCauseDefine(HitId.SuperFrog, sprSuperFrogIdle, "SUPER FROG")
    scrDeathCauseDefine(HitId.BallguyMama, sprFrogQueenIdle, "BALLGUY MAMA")
    scrDeathCauseDefine(HitId.Assassin, sprMeleeIdle, "ASSASSIN")
    scrDeathCauseDefine(HitId.Raven, sprRavenIdle, "RAVEN")
    scrDeathCauseDefine(HitId.Salamander, sprSalamanderIdle, "SALAMANDER")
    scrDeathCauseDefine(HitId.Sniper, sprSniperIdle, "SNIPER")
    scrDeathCauseDefine(HitId.BigDog, sprScrapBossIdle, "BIG DOG")
    scrDeathCauseDefine(HitId.Spider, sprSpiderIdle, "SPIDER")
    scrDeathCauseDefine(HitId.LaserCrystal, sprLaserCrystalIdle, "LASER CRYSTAL")
    scrDeathCauseDefine(HitId.HyperCrystal, sprHyperCrystalIdle, "HYPER CRYSTAL")
    scrDeathCauseDefine(HitId.SnowBandit, sprSnowBanditIdle, "SNOW BANDIT")
    scrDeathCauseDefine(HitId.Snowbot, sprSnowBotIdle, "SNOWBOT")
    scrDeathCauseDefine(HitId.Wolf, sprWolfIdle, "WOLF")
    scrDeathCauseDefine(HitId.SnowTank, sprSnowTankIdle, "SNOWTANK")
    scrDeathCauseDefine(HitId.LilHunter, sprLilHunter, "LIL HUNTER")
    scrDeathCauseDefine(HitId.LilHunterDie, sprLilHunterHurt, "LIL HUNTER'S EXPLOSION")
    scrDeathCauseDefine(HitId.Freak, sprFreak1Idle, "FREAK")
    scrDeathCauseDefine(HitId.Explofreak, sprExploFreakIdle, "EXPLOFREAK")
    scrDeathCauseDefine(HitId.Rhinofreak, sprRhinoFreakIdle, "RHINOFREAK")
    scrDeathCauseDefine(HitId.Necromancer, sprNecromancerIdle, "NECROMANCER")
    scrDeathCauseDefine(HitId.Technomancer, sprTechnoMancer, "TECHNOMANCER")
    scrDeathCauseDefine(HitId.Guardian, sprGuardianIdle, "GUARDIAN")
    scrDeathCauseDefine(HitId.Exploguardian, sprExploGuardianIdle, "EXPLOGUARDIAN")
    scrDeathCauseDefine(HitId.DogGuardian, sprDogGuardianWalk, "DOG GUARDIAN")
    scrDeathCauseDefine(HitId.Throne, sprNothingOn, "THRONE")
    scrDeathCauseDefine(HitId.Throne2, sprNothing2Idle, "THRONE 2")
    scrDeathCauseDefine(HitId.Bonefish, sprBoneFish1Idle, "BONEFISH")
    scrDeathCauseDefine(HitId.Crab, sprCrabIdle, "CRAB")
    scrDeathCauseDefine(HitId.Turtle, sprTurtleIdle, "TURTLE")
    scrDeathCauseDefine(HitId.VenusGrunt, sprMolefishIdle, "VENUS GRUNT")
    scrDeathCauseDefine(HitId.VenusSarge, sprMolesargeIdle, "VENUS SARGE")
    scrDeathCauseDefine(HitId.Fireballer, sprFireBallerIdle, "FIREBALLER")
    scrDeathCauseDefine(HitId.SuperFireballer, sprSuperFireBallerIdle, "SUPER FIREBALLER")
    scrDeathCauseDefine(HitId.Jock, sprJockIdle, "JOCK")
    scrDeathCauseDefine(HitId.CursedSpider, sprInvSpiderIdle, "CURSED SPIDER")
    scrDeathCauseDefine(HitId.CursedCrystal, sprInvLaserCrystalIdle, "CURSED CRYSTAL")
    scrDeathCauseDefine(HitId.Mimic, sprMimicFire, "MIMIC")
    scrDeathCauseDefine(HitId.HpMimic, sprSuperMimicFire, "HP MIMIC")
    scrDeathCauseDefine(HitId.Grunt, sprGruntIdle, "GRUNT")
    scrDeathCauseDefine(HitId.Inspector, sprInspectorIdle, "INSPECTOR")
    scrDeathCauseDefine(HitId.Shielder, sprShielderIdle, "SHIELDER")
    scrDeathCauseDefine(HitId.CrownGuardian, sprCrownGuardianIdle, "CROWN GUARDIAN")
    scrDeathCauseDefine(HitId.Explosion, sprExplosion, "EXPLOSION")
    scrDeathCauseDefine(HitId.SmallExplosion, sprSmallExplosion, "SMALL EXPLOSION")
    scrDeathCauseDefine(HitId.FireTrap, sprTrapGameover, "FIRE TRAP")
    scrDeathCauseDefine(HitId.Shield, sprShielderShieldAppear, "SHIELD")
    scrDeathCauseDefine(HitId.Toxin, sprToxicGas, "TOXIN")
    scrDeathCauseDefine(HitId.Horror, sprEnemyHorrorIdle, "HORROR")
    scrDeathCauseDefine(HitId.Barrel, sprBarrel, "BARREL")
    scrDeathCauseDefine(HitId.ToxicBarrel, sprToxicBarrel, "TOXIC BARREL")
    scrDeathCauseDefine(HitId.GoldenBarrel, sprGoldBarrel, "GOLDEN BARREL")
    scrDeathCauseDefine(HitId.Car, sprCarIdle, "CAR")
    scrDeathCauseDefine(HitId.VenusCar, sprVenusCar, "VENUS CAR")
    scrDeathCauseDefine(HitId.VenusCarFixed, sprVenusCarFixed, "VENUS CAR FIXED")
    scrDeathCauseDefine(HitId.VenusCar2, sprVenuzCar2, "VENUS CAR 2")
    scrDeathCauseDefine(HitId.IcyCar, sprFrozenCar, "ICY CAR")
    scrDeathCauseDefine(HitId.ThrownCar, sprFrozenCarThrown, "THROWN CAR")
    scrDeathCauseDefine(HitId.Mine, sprWaterMine, "MINE")
    scrDeathCauseDefine(HitId.CrownOfDeath, sprCrown2Idle, "CROWN OF DEATH")
    scrDeathCauseDefine(HitId.RogueStrike, sprRogueStrike, "ROGUE STRIKE")
    scrDeathCauseDefine(HitId.BloodLauncher, sprBloodNader, "BLOOD LAUNCHER")
    scrDeathCauseDefine(HitId.BloodCannon, sprBloodCannon, "BLOOD CANNON")
    scrDeathCauseDefine(HitId.BloodHammer, sprBloodHammer, "BLOOD HAMMER")
    scrDeathCauseDefine(HitId.Disc, sprDisc, "DISC")
    scrDeathCauseDefine(HitId.CurseEat, sprCurse, "CURSE EAT")
    scrDeathCauseDefine(HitId.BigDogMissile, sprScrapBossMissileIdle, "BIG DOG MISSILE")
    scrDeathCauseDefine(HitId.HalloweenBandit, sprSpookyBanditIdle, "HALLOWEEN BANDIT")
    scrDeathCauseDefine(HitId.LilHunterFly, sprLilHunterLift, "LIL HUNTER FLY")
    scrDeathCauseDefine(HitId.ThroneDeath, sprNothingDeath, "THRONE DEATH")
    scrDeathCauseDefine(HitId.JungleBandit, sprJungleBanditIdle, "JUNGLE BANDIT")
    scrDeathCauseDefine(HitId.JungleAssassin, sprJungleAssassinIdle, "JUNGLE ASSASSIN")
    scrDeathCauseDefine(HitId.JungleFly, sprJungleFlyIdle, "JUNGLE FLY")
    scrDeathCauseDefine(HitId.CrownOfHatred, sprCrown6Idle, "CROWN OF HATRED")
    scrDeathCauseDefine(HitId.IceFlower, sprIceFlowerIdle, "ICE FLOWER")
    scrDeathCauseDefine(HitId.CursedAmmoPickup, sprCursedAmmo, "CURSED AMMO PICKUP")
    scrDeathCauseDefine(HitId.UnderwaterLightning, sprLightningDeath, "UNDERWATER LIGHTNING")
    scrDeathCauseDefine(HitId.EliteGrunt, sprEliteGruntIdle, "ELITE GRUNT")
    scrDeathCauseDefine(HitId.BloodGamble, sprKillsIcon, "BLOOD GAMBLE")
    scrDeathCauseDefine(HitId.EliteShielder, sprEliteShielderIdle, "ELITE SHIELDER")
    scrDeathCauseDefine(HitId.EliteShielderShield, sprEliteShielderShieldAppear, "ELITE SHIELDER SHIELD")
    scrDeathCauseDefine(HitId.EliteInspector, sprEliteInspectorIdle, "ELITE INSPECTOR")
    scrDeathCauseDefine(HitId.Captain, sprLastIdle, "CAPTAIN")
    scrDeathCauseDefine(HitId.Van, sprVanDrive, "VAN")
    scrDeathCauseDefine(HitId.BuffAlligator, sprBuffGatorIdle, "BUFF ALLIGATOR")
    scrDeathCauseDefine(HitId.Generator, sprBigGenerator, "GENERATOR")
    scrDeathCauseDefine(HitId.LightningCrystal, sprLightningCrystalIdle, "LIGHTNING CRYSTAL")
    scrDeathCauseDefine(HitId.GoldenSnowTank, sprGoldTankIdle, "GOLDEN SNOWTANK")
    scrDeathCauseDefine(HitId.GreenExplosion, sprGreenExplosion, "GREEN EXPLOSION")
    scrDeathCauseDefine(HitId.SmallGenerator, sprSmallGenerator, "SMALL GENERATOR")
    scrDeathCauseDefine(HitId.GoldenDisc, sprGoldDisc, "GOLDEN DISC")
    scrDeathCauseDefine(HitId.BigDogExplosion, sprBigDogExplode, "BIG DOG EXPLOSION")
    scrDeathCauseDefine(HitId.PopoFreak, sprPopoFreakIdle, "POPO FREAK")
    scrDeathCauseDefine(HitId.Throne2Death, sprNothing2Death, "THRONE II DEATH")
    scrDeathCauseDefine(HitId.OasisBoss, sprBigFishIdle, "OASIS BOSS")
    scrDeathCauseDefine(HitId.PopoExplosion, sprPopoExplo, "I.D.P.D. EXPLOSION")
    scrDeathCauseDefine(HitId.Player, sprMutant1Idle, "PLAYER")
    scrDeathCauseDefine(HitId.PlayerRevive, sprMutant1Hurt, "REVIVE")
    scrDeathCauseDefine(HitId.WeaponMimic, sprWepMimicFire, "WEAPON MIMIC")
    scrDeathCauseDefine(HitId.GunGod, sprYVBossIdle, "GUN GOD")
}

/// @function scrDeathCauseDefine
/// @param {Enum.HitId} id
/// @param name
/// @param sprite=mskNone
function scrDeathCauseDefine(_id, _sprite, _name) {
	deathcause_types[_id] = [ _sprite, _name ]
}

/// @function scrDeathCauseGetSprite
/// @param {Real|Array} hit_id
function scrDeathCauseGetSprite(_cause) {
	if (is_array(_cause)) {
		return array_first(_cause)
	}
	if (scr_death_cause_is_valid(_cause)) {
		return deathcause_types[_cause][0]
	}
	return undefined
}

/// @function scrDeathCauseGetName
/// @param {Real|Array} hit_id
function scrDeathCauseGetName(_cause) {
	if (is_array(_cause)) {
		return array_last(_cause)
	}
	if (scr_death_cause_is_valid(_cause)) {
		return deathcause_types[_cause][1]
	}
	return undefined
}

function scr_death_cause_is_valid(_cause) {
	gml_pragma("forceinline")
	return is_array(_cause) || (is_numeric(_cause) && _cause > 0 && _cause < HitId.NUM_HIT_IDS)
}