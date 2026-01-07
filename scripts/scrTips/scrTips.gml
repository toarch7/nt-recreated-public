function scrTips() {
	static __load_user_tips = function(_pool, _key, _index) {
		repeat (2048) {
			if (!loc_exists("Tips", _key, ++_index)) break
			array_push(_pool, loc("Tips", _key, _index))
		}
		return _pool
	}
	
	var _tip_type = choose(0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7)
	if (!instance_exists(Player)) _tip_type = 0
	
	tip = ""
	
	var _player = instance_random(Player),
		_area = GameCont.area
	
	var L = LF("Tips")
	
	// General
	if (_tip_type == 0) {
		#region General tips pool
		var _pool = [
			L("General:1", "@rHP@s will only drop when damaged"),
			L("General:2", "@yexplosives@s can destroy walls"),
			L("General:3", "@wmelee weapons@s can deflect @yprojectiles@s"),
			L("General:4", "@rHP@s will only drop when damaged"),
			L("General:5", "@yexplosives@s can destroy walls"),
			L("General:6", "@wmelee weapons@s can deflect @yprojectiles@s"),
			L("General:7", "@yshells@s deal more damage from up close"),
			L("General:8", "assassins can pretend they're dead"),
			(UberCont.april_fools)
				? L("General:9:Alt", "fish can't roll")
				: L("General:9", "fish can roll"),
			L("General:10", "always keep one eye on your @yammo@s"),
			L("General:11", "robots can digest anything"),
			L("General:12", "bandits like camping near barrels"),
			L("General:13", "not today"),
			L("General:14", "rosebud"),
			L("General:15", "it's not fair, it's not right"),
			L("General:16", "watch out for dehydration"),
			L("General:17", "crystal can shield"),
			L("General:18", "fear is the mindkiller"),
			L("General:19", "going in big"),
			L("General:20", "it's happening"),
			L("General:21", "no"),
			L("General:22", "bob and weave"),
			L("General:23", "airhorn.wav"),
			L("General:24", "danger zone"),
			L("General:25", "the @wthrone@s is getting closer"),
			L("General:26", "what a life"),
			L("General:27", "remember to take a 15 minute break#for every hour you play!"),
			L("General:28", "so sweaty"),
			L("General:29", "just another @pportal@s"),
			L("General:30", "doing work"),
			L("General:31", "hold the phone"),
			L("General:32", "no shame"),
			L("General:33", "follow your heart"),
			L("General:34", "practice makes perfect"),
			L("General:35", "don't give up"),
			L("General:36", "the @bI.D.P.D.@s is looking for you"),
			L("General:37", "try hitting @ygrenades@s for extra range"),
			L("General:38", "pick your @gmutations@s wisely"),
			L("General:39", "if only you could talk to the monsters"),
			L("General:40", "@wsteroids@s can dual wield"),
			L("General:41", "always wear dry socks"),
			L("General:42", "@wcrowns@s are loyal"),
			L("General:43", "@yenergy weapons@s use lots of @yammo@y"),
			L("General:44", "the throne definitely exists"),
			L("General:45", "try not opening @wweapon chests@s"),
			L("General:46", "fire at things until they die"),
			L("General:47", "@yammo@s drops depend on your @wweapon types@s"),
			L("General:48", "don't get hit"),
			L("General:49", "you get fewer drops when high on @yammo@s"),
			L("General:50", "doing alright"),
			L("General:51", "there are other worlds out there")
		]
		#endregion
		__load_user_tips(_pool, "General", 51)
		
		if (scrGameIsDailyRun()) {
			array_push(_pool,
				L("Daily:1", "such a nice day"),
				L("Daily:2", "the weather isn't so bad"),
				L("Daily:3", "don't mess it up"),
				L("Daily:4", "one shot"),
				L("Daily:5", "there's always tomorrow"),
				L("Daily:6", "one day"))
			__load_user_tips(_pool, "Daily", 6)
		}
		
		if (scrGameIsHardmode()) {
			array_push(_pool,
				L("Hardmode:1", "heh"),
				L("Hardmode:2", "no way"),
				L("Hardmode:3", "impossible"),
				L("Hardmode:4", "behind you"),
				L("Hardmode:5", "take your time"),
				L("Hardmode:6", "..."),
				L("Hardmode:7", "it can't be that bad"),
				choose("", "", "", "", "", L("Hardmode:8", "what does SFMT stand for?")))
			__load_user_tips(_pool, "Hardmode", 7)
		}
		
		if (scrGameIsCustomMode()) {
			array_push(_pool, L("CustomMode", "TIME TO GRILL"))
			__load_user_tips(_pool, "CustomMode", 0)
		}
		
		if (scrGameIsDailyRun()) {
			array_push(_pool,
				L("Daily:1", "such a nice day"),
				L("Daily:2", "the weather isn't so bad"),
				L("Daily:3", "don't mess it up"),
				L("Daily:4", "one shot"),
				L("Daily:5", "there's always tomorrow"),
				L("Daily:6", "one day"))
			__load_user_tips(_pool, "Daily", 6)
		}
		
		if (scrGameIsWeeklyRun()) {
			array_push(_pool,
				L("Weekly:1", "this seems familiar"),
				L("Weekly:2", "what's next?"),
				L("Weekly:3", "free time"),
				L("Weekly:4", "well prepared"),
				L("Weekly:5", "keep trying"))
		}
		
		if (instance_exists(TutCont)) {
			array_push(_pool,
				L("Tutorial:1", "everything will be just fine"),
				L("Tutorial:2", "don't worry"),
				L("Tutorial:3", "the nuclear throne..."),
				L("Tutorial:4", "good luck"))
			__load_user_tips(_pool, "Tutorial", 4)
		}
		
		if (UberCont.coop) {
			var _player_count = instance_number(Player) + instance_number(Revive), _heads_tip;
			
			if (_player_count <= 4) {
				/**/ if (_player_count == 0) _heads_tip = L("Coop:7", "no heads")
				else if (_player_count == 1) _heads_tip = L("Coop:8", "one head")
				else if (_player_count == 2) _heads_tip = L("Coop:9", "two heads")
				else if (_player_count == 3) _heads_tip = L("Coop:10", "three heads")
				else if (_player_count == 4) _heads_tip = L("Coop:11", "four heads")
			}
			else _heads_tip = L("Coop:12", "many heads")
			
			array_push(_pool,
				L("Coop:1", "friendship"),
				L("Coop:2", "what a burden"),
				L("Coop:3", "shouting"),
				L("Coop:4", "be careful"),
				L("Coop:5", "help is here"),
				L("Coop:6", "but who gets the throne?"),
				_heads_tip)
			__load_user_tips(_pool, "Coop", 12)
		}
		
		if (scrGameIsContinuedRun()) {
			/// @loc:token [R:Tips] ContinuedRun "welcome back!"
			array_push(_pool, loc("R:Tips:ContinuedRun", "welcome back!"))
			__load_user_tips(_pool, "ContinuedRun", 0)
		}
		
		do {
			tip = array_random(_pool)
		}
		until (is_string(tip) && string_length(tip) != 0)
	}
	
	// Areas
	if (_tip_type == 1) {
		switch (_area) {
			case 0:
				tip = choose(
					L("Area:0:1", "it's so dark"),
				    L("Area:0:2", "your friends were here"),
				    L("Area:0:3", "this can't be true"),
				)
				break
			case 1:
				tip = choose(
					L("Area:1:1", "welcome to the future"),
				    L("Area:1:2", "the wasteland calls you"),
				    L("Area:1:3", "scorching sun"),
				    L("Area:1:4", "watch out for maggots"),
				    L("Area:1:5", "let's do this"),
				    L("Area:1:6", "dust surrounds you"),
				    L("Area:1:7", "the wind hurts"),
				)
				break
			case 2:
				tip = choose(
					L("Area:2:1", "don't drink the water"),
				    L("Area:2:2", "the sewers stink"),
				    L("Area:2:3", "don't touch the frogs"),
				    L("Area:2:4", "don't eat the rat meat"),
				    L("Area:2:5", "danger"),
				    L("Area:2:6", "water dripping"),
				    L("Area:2:7", "sludge everywhere"),
				    L("Area:2:8", "so many rats"),
				)
				break
			case 3:
				tip = choose(
					L("Area:3:1", "shoot robots on sight"),
				    L("Area:3:2", "there used to be trees here"),
				    L("Area:3:3", "look up"),
				    L("Area:3:4", "rust everywhere"),
				    L("Area:3:5", "the sound of birds"),
				    L("Area:3:6", "sludge pools"),
				    L("Area:3:7", "climb over cars"),
				    L("Area:3:8", "portals can blow up cars"),
				)
				break
			case 4:
				tip = choose(
					L("Area:4:1", "oh no"),
				    L("Area:4:2", "spiderwebs everywhere"),
				    L("Area:4:3", "don't lose your heart"),
				    L("Area:4:4", "reflections on the walls"),
				    L("Area:4:5", "skin is crawling"),
				    L("Area:4:6", "almost halfway there"),
				)
				break
			case 5:
				tip = choose(
					L("Area:5:1", "wear a scarf"),
				    L("Area:5:2", "they used to have electricity"),
				    L("Area:5:3", "miss the sun"),
				    L("Area:5:4", "civilization"),
				    L("Area:5:5", "walk softly"),
				    L("Area:5:6", "there is no yeti"),
				)
				break
			case 6:
				tip = choose(
					L("Area:6:1", "beep boop"),
				    L("Area:6:2", "nerds"),
				    L("Area:6:3", "don't push any buttons"),
				    L("Area:7:1", "this place is old"),
				    L("Area:7:2", "the palace"),
				)
				break
			case 100:
				tip = choose(
					L("Area:100:1", "awww yes"),
				    L("Area:101:1", "fish"),
				    L("Area:101:2", "hold your breath"),
				    L("Area:101:3", "it's beautiful down here"),
				    L("Area:101:4", "don't move"),
				)
				break
			case 102:
				tip = choose(
					L("Area:102:1", "hunger..."),
				    L("Area:102:2", "it smells nice here"),
				)
				break
			case 103:
				tip = choose(
					L("Area:103:1", "space..."),
				    L("Area:103:2", "always wanted to go here"),
				    L("Area:103:3", "so much money"),
				    L("Area:103:4", "4 years later..."),
				)
				break
			case 104:
				tip = choose(
					L("Area:104:1", "no oh"),
				    L("Area:104:2", "everywhere spiderwebs"),
				    L("Area:104:3", "crawling is skin"),
				    L("Area:104:4", "there halfway almost"),
				)
				break
			case 105:
				tip = choose(
					L("Area:105:1", "there's something in the trees"),
				    L("Area:105:2", "bugs everywhere"),
				    L("Area:105:3", "welcome to the jungle"),
				    L("Area:105:4", "heart of darkness"),
				)
				break
			case 107:
				tip = choose(
					L("Area:107:1", "this is where the magic happens"),
				    L("Area:107:2", "lets take a look in the fridge"),
				    L("Area:107:3", "get the hell out of here"),
				    L("Area:107:4", "now this is real special"),
				    L("Area:107:5", "wakkala wayo"),
				)
				break
		}
	}

	// Characters
	if (_tip_type == 2) {
		var _race = instance_exists(_player) ? _player.race : Race.Random
		
		if GameCont.level >= 10 && random(5) < 1 {
			switch (_race) {
				case 0:
					tip = choose(
						L("Ultra:0:1", "random @gultra@s, unstoppable"),
					)
					break
				case 1:
					tip = choose(
						L("Ultra:1:1", "getting used to this"),
						L("Ultra:1:2", "just one more day"),
					)
					break
				case 2:
					tip = choose(
						L("Ultra:2:1", "just a scratch"),
						L("Ultra:2:2", "stay strong"),
					)
					break
				case 3:
					tip = choose(
						L("Ultra:3:1", "know everything"),
						L("Ultra:3:2", "show nothing"),
						L("Ultra:3:3", "keep it inside"),
					)
					break
				case 4:
					tip = choose(
						L("Ultra:4:1", "the pain..."),
						L("Ultra:4:2", "please stop..."),
						L("Ultra:4:3", "life is incredibly beautiful"),
					)
					break
				case 5:
					tip = choose(
						L("Ultra:5:1", "end end end"),
					)
					break
				case 6:
					tip = choose(
						L("Ultra:6:1", "\\#verifycuz"),
						L("Ultra:6:2", "airsiren.wav"),
						L("Ultra:6:3", "\\#blessed"),
						L("Ultra:6:4", "one of these days..."),
						L("Ultra:6:5", "real thugs hustle"),
						L("Ultra:6:6", "YV fact: YV IS THE BEST"),
						L("Ultra:6:7", "4EVER"),
						L("Ultra:6:8", "GO HARD"),
						L("Ultra:6:9", "VOTE 2 B COOL"),
					)
					break
				case 7:
					tip = choose(
						L("Ultra:7:1", "let's hope this is correct"),
						L("Ultra:7:2", "so strong"),
					)
					break
				case 8:
					tip = choose(
						L("Ultra:8:1", "6d 61 63 68 69 6e 65 73#77 69 6c 6c#6e 65 76 65 72#65 6e 64"),
						L("Ultra:8:2", "66 6c 65 73 68#69 73#77 65 61 6b"),
						L("Ultra:8:3", "73 69 6e 67 75 6c 61 72 69 74 79"),
						L("Ultra:8:4", "don't panic"),
					)
					break
				case 9:
					tip = choose(
						L("Ultra:9:1", "this is destiny"),
						L("Ultra:9:2", "just like in the movies"),
						L("Ultra:9:3", "again we are defeated"),
					)
					break
				case 10:
					tip = choose(
						L("Ultra:10:1", "all together now"),
						L("Ultra:10:2", "no stopping now"),
					)
					break
				case 11:
					tip = choose(
						L("Ultra:11:1", "the air is changing"),
						L("Ultra:11:2", "the light moves"),
						L("Ultra:11:3", "things are different"),
					)
					break
				case 12:
					tip = choose(
						L("Ultra:12:1", "use this"),
						L("Ultra:12:2", "you deserve this"),
						L("Ultra:12:3", "they can't chase you forever"),
					)
					break
				case 13:
					tip = choose(
						L("Ultra:13:1", "guard this land"),
						L("Ultra:13:2", "none will pass"),
						L("Ultra:13:3", "fire at will"),
					)
					break
				case 14:
					tip = choose(
						L("Ultra:14:1", "this is better"),
						L("Ultra:14:2", "avoid the living"),
						L("Ultra:14:3", "no need for peace"),
					)
					break
				case 15:
					tip = choose(
						L("Ultra:15:1", "bwahahaha"),
						L("Ultra:15:2", "singing"),
						L("Ultra:15:3", "sweet sounds"),
						L("Ultra:15:4", "go forever"),
						L("Ultra:15:5", "smell great"),
					)
					break
				case 16:
					tip = choose(
						L("Ultra:16:1", "good job cuz!!!"),
						L("Ultra:16:2", "round and handsome"),
						L("Ultra:16:3", "spherical miracle"),
						L("Ultra:16:4", "gaming makes you smart"),
					)
					break
			}
		}
		else {
			switch (_race) {
				case 0:
					tip = choose(
						L("Race:0:1", "random shifts shapes"),
						L("Race:0:2", "clearly the most powerful"),
						L("Race:0:3", "never the same"),
						L("Race:0:4", "shapeless"),
						L("Race:0:5", "passive: anything"),
						L("Race:0:6", "active: anything"),
						L("Race:0:7", "noone compares"),
					)
					break
				case 1:
					tip = choose(
						L("Race:1:1", "last day before retirement"),
						L("Race:1:2", "duty calls"),
						L("Race:1:3", "it's ok to eat"),
						L("Race:1:4", "gills on your neck"),
						L("Race:1:5", "like kevin costner"),
						L("Race:1:6", "the taste of mud"),
					)
					break
				case 2:
					tip = choose(
						L("Race:2:1", "crystal can handle this"),
						L("Race:2:2", "family"),
					)
					break
				case 3:
					tip = choose(
						L("Race:3:1", "eyes sees everything"),
						L("Race:3:2", "don't blink"),
						L("Race:3:3", "all these thoughts"),
						L("Race:3:4", "eyes can't speak"),
						L("Race:3:5", "telekinesis pushes projectiles away"),
					)
					break
				case 4:
					tip = choose(
						L("Race:4:1", "it's so cold out here"),
						L("Race:4:2", "melting is tired"),
						L("Race:4:3", "everything hurts"),
						L("Race:4:4", "cough"),
						L("Race:4:5", "brr..."),
						L("Race:4:6", "it's ok to be scared"),
					)
					break
				case 5:
					tip = choose(
						L("Race:5:1", "kill kill kill"),
						L("Race:5:2", "death death death"),
						L("Race:5:3", "blood blood blood"),
						L("Race:5:4", "no mercy"),
						L("Race:5:5", "photosynthesizing..."),
						L("Race:5:6", "snare is a source of light"),
						L("Race:5:7", "gotta go fast"),
					)
					break
				case 6:
					tip = choose(
						L("Race:6:1", "yung venuz is so cool"),
						L("Race:6:10", "mony"),
						L("Race:6:11", "guns that straight festive"),
						L("Race:6:12", "guns with 6 senses"),
						L("Race:6:13", "guns that hate texas"),
						L("Race:6:14", "guns that wear vests it"),
						L("Race:6:15", "no @bpopo@s"),
						L("Race:6:16", "pop pop"),
						L("Race:6:17", "shoutout 2 cuz"),
						L("Race:6:2", "yung venuz is the best"),
						L("Race:6:3", "so cool"),
						L("Race:6:4", "thanks gun god"),
						L("Race:6:5", "\\#verifyvenuz"),
						L("Race:6:6", "2 yung 2 die"),
						L("Race:6:7", "guns for fake necklace"),
						L("Race:6:8", "guns that send textses"),
						L("Race:6:9", "guns that make breakfast"),
					)
					break
				case 7:
					tip = choose(
						L("Race:7:1", "time to flex"),
						L("Race:7:2", "study hard"),
						L("Race:7:3", "steroids could do pushups forever"),
						L("Race:7:4", "steroids used to be a scientist"),
						L("Race:7:5", "appreciate @wrevolvers@s"),
						L("Race:7:6", "get shots"),
						L("Race:7:7", "get strong"),
						L("Race:7:8", "read a book"),
					)
					break
				case 8:
					tip = choose(
						L("Race:8:1", "6b 69 6c 6c#61 6c 6c#68 75 6d 61 6e 73"),
						L("Race:8:2", "72 6f 62 6f 74"),
						L("Race:8:3", "3c 33"),
						L("Race:8:4", "74 61 73 74 79"),
						L("Race:8:5", "@wguns@s for breakfast"),
						L("Race:8:6", "I'm afraid I can't let you do that"),
						L("Race:8:7", "don't forget to eat @wweapons@s"),
					)
					break
				case 9:
					tip = choose(
						L("Race:9:1", "remember the training"),
						L("Race:9:2", "focus"),
						L("Race:9:3", "go"),
						L("Race:9:4", "never surrender"),
						L("Race:9:5", "amateur hour is over"),
						L("Race:9:6", "again"),
						L("Race:9:7", "getting decapitated reduces max HP"),
						L("Race:9:8", "throw damage scales with your level"),
					)
					break
				case 10:
					tip = choose(
						L("Race:10:1", "forget the old days"),
						L("Race:10:2", "change is coming"),
						L("Race:10:3", "allies are a source of light"),
						L("Race:10:4", "a new generation"),
						L("Race:10:5", "it will get better"),
						L("Race:10:6", "spawning new allies @rheals@s old ones"),
						L("Race:10:7", "your first ally costs less @rHP@s"),
						L("Race:10:8", "allies take damage over time"),
						L("Race:10:9", "the scarf is nice"),
					)
					break
				case 11:
					tip = choose(
						L("Race:11:1", "@gradiation@s is everywhere"),
						L("Race:11:2", "in the zone"),
						L("Race:11:3", "the horror"),
						L("Race:11:4", "power"),
						L("Race:11:5", "horror's beam powers up over time"),
						L("Race:11:6", "horror's beam destroys projectiles"),
						L("Race:11:7", "enemies absorb the beam's @grads@s"),
						L("Race:11:8", "firing the beam pauses @grad@s attraction"),
					)
					break
				case 12:
					tip = choose(
						L("Race:12:1", "another world lost"),
						L("Race:12:2", "never stop"),
						L("Race:12:3", "they're getting closer"),
						L("Race:12:4", "never slow down"),
						L("Race:12:5", "never look back"),
						L("Race:12:6", "keep moving"),
					)
					break
				case 13:
					tip = choose(
						L("Race:13:1", "big"),
						L("Race:13:2", "dog"),
					)
					break
				case 14:
					tip = choose(
						L("Race:14:1", "nothing..."),
						L("Race:14:2", "dry"),
						L("Race:14:3", "dusty"),
						L("Race:14:4", "hard"),
					)
					break
				case 15:
					tip = choose(
						L("Race:15:1", "can't wait"),
						L("Race:15:2", "let's go"),
						L("Race:15:3", "restless"),
						L("Race:15:4", "bloated"),
						L("Race:15:5", "gas is good"),
						L("Race:15:6", "let it all out"),
						L("Race:15:7", "keep going"),
						L("Race:15:8", "don't hold it in"),
						L("Race:15:9", "wait for me"),
					)
					break
				case 16:
					tip = choose(
						L("Race:16:1", "cool"),
						L("Race:16:10", "need a snack"),
						L("Race:16:11", "gunz god"),
						L("Race:16:12", "cuz can carry multiple weapons"),
						L("Race:16:13", "cuz can cry"),
						L("Race:16:14", "take damage to gain tears"),
						L("Race:16:15", "born 2 gun"),
						L("Race:16:2", "nice"),
						L("Race:16:3", "shoutout 2 veenie"),
						L("Race:16:4", "yung cuz!!!"),
						L("Race:16:5", "every gun is my favorite gun"),
						L("Race:16:6", "it’s ok to cry"),
						L("Race:16:7", "crying is cool"),
						L("Race:16:8", "strapped"),
						L("Race:16:9", "don't upset me"),
					)
					break
			}
		}
	}
	
	// Weapons
	if (_tip_type == 3) {
		if (scrPlayerCountCursed(_player) > 0 && random(10) < 1) {
			tip = choose(
				L("Curse:1", "@qw @qh @qy"),
				L("Curse:2", "@qh @qe @ql @ql @qo"),
				L("Curse:3", "@qi @qs @qe @qe @qy @qo @qu"),
				L("Curse:4", "@ql @qe @qt @qm @qe @qo @qu @qt"),
				L("Curse:5", "@qp @ql @qe @qa @qs @qe @qs @qt @qo @qp"))
		}
		else if (scr_weapon_is_valid(_player.wep)) {
			tip = loc("Weapons", _player.wep, "Tip", scr_weapon_get_text(_player.wep))
		}
	}

	// Mutations
	if (_tip_type == 4 && GameCont.level > 1) {
	    var _skills = GameCont.skills,
			_skill_index = irandom(ds_list_size(_skills) - 1)
		
		if (_skill_index >= 0) {
			var _skill = _skills[| _skill_index]
			tip = loc("Skills", _skill, "Tip", scr_skill_get_tips(_skills[| _skill]))
		}
	}

	// Crowns
	if (_tip_type == 5) {
		var _crown = GameCont.crown
		
		if (_crown > crwn_none) {
			tip = loc("Crowns", _crown, "Tip", scr_crown_get_tips(_crown))
		}
	}
	
	// Low health
	if (_tip_type == 6 && _player.hp < 4) {
		tip = choose(
			L("Low:1", "oh dear"),
			L("Low:2", "this isn't going to end well"),
			L("Low:3", "good luck"),
			L("Low:4", "no no no"),
			L("Low:5", "help"))
	}
	
	// Loops
	if (_tip_type == 7 && GameCont.loops > 0) {
		tip = choose(
			L("Loop:1", "this will never end"),
			L("Loop:2", "it's a whole new world"),
			L("Loop:3", "monsters everywhere"),
			L("Loop:4", "what's happening"),
			L("Loop:5", "there's no limit"),
			L("Loop:6", "we'll reach for the sky"),
			L("Loop:7", "no valley too deep"),
			L("Loop:8", "no mountain too high"))
	}
	
	if (is_array(tip)) tip = array_random(tip) ?? ""
	
	if (tip != "") {
		tip = string_hash_to_newline(tip)
	}
	else {
		scrTips()
	}
}
