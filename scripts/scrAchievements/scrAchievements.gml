globalvar achievementmax, chiev_name, chiev_text, chiev_hide, chiev_type;

enum Achievement {
	 // Chars
	MELTING_UNLOCKED = 0,
	EYES_UNLOCKED = 1,
	PLANT_UNLOCKED = 2,
	Y_V_UNLOCKED = 3,
	STEROIDS_UNLOCKED = 4,
	ROBOT_UNLOCKED = 5,
	CHICKEN_UNLOCKED = 6,
	REBEL_UNLOCKED = 7,
	HORROR_UNLOCKED = 8,
	ROGUE_UNLOCKED = 9,
	
	 // Skins
	FISH_BSKIN = 10,
	CRYSTAL_BSKIN = 11,
	MELTING_BSKIN = 12,
	EYES_BSKIN = 13,
	PLANT_BSKIN = 14,
	Y_V_BSKIN = 15,
	STEROIDS_BSKIN = 16,
	ROBOT_BSKIN = 17,
	CHICKEN_BSKIN = 18,
	REBEL_BSKIN = 19,
	HORROR_BSKIN = 20,
	ROGUE_BSKIN = 21,
	
	 // Progress activities
	CROWN_LIFE = 22,
	ULTRA_TIME = 23,
	GOOD_FIND = 24,
	GOOD_RIDDANCE = 25,
	NOT_BAD = 26,
	UNSTOPPABLE = 27,
	FROG_ZONE = 28,
	IMPOSSIBLE = 29,
	SINCERE_APPOLOGIES = 30,
	
	 // Bosses
	BOSS_BIGBANDIT = 31,
	BOSS_BIGDOG = 32,
	BOSS_LILHUNTER = 33,
	BOSS_THRONE = 34,
	BOSS_THRONE2 = 35,
	BOSS_MOM = 36,
	BOSS_HYPERCRYSTAL = 37,
	BOSS_TECHNOMANCER = 38,
	
	 // Gaming
	VAULT_RAIDER = 39,
	GO_HARD = 40,
	GAME_LOOPED = 41,
	BOSS_CAPTAIN = 42,
	ULTRA_MUTANT = 43,
	
	 // U100
	CUZ_UNLOCKED = 44,
	CUZ_BSKIN = 45,
	FISH_CSKIN = 46,
	CRYSTAL_CSKIN = 47,
	EYES_CSKIN = 48,
	MELTING_CSKIN = 49,
	PLANT_CSKIN = 50,
	Y_V_CSKIN = 51,
	STEROIDS_CSKIN = 52,
	ROBOT_CSKIN = 53,
	CHICKEN_CSKIN = 54,
	REBEL_CSKIN = 55,
	HORROR_CSKIN = 56,
	ROGUE_CSKIN = 57,
	CUZ_CSKIN = 58,
}

/// @function scrAchievementCreate
/// @param {Enum.Achievement} id
/// @param is_hidden
/// @param type
/// @param name
/// @param text
function scrAchievementCreate(_id, _is_hidden, _type, _name, _text) {
	chiev_name[_id] = string_upper(string(_name))
	chiev_text[_id] = string_upper(string(_text))
	chiev_hide[_id] = _is_hidden
	chiev_type[_id] = _type
}

function scrAchievements() {
	scrAchievementCreate(Achievement.MELTING_UNLOCKED,   false,   0, "Melting Unlocked",        "Die")
	scrAchievementCreate(Achievement.EYES_UNLOCKED,      false,   0, "Eyes Unlocked",           "Reach 2-1")
	scrAchievementCreate(Achievement.PLANT_UNLOCKED,     false,   0, "Plant Unlocked",          "Reach 3-1")
	scrAchievementCreate(Achievement.Y_V_UNLOCKED,       false,   0, "Y.V. Unlocked",           "Reach 3-?")
	scrAchievementCreate(Achievement.STEROIDS_UNLOCKED,  false,   0, "Steroids Unlocked",       "Reach 6-1")
	scrAchievementCreate(Achievement.ROBOT_UNLOCKED,     false,   0, "Robot Unlocked",          "Reach 5-1")
	scrAchievementCreate(Achievement.CHICKEN_UNLOCKED,   false,   0, "Chicken Unlocked",        "Reach 5-?")
	scrAchievementCreate(Achievement.REBEL_UNLOCKED,     true,    0, "Rebel Unlocked",          "Loop past\nthe Nuclear Throne")
	scrAchievementCreate(Achievement.HORROR_UNLOCKED,    true,    0, "Horror Unlocked",         "Defeat Horror")
	scrAchievementCreate(Achievement.ROGUE_UNLOCKED,     false,   0, "Rogue Unlocked",          "Reach the Nuclear Throne")
	scrAchievementCreate(Achievement.FISH_BSKIN,         true,    0, "Fish Can Roll",           "Loop as every character")
	scrAchievementCreate(Achievement.CRYSTAL_BSKIN,      false,   0, "Crystal Can Shield",      "Reach 4-? as Crystal")
	scrAchievementCreate(Achievement.MELTING_BSKIN,      false,   0, "Everything Hurts",        "As Melting, Reach the Nuclear Throne\nwithout Rhino Skin and Strong Spirit")
	scrAchievementCreate(Achievement.PLANT_BSKIN,        false,   0, "MMMMMMHMMM!",             "Reach 2-? as Eyes")
	scrAchievementCreate(Achievement.EYES_BSKIN,         false,   0, "Blood Blood Blood",       "Reach the Nuclear Throne\nin under 10 minutes as Plant")
	scrAchievementCreate(Achievement.Y_V_BSKIN,          false,   0, "Verified",                "Unlock a Golden Weapon\nfor every character")
	scrAchievementCreate(Achievement.STEROIDS_BSKIN,     true,    0, "Science",                 "Defeat the Technomancer as Steroids")
	scrAchievementCreate(Achievement.ROBOT_BSKIN,        true,    0, "6e 69 63 65",             "Eat a Hyper Weapon as Robot")
	scrAchievementCreate(Achievement.CHICKEN_BSKIN,      true,    0, "Way Of The Chicken",      "Reach 2-1 on Hard Mode as Chicken")
	scrAchievementCreate(Achievement.REBEL_BSKIN,        true,    0, "Forget The Old Days",     "Defeat Mom as Rebel")
	scrAchievementCreate(Achievement.HORROR_BSKIN,       true,    0, "Thriller",                "Defeat Hyper Crystal as Horror")
	scrAchievementCreate(Achievement.ROGUE_BSKIN,        true,    0, "Never Look Back",         "Defeat Captain as Rogue")
	scrAchievementCreate(Achievement.CROWN_LIFE,         false,   0, "Crown Life",              "Unlock a Crown as any character")
	scrAchievementCreate(Achievement.ULTRA_TIME,         false,   0, "Ultra Time",              "Reach Level Ultra as any character")
	scrAchievementCreate(Achievement.GOOD_FIND,          false,   0, "Good Find",               "Unlock a Golden Weapon\nas any character")
	scrAchievementCreate(Achievement.GOOD_RIDDANCE,      true,    0, "Good Riddance",           "Unlock a Golden Disc Gun\nor Golden Nuke Launcher")
	scrAchievementCreate(Achievement.UNSTOPPABLE,        true,    0, "Unstoppable",             "Reach Level Ultra as Skeleton")
	scrAchievementCreate(Achievement.FROG_ZONE,          true,    0, "Frog Zone",               "Play as Frog")
	scrAchievementCreate(Achievement.IMPOSSIBLE,         true,    0, "Impossible",              "Sit on the Nuclear Throne\nas headless Chicken")
	scrAchievementCreate(Achievement.SINCERE_APPOLOGIES, true,    0, "Sincere Apologies",       "Kill yourself with a Disc Gun")
	scrAchievementCreate(Achievement.BOSS_BIGBANDIT,     false,   1, "Bandit Stopper",          "Defeat Big Bandit")
	scrAchievementCreate(Achievement.BOSS_BIGDOG,        false,   1, "Dog Owner",               "Defeat Big Dog")
	scrAchievementCreate(Achievement.BOSS_LILHUNTER,     false,   1, "Hunter Killer",           "Defeat Lil Hunter")
	scrAchievementCreate(Achievement.BOSS_THRONE,        true,    1, "Throne Sitter",           "Defeat the Nuclear Throne")
	scrAchievementCreate(Achievement.BOSS_THRONE2,       true,    1, "Advanced Sitter",         "Defeat Throne II")
	scrAchievementCreate(Achievement.BOSS_MOM,           true,    1, "Frog Slayer",             "Defeat Mom")
	scrAchievementCreate(Achievement.BOSS_HYPERCRYSTAL,  true,    1, "Crystal Smasher",         "Defeat Hyper Crystal")
	scrAchievementCreate(Achievement.BOSS_TECHNOMANCER,  true,    1, "Techno Killer",           "Defeat Technomancer")
	scrAchievementCreate(Achievement.VAULT_RAIDER,       false,   1, "Vault Raider",            "Unlock all Crowns\nas any character")
	scrAchievementCreate(Achievement.GO_HARD,            true,    1, "Go Hard",                 "Unlock Hard Mode")
	scrAchievementCreate(Achievement.NOT_BAD,            false,   2, "Not Bad",                 "Reach 7-3 in Daily Run")
	scrAchievementCreate(Achievement.GAME_LOOPED,        false,   2, "The Struggle Continues",  "Loop the game")
	scrAchievementCreate(Achievement.BOSS_CAPTAIN,       true,    2, "The Struggle Is Over",    "Defeat Captain")
	scrAchievementCreate(Achievement.ULTRA_MUTANT,       false,   2, "Ultra Mutant",            "Get 100% of the unlocks")
	scrAchievementCreate(Achievement.CUZ_UNLOCKED,       false,   0, "Gunz God",                "Reach Y.V.'s Mansion.")
	scrAchievementCreate(Achievement.CUZ_BSKIN,          true,    0, "Round And Handsome",      "Carry 3 Golden Weapons as Cuz.")
	scrAchievementCreate(Achievement.FISH_CSKIN,         true,    0, "Retirement",              "Unlock all B-skins.")
	scrAchievementCreate(Achievement.CRYSTAL_CSKIN,      true,    0, "Crystal Can Handle This", "Survive over 100 damage as Crystal.")
	scrAchievementCreate(Achievement.EYES_CSKIN,         true,    0, "HHMMMM!",                 "Reach the Nuclear Throne\nwithout firing a shot as Eyes.")
	scrAchievementCreate(Achievement.MELTING_CSKIN,      true,    0, "Molten",                  "Have 12 mutations as Melting.")
	scrAchievementCreate(Achievement.PLANT_CSKIN,        true,    0, "KILL KILL KILL",          "BLOOD BLOOD BLOOD.")
	scrAchievementCreate(Achievement.Y_V_CSKIN,          true,    0, "Thanks Gun God",          "Defeat a Gun God.")
	scrAchievementCreate(Achievement.STEROIDS_CSKIN,     true,    0, "Appreciate Revolvers",    "Reach the Nuclear Throne\nwithout picking up any weapons\nas Steroids.")
	scrAchievementCreate(Achievement.ROBOT_CSKIN,        true,    0, "63 72 75 6e 63 68 79",    "Eat the Rusty Revolver as Robot.")
	scrAchievementCreate(Achievement.CHICKEN_CSKIN,      true,    0, "Amateur Hour Is Over",    "Defeat every boss\nwith the Black Sword.")
	scrAchievementCreate(Achievement.REBEL_CSKIN,        true,    0, "Biggest Bandit",          "Defeat 1000 bandits in total.")
	scrAchievementCreate(Achievement.HORROR_CSKIN,       true,    0, "Drama",                   "Reach the I.D.P.D. Headquarters\nwith 3 or less mutations as Horror.")
	scrAchievementCreate(Achievement.ROGUE_CSKIN,        true,    0, "Forgiveness",             "Don’t defeat Lil Hunter as Rogue.")
	scrAchievementCreate(Achievement.CUZ_CSKIN,          true,    0, "Strapped",                "Carry 6 cursed weapons as Cuz.")
	
	achievementmax = array_length(chiev_name) - 1
	
	if scrAchievementIsUnlocked(Achievement.BOSS_THRONE) {
		var _turn_visible = [
				Achievement.REBEL_UNLOCKED,
				Achievement.FISH_BSKIN,
				Achievement.STEROIDS_BSKIN,
				Achievement.ROBOT_BSKIN,
				Achievement.CHICKEN_BSKIN,
				Achievement.REBEL_BSKIN,
				Achievement.HORROR_BSKIN,
				Achievement.ROGUE_BSKIN,
				Achievement.BOSS_MOM,
				Achievement.BOSS_HYPERCRYSTAL,
				Achievement.BOSS_TECHNOMANCER,
				Achievement.GO_HARD
			]
		
		var _all_chars = true
		
		for(var _race_id = Race.Fish; _race_id < Race.NUM_ALL_RACE_TYPES; ++_race_id) {
			if !scr_race_is_unlocked(_race_id) && !scrRaceIsHidden(_race_id) {
				_all_chars = false
				break
			}
		}
		
		if _all_chars {
			array_push(_turn_visible, Achievement.UNSTOPPABLE, Achievement.FROG_ZONE)
		}
		
		if UberCont.hardgot {
			array_push(_turn_visible, Achievement.GOOD_RIDDANCE)
		}
		
		var _count = array_length(_turn_visible)
		for(var i = 0; i < _count; ++i) {
			chiev_hide[_turn_visible[i]] = 0
		}
	}
}

/// @function scrRaceGetUnlockAchievement
/// @param {Real|Enum.RaceType} race_id
function scrRaceGetUnlockAchievement(_race) {
	switch _race {
        case Race.Eyes: return Achievement.EYES_UNLOCKED
        case Race.Melting: return Achievement.MELTING_UNLOCKED
        case Race.Plant: return Achievement.PLANT_UNLOCKED
        case Race.Venuz: return Achievement.Y_V_UNLOCKED
        case Race.Steroids: return Achievement.STEROIDS_UNLOCKED
        case Race.Robot: return Achievement.ROBOT_UNLOCKED
        case Race.Chicken: return Achievement.CHICKEN_UNLOCKED
        case Race.Rebel: return Achievement.REBEL_UNLOCKED
        case Race.Horror: return Achievement.HORROR_UNLOCKED
        case Race.Rogue: return Achievement.ROGUE_UNLOCKED
        case Race.Skeleton: return Achievement.UNSTOPPABLE
        case Race.Frog: return Achievement.FROG_ZONE
        case Race.Cuz: return Achievement.CUZ_UNLOCKED
    }
	
	return -1
}

/// @function scrRaceGetSkinUnlockAchievement
/// @param {Real|Enum.RaceType} race_id
/// @param {Real|Enum.SkinLetter} skin_id
function scrRaceGetSkinUnlockAchievement(_race, _skin_id) {
	switch _skin_id {
	    case SkinLetter.B:
			switch _race {
		        case Race.Fish: return Achievement.FISH_BSKIN
		        case Race.Crystal: return Achievement.CRYSTAL_BSKIN
		        case Race.Eyes: return Achievement.EYES_BSKIN
		        case Race.Melting: return Achievement.MELTING_BSKIN
		        case Race.Plant: return Achievement.PLANT_BSKIN
		        case Race.Venuz: return Achievement.Y_V_BSKIN
		        case Race.Steroids: return Achievement.STEROIDS_BSKIN
		        case Race.Robot: return Achievement.ROBOT_BSKIN
		        case Race.Chicken: return Achievement.CHICKEN_BSKIN
		        case Race.Rebel: return Achievement.REBEL_BSKIN
		        case Race.Horror: return Achievement.HORROR_BSKIN
		        case Race.Rogue: return Achievement.ROGUE_BSKIN
		        case Race.Cuz: return Achievement.CUZ_BSKIN
		    }
			break
	    case SkinLetter.C:
			switch _race {
		        case Race.Fish: return Achievement.FISH_CSKIN
		        case Race.Crystal: return Achievement.CRYSTAL_CSKIN
		        case Race.Eyes: return Achievement.EYES_CSKIN
		        case Race.Melting: return Achievement.MELTING_CSKIN
		        case Race.Plant: return Achievement.PLANT_CSKIN
		        case Race.Venuz: return Achievement.Y_V_CSKIN
		        case Race.Steroids: return Achievement.STEROIDS_CSKIN
		        case Race.Robot: return Achievement.ROBOT_CSKIN
		        case Race.Chicken: return Achievement.CHICKEN_CSKIN
		        case Race.Rebel: return Achievement.REBEL_CSKIN
		        case Race.Horror: return Achievement.HORROR_CSKIN
		        case Race.Rogue: return Achievement.ROGUE_CSKIN
		        case Race.Cuz: return Achievement.CUZ_CSKIN
		    }
			break
	}
	
	return -1
}