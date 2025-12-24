
enum UltraSkill {
	// Ultra A
	GunBond = 1,
	Confiscate = 1,
	Fortress = 1,
	ProjectileStyle = 1,
	BrainCapacity = 1,
	Trapper = 1,
	ImaGunGod = 1,
	Ambidextrous = 1,
	RefinedTaste = 1,
	HarderToKill = 1,
	PersonalGuard = 1,
	Stalker = 1,
	SuperPortalStrike = 1,
	UltraSpin = 1,
	Redemption = 1,
	Distance = 1,
	Arsenal = 1,

	// Ultra B
	BloodBond = 2,
	GunWarrant = 2,
	Juggernaut = 2,
	MonsterStyle = 2,
	Detachment = 2,
	Killer = 2,
	Back2Bizniz = 2,
	GetLoaded = 2,
	Regurgitate = 2,
	Determination = 2,
	Riot = 2,
	Anomaly = 2,
	SuperBlastArmor = 2,
	UltraMissiles = 2,
	Damnation = 2,
	Intimacy = 2,
	Emotional = 2,

	// Ultra C
	Meltdown = 3
}

globalvar ultr_name, ultr_text, ultr_msnd;

function scrUltras() {
    //COOP
    ultr_name[0, 1] = "GUN BOND"
    ultr_text[0, 1] = "SHARED @yAMMO@s PICKUPS"
    ultr_msnd[0, 1] = sndCoopUltraA
    
    ultr_name[0, 2] = "BLOOD BOND"
    ultr_text[0, 2] = "SHARED @rHP@s PICKUPS"
    ultr_msnd[0, 2] = sndCoopUltraB
    
    //FISH
    ultr_name[1, 1] = "CONFISCATE"
    ultr_text[1, 1] = "ENEMIES SOMETIMES DROP CHESTS"
    ultr_msnd[1, 1] = sndFishUltraA
    
    ultr_name[1, 2] = "GUN WARRANT"
    ultr_text[1, 2] = "INFINITE AMMO THE FIRST 7 SECONDS#AFTER EXITING A @pPORTAL"
    ultr_msnd[1, 2] = sndFishUltraB
    
    //CRYSTAL
    ultr_name[2, 1] = "FORTRESS"
    ultr_text[2, 1] = "+6 MAX HP"
    ultr_msnd[2, 1] = sndCrystalUltraA
    
    ultr_name[2, 2] = "JUGGERNAUT"
    ultr_text[2, 2] = "MOVE WHEN SHIELDING"
    ultr_msnd[2, 2] = sndCrystalUltraB
    
    //EYES
    ultr_name[3, 1] = "PROJECTILE STYLE"
    ultr_text[3, 1] = "TELEKINESIS HOLDS YOUR PROJECTILES"
    ultr_msnd[3, 1] = sndEyesUltraA
    
    ultr_name[3, 2] = "MONSTER STYLE"
    ultr_text[3, 2] = "PUSH NEARBY ENEMIES AWAY#WHEN NOT USING TELEKINESIS"
    ultr_msnd[3, 2] = sndEyesUltraB
    
    //MELTING
    ultr_name[4, 1] = "BRAIN CAPACITY"
    ultr_text[4, 1] = "BLOW UP LOW HP ENEMIES"
    ultr_msnd[4, 1] = sndMeltingUltraA
    
    ultr_name[4, 2] = "DETACHMENT"
    ultr_text[4, 2] = "3 MORE MUTATIONS#LOSE HALF OF YOUR HP"
    ultr_msnd[4, 2] = sndMeltingUltraB
    
    //PLANT
    ultr_name[5, 1] = "TRAPPER"
    ultr_text[5, 1] = "BIG SNARE"
    ultr_msnd[5, 1] = sndPlantUltraA
    
    ultr_name[5, 2] = "KILLER"
    ultr_text[5, 2] = "KILLING SNARED ENEMY SPAWN SAPLINGS"
    ultr_msnd[5, 2] = sndPlantUltraB
    
    //Y.V.
    ultr_name[6, 1] = "IMA GUN GOD"
    ultr_text[6, 1] = "HIGHER RATE OF FIRE"
    ultr_msnd[6, 1] = sndYVUltraA
    
    ultr_name[6, 2] = "BACK 2 BIZNIZ"
    ultr_text[6, 2] = "FREE POP POP UPGRADE"
    ultr_msnd[6, 2] = sndYVUltraB
    
    //Steroids
    ultr_name[7, 1] = "AMBIDEXTROUS"
    ultr_text[7, 1] = "DOUBLE WEAPONS FROM CHESTS"
    ultr_msnd[7, 1] = sndSteroidsUltraA
    
    ultr_name[7, 2] = "GET LOADED"
    ultr_text[7, 2] = "AMMO CHESTS CONTAIN ALL AMMO TYPES"
    ultr_msnd[7, 2] = sndSteroidsUltraB
    
    //Robot
    ultr_name[8, 1] = "REFINED TASTE"
    ultr_text[8, 1] = "HIGH TIER WEAPONS ONLY#AUTO EAT WEAPONS LEFT BEHIND"
    ultr_msnd[8, 1] = sndRobotUltraA
    
    ultr_name[8, 2] = "REGURGITATE"
    ultr_text[8, 2] = "EATING WEAPONS CAN DROP CHESTS#AUTO EAT WEAPONS LEFT BEHIND"
    ultr_msnd[8, 2] = sndRobotUltraB
    
    //Chicken
    ultr_name[9, 1] = "HARDER TO KILL"
    ultr_text[9, 1] = "KILLS EXTEND BLEED TIME"
    ultr_msnd[9, 1] = sndChickenUltraA
    
    ultr_name[9, 2] = "DETERMINATION"
    ultr_text[9, 2] = "THROWN WEAPONS CAN TELEPORT BACK#TO YOUR SECONDARY SLOT"
    ultr_msnd[9, 2] = sndChickenUltraB
    
    //Rebel
    ultr_name[10, 1] = "PERSONAL GUARD"
    ultr_text[10, 1] = "START A LEVEL WITH 2 ALLIES#ALL ALLIES HAVE MORE HP"
    ultr_msnd[10, 1] = sndRebelUltraA
    
    ultr_name[10, 2] = "RIOT"
    ultr_text[10, 2] = "DOUBLE ALLY SPAWNS"
    ultr_msnd[10, 2] = sndRebelUltraB
    
    //Horror
    ultr_name[11, 1] = "STALKER"
    ultr_text[11, 1] = "ENEMIES EXPLODE IN RADIATION ON DEATH"
    ultr_msnd[11, 1] = sndHorrorUltraA
    
    ultr_name[11, 2] = "ANOMALY"
    ultr_text[11, 2] = "@pPORTAL@s APPEAR EARLIER"
    ultr_msnd[11, 2] = sndHorrorUltraB
    
    ultr_name[11, 3] = "MELTDOWN"
    ultr_text[11, 3] = "DOUBLE @gRAD@s CAPACITY"
    ultr_msnd[11, 3] = sndHorrorUltraC
    
    //Rogue
    ultr_name[12, 1] = "SUPER PORTAL STRIKE"
    ultr_text[12, 1] = "DOUBLE PORTAL STRIKE PICKUPS#AND CAPACITY"
    ultr_msnd[12, 1] = sndRogueUltraA
    
    ultr_name[12, 2] = "SUPER BLAST ARMOR"
    ultr_text[12, 2] = "SUPER BLAST ARMOR"
    ultr_msnd[12, 2] = sndRogueUltraB
    
    //Big Dog
    ultr_name[13, 1] = "ULTRA SPIN"
    ultr_text[13, 1] = "@wIMPROVED SPIN ATTACK"
    ultr_msnd[13, 1] = sndBigDogTaunt
    
    ultr_name[13, 2] = "ULTRA MISSILES"
    ultr_text[13, 2] = "@wROCKETS SHOOT BULLETS"
    ultr_msnd[13, 2] = sndBigDogTaunt
    
    //Skeleton
    ultr_name[14, 2] = "DAMNATION"
    ultr_text[14, 2] = "FAST RECHARGE AFTER#USING BLOOD GAMBLE"
    ultr_msnd[14, 2] = sndSkeletonUltraB
    
    //Skeleton
    ultr_name[14, 1] = "REDEMPTION"
    ultr_text[14, 1] = "BACK IN THE FLESH"
    ultr_msnd[14, 1] = sndSkeletonUltraA
    
    ultr_name[14, 2] = "DAMNATION"
    ultr_text[14, 2] = "FAST RECHARGE AFTER#USING BLOOD GAMBLE"
    ultr_msnd[14, 2] = sndSkeletonUltraB
    
    //Frog
    ultr_name[15, 1] = "DISTANCE"
    ultr_text[15, 1] = "@gRADIATION@s CREATES TOXIC GAS"
    ultr_msnd[15, 1] = sndFrogUltraA
    
    ultr_name[15, 2] = "INTIMACY"
    ultr_text[15, 2] = "CONTINUOUSLY SPREAD TOXIC GAS"
    ultr_msnd[15, 2] = sndFrogUltraB
	
    //Cuz
    ultr_name[16, 1] = "ARSENAL"
    ultr_text[16, 1] = "TWICE AS MANY GUNS"
    ultr_msnd[16, 1] = sndCuzUltraA
    
    ultr_name[16, 2] = "EMOTIONAL"
    ultr_text[16, 2] = "TWICE AS MANY @bTEARS@w"
    ultr_msnd[16, 2] = sndCuzUltraB
}

function scrUltrasReset() {
	with (GameCont) {
		ultra_hud = []
		ultra_got = array_create(Race.NUM_ALL_RACE_TYPES)
		for(var i = 0; i < Race.NUM_ALL_RACE_TYPES; ++i) {
			ultra_got[i] = array_create(4, 0)
		}
	}
}

/// @function scr_ultra_set
/// @param {Real|Enum.Race} race
/// @param {Real|Enum.UltraSkill} ultra
/// @param {Real} value
function scr_ultra_set(_race, _ultra, _value) {
	with (GameCont) {
		var _previous = scr_ultra_get(_race, _ultra)
		if (_previous == _value) exit
		
		var _is_removed = false,
			_image_index = (_race * 3 + _ultra - 1)
		
		if _value {
			if (_previous && _value > _previous) scr_ultra_set(_race, _ultra, 0)
			
			ultra_got[_race, _ultra] = _value
			
			if (!array_contains(ultra_hud, _image_index)) {
				array_push(ultra_hud, _image_index)
			}
		}
		else {
			ultra_got[_race, _ultra] = _value
			var _index = array_get_index(ultra_hud, _image_index)
			if (_index >= 0) array_delete(ultra_hud, _index, 1)
			if (!_previous) exit
			_is_removed = true
		}
		
		var _effect = _value - _previous
		
		with Player {
			if _race == Race.Crystal && _ultra == UltraSkill.Fortress {
				hp += 6 * _effect
				max_hp += 6 * _effect
				if (!hp) hp = 1
				if (!max_hp) max_hp = 1
				lsthealth = hp
			}
			
			if race == Race.Rogue && _ultra == UltraSkill.SuperPortalStrike {
				rogue_ammo_max += 3 * _effect
			}
			
			if race == Race.Cuz {
				if (_ultra == UltraSkill.Arsenal) max_extra_weps += 3 * _effect
				if (_ultra == UltraSkill.Emotional) scrPlayerUpdateCuzAmmo()
			}
		}
		
		if _race == Race.Frog {
			with (Player) cantoxic = false
		}
		else if _race == Race.Melting && _ultra == UltraSkill.Detachment {
			with (Player) if (_race == Race.Melting) {
				if (!_is_removed) {
					GameCont.skillpoints += _effect
					max_hp = ceil(max_hp / 2)
					hp = max(1, max_hp)
				}
				else max_hp *= _value
				
				lsthealth = hp
			}
			
			if (!_is_removed) GameCont.skillpoints += 2 * _value
		}
		else if !_is_removed && _race == Race.Skeleton && _ultra == UltraSkill.Redemption {
			with GameCont {
				ds_list_clear(skills)
				wasskeleton = true
				skillpoints = 8
				ultrapoints = 1
				level = 10
				rad = 0
			}
			
			with (Player) if (_race == Race.Skeleton) {
				scrPlayerRaceChange(Race.Melting, scr_loadout_race_get_skin(Race.Melting))
			}
		}
	}
}

/// @function scr_ultra_get
/// @param {Enum.Race|Real} race_id
/// @param {Enum.UltraSkill|Real} ultra_id
function scr_ultra_get(_race, _ultra) {
	gml_pragma("forceinline")
	return instance_exists(GameCont) ? GameCont.ultra_got[_race, _ultra] : 0
}

/// @function scr_player_ultra_get
/// @param player
/// @param {Real|Enum.Race} race_id
/// @param {Real|Enum.UltraSkill} ultra_id
function scr_player_ultra_get(_player, _race, _ultra) {
	gml_pragma("forceinline")
	return (instance_is(_player, Player) && _player.race == _race) ? GameCont.ultra_got[_race, _ultra] : 0
}

/// @function scr_ultra_get_from_race
/// @param {Real|Enum.Race} race
function scr_ultra_get_from_race(_race) {
	var _ultras = GameCont.ultra_got[_race], _count = array_length(_ultras)
	for(var i = 1; i < _count; ++i) if (_ultras[i]) return i
	return -1
}

function scrNeedMorePlayerUltras() {
	if (scr_ultra_get_from_race(Race.CoopUltra) != -1) return false
	
	for(var i = 0; i < player_count; ++i) {
		var _pinst = scr_playerinstance_find(i)
	
		if (is_struct(_pinst) && scr_ultra_get_from_race(_pinst.get_race()) == -1) {
			return true
		}
	}
	
	return false
}