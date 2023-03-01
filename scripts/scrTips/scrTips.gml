function scrTips() {
	var tiptype = choose(0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 3, 4, 5)
	
	tip = ""
	
	if !instance_exists(Player)
		tiptype = 0
	
	var plr = instance_random(Player)
	
	 // Generic
	if tiptype == 0 {
	    tip = choose (
	        choose (
	            "HP will only drop when damaged",
	            "explosives can destroy walls",
	            "melee weapons can deflect bullets",
	            "shotguns are great for close combat",
	            "assassins can pretend they're dead",
	            "fish can roll",
	            "always keep one eye on your ammo",
	            "robots can digest anything",
	            "bandits like camping near explosives",
	            "not today",
	            "rosebud",
	            "it's not fair, it's not right",
	            "watch out for dehydration",
	            "crystal can shield",
	            "fear is the mindkiller",
	            choose (
	                "no",
	                "bob and weave",
	                "airhorn.wav",
	                "danger zone",
	                "the throne is getting closer",
	                "remember to take a 15 minute break#for every hour you play!",
	            "","","","","","","","","","")
	        ), choose (
	        "the @bI.D.P.D.@s is looking for you",
	        "try hitting grenades for extra range",
	        "pick your mutations wisely",
	        "if only you could talk to the monsters",
	        "steroids can dual wield",
	        "always wear dry socks",
	        "crowns are loyal",
	        "energy weapons use lots of ammo",
	        "the throne definitely exists",
	        "try not opening weapon chests",
	        "fire at things until they die",
	        "ammo drops depend on your weapons",
	        "war is hell",
	        "beware of statues",
	        "doing alright",
	        "there are other worlds out there")
	    )
	}
	
	 // Area-based
	if tiptype == 1 {
		if GameCont.area == 0
			tip = choose("it's dark here","your friends were here")
		
		if GameCont.area == 1
			tip = choose("welcome to the future","the wasteland calls you","scorching sun","watch out for maggots","let's do this","dust surrounds you","the wind hurts")
		
		if GameCont.area == 2
			tip = choose("don't drink the water","the sewers stink","don't touch the frogs","don't eat the rat meat","danger","water dripping","sludge everywhere")
		
		if GameCont.area == 3
			tip = choose("shoot robots on sight","there used to be trees here","look up","rust everywhere","the sound of birds","don't cross the streams","climb over cars")
		
		if GameCont.area == 4
			tip = choose("oh no","good luck","spiderwebs everywhere","reflections on the walls","skin is crawling","almost halfway there")
		
		if GameCont.area == 5
			tip = choose("wear a scarf","they used to have electricity","miss the sun","civilization","walk softly","there is no yeti")
		
		if GameCont.area == 6
			tip = choose("beep boop","nerds","don't push any buttons")
		
		if GameCont.area == 7
			tip = choose("the palace","this place is old")
		
		if GameCont.area == 100
			tip = choose("awww yes")
		
		if GameCont.area == 101
			tip = choose("fish")
		
		if GameCont.area == 102 {
			tip = choose("hunger...", "it smells nice here")
		}
		
		if GameCont.area == 103
			tip = choose("space...","always wanted to go here","so much money","4 years later...")
		
		if GameCont.area == 104
			tip = choose("no oh","Crawling is skin","Everywhere spiderwebs","There halfway almost")
		
		if GameCont.area == 105
			tip = choose("Heart of darkness","Welcome to the jungle","Bugs everywhere","There's something in the trees")
		
		if GameCont.area == 106
			tip = choose("it's here")
		
		if GameCont.area == 107
			tip = choose("Y.V's cool", "Y.V. Fact: Y.V. is the best")
	}

	 //Character based
	if tiptype = 2 {
		var race = GameCont.race
		
		if GameCont.level >= 10 && random(5) < 1 {
			if race == 0
				tip = choose("random @gultra@s, unstoppable")
			
			if race == 1
				tip = choose("getting used to this", "just one more day")
			
			if race == 2
				tip = choose("just a scratch", "stay strong")
			
			if race == 3
				tip = choose("know everything", "show nothing", "keep it inside")
			
			if race == 4
				tip = choose("the pain...", "please stop...")
			
			if race == 5
				tip = choose("end end end")
			
			if race == 6
				tip = choose("\#verifycuz", "airsiren.wav", "\#blessed", "one of these days...", "real thugs hustle", "YV fact: YV IS THE BEST", "4EVER", "GO HARD", "VOTE 2 B COOL")
			
			if race == 7
				tip = choose("let's hope this is correct", "so strong")
			
			if race == 8
				tip = choose("6d 61 63 68 69 6e 65 73#77 69 6c 6c#6e 65 76 65 72#65 6e 64", "66 6c 65 73 68#69 73#77 65 61 6b", "73 69 6e 67 75 6c 61 72 69 74 79", "don't panic")
			
			if race == 9
				tip = choose("this is destiny", "just like in the movies", "again we are defeated")
			
			if race == 10
				tip = choose("all together now", "no stopping now")
			
			if race == 11
				tip = choose("the air is changing", "the light moves", "things are different")
			
			if race == 12
				tip = choose("use this", "you deserve this", "they can't chase you forever")
			
			if race == 13
				tip = choose("guard this land", "none will pass", "fire at will")
			
			if race == 14
				tip = choose("this is better", "avoid the living", "no need for peace")
			
			if race == 15
				tip = choose("bwahahaha", "singing", "sweet sounds", "go forever", "smell great")
			
			if race == 16
				tip = choose("what a good time")
		}
		else {
			if race == 1
				tip = choose("last day before retirement", "duty calls", "it's ok to eat", "gills on your neck", "like kevin costner", "the taste of mud")
			
			if race == 2
				tip = choose("crystal can handle this", "family")
			
			if race == 3
				tip = choose("eyes sees everything", "don't blink", "all these thoughts", "eyes can't speak", "telekinesis pushes projectiles away")
			
			if race == 4
				tip = choose("it's so cold out here", "melting is tired", "everything hurts", "cough", "brr...", "it's ok to be scared")
			
			if race == 5
				tip = choose("kill kill kill", "death death death", "blood blood blood", "no mercy", "photosynthesizing...", "snare is a source of light", "gotta go fast")
			
			if race == 6
				tip = choose("yung venuz is so cool", "yung venuz is the best", "so cool", "thanks gun god", "\#verifyvenuz", "2 yung 2 die", "guns for fake necklace", "guns that send textses", "guns that make breakfast", "mony", "guns that straight festive", "guns with 6 senses", "guns that hate texas", "guns that wear vests it", "no @bpopo@s", "pop pop")
			
			if race == 7
				tip = choose("time to flex","steroids could do pushups forever","steroids used to be a scientist","appreciate revolvers","get shots","get strong")

			if race == 8
				tip = choose("6b 69 6c 6c#61 6c 6c#68 75 6d 61 6e 73","72 6f 62 6f 74","3c 33","74 61 73 74 79","guns for breakfast","I'm afraid I can't let you do that","don't forget to eat weapons")

			if race == 9
				tip = choose("remember the training","focus","go","never surrender","amateur hour is over","again")

			if race == 10
				tip = choose("forget the old days","change is coming","a new generation","it will get better","spawning new allies heals old ones","allies take damage over time")

			if race == 11
				tip = choose("Radiation is everywhere","Firing the beam pauses rad attraction","Enemies absorb the beam's rads","Horror's beam destroys projectiles","Power","The horror","In the zone")

			if race == 12
				tip = choose("Keep moving","Never look back","Never slow down","They're getting closer","Never stop","Another world lost")

			if race == 13
				tip = choose("big", "dog")

			if race == 14
				tip = choose("postmortem")

			if race == 15
				tip = choose("Family", "Don't stop me", "Can't stand still")

			if race == 16
				tip = choose("Gaming")
		}
	}
	
	 //Weapons
	if tiptype == 3 {
	    tip = plr.wep_text[plr.wep]
	}

	 //Mutations
	if tiptype = 4 {
	    if GameCont.level == 1 {
	        tip = ""
	    }
		else {
	        dir = 0
        
	        do {
	            dir = irandom(plr.maxskill)
	        }
			until skill_get(dir)
        
	        tip = plr.skill_tips[dir]
	    }
	}

	 //Crowns
	if tiptype == 5 {
	    tip = GameCont.crown_tips[GameCont.crown]
	}
	
	if tip == ""
		scrTips()
}
