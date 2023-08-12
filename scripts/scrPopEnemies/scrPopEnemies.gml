function scrPopEnemies() {
    if distance_to_point(10016, 10016) < 160 or place_meeting(x, y, Wall) return undefined

    random_set_seed(rng_next_int(1))

    if ((spawnarea == 1) && !instance_exists(TutCont)) {
        if (random(2) < random(GameCont.loops)) instance_create(x + 16, y + 16, choose(Scorpion, Scorpion, Bandit, Bandit, Maggot, JungleFly, JungleFly, MeleeBandit, Sniper))
        else if (styleb == 1) instance_create(x + 16, y + 16, choose(MaggotSpawn, BigMaggot, BigMaggot, Maggot))
        else if (random(7) < 1) instance_create(x + 16, y + 16, choose(MaggotSpawn, Scorpion))
        else if (random(30) < 1) {
            instance_create(x + 16, y + 16, Barrel)
            instance_create(((x + 16 + random(4)) - 2), ((y + 16 + random(4)) - 2), Bandit)
            instance_create(((x + 16 + random(4)) - 2), ((y + 16 + random(4)) - 2), Bandit)
            instance_create(((x + 16 + random(4)) - 2), ((y + 16 + random(4)) - 2), Bandit)
        } else instance_create(x + 16, y + 16, choose(Bandit, Bandit, Bandit, Bandit, Bandit, Bandit, Maggot, Scorpion))
    }
    if (spawnarea == 2) {
        if (random(2) < random(GameCont.loops)) instance_create(x + 16, y + 16, choose(Ratking, Ratking, BuffGator, LaserCrystal, Rat, Exploder, Exploder, SuperFireBaller))
        else if (styleb == 1) instance_create(x + 16, y + 16, choose(Rat, Rat, Gator, Gator, Exploder))
        else if (random(9) < 1) instance_create(x + 16, y + 16, choose(Exploder, Ratking, Exploder, Ratking, Exploder, Ratking, MeleeFake))
        else instance_create(x + 16, y + 16, choose(Rat, Rat, Rat, Rat, Rat, Rat, Rat, Bandit))
    }
    if ((spawnarea == 3) && ((random(5) < 4) && ((GameCont.subarea != 3) || (random(2) < 1)))) {
        if (random(2) < random(GameCont.loops)) instance_create(x + 16, y + 16, choose(Sniper, Sniper, MeleeFake, MeleeFake, Salamander, SnowBot, Raven, BuffGator, Raven))
        else if ((styleb == 1) && (random(3) < 1)) instance_create(x + 16, y + 16, Salamander)
        else if (random(4) < 1) instance_create(x + 16, y + 16, choose(MeleeBandit, Sniper, MeleeFake, Sniper, MeleeFake, Sniper, Sniper, Exploder))
        else if (random(10) < 1) {
            if (random(8) < 1) instance_create(x + 16, y + 16, Car)
            instance_create(((x + 16 + random(4)) - 2), ((y + 16 + random(4)) - 2), Raven)
            instance_create(((x + 16 + random(4)) - 2), ((y + 16 + random(4)) - 2), Raven)
        } else if (random(20) < 1) instance_create(x + 16, y + 16, Salamander)
        else if (random(4) < 3) instance_create(x + 16, y + 16, choose(Raven, Raven, Bandit))
    }
    if (spawnarea == 4) {
        if (random(2) < random(GameCont.loops)) instance_create(x + 16, y + 16, choose(LaserCrystal, LaserCrystal, LaserCrystal, RhinoFreak, LightningCrystal, BuffGator, ExploFreak, Spider, Spider))
        else instance_create(x + 16, y + 16, choose(Spider, Spider, Spider, Spider, LaserCrystal))
    }
    if ((spawnarea == 104) && (random(5) < 4)) instance_create(x + 16, y + 16, choose(InvSpider, InvSpider, InvSpider, InvSpider, InvLaserCrystal, InvLaserCrystal))
    if (spawnarea == 5) {
        if (random(2) < random(GameCont.loops)) instance_create(x + 16, y + 16, choose(SnowTank, SnowTank, DogGuardian, Exploguardian, SnowBot, SnowBot, SnowBot, Wolf, Necromancer))
        //else if ((UberCont.xmas == 1) && (random(1000) < 1))
        //    instance_create(x + 16, y + 16, PotentialYeti)
        else if (random(3) < 2) instance_create(x + 16, y + 16, choose(SnowBot, SnowBot, SnowBot, SnowTank, Wolf, Wolf))
    }
    if ((spawnarea == 6) && (point_distance(x, y, 10016, 10016) > 160)) {
        if (random(2) < random(GameCont.loops)) instance_create(x + 16, y + 16, choose(Ratking, RhinoFreak, ExploFreak, Necromancer, RhinoFreak, LaserCrystal, BecomeTurret))
        else if (random(14) < 1) {
            repeat(10)
            instance_create(((x + 12) + random(8)), ((y + 12) + random(8)), choose(Freak, Freak, Freak, Freak, Freak, Freak, Freak, Freak, Freak, Freak, ExploFreak, ExploFreak, RhinoFreak, Freak, Freak, Freak))
        } else if (random(8) < 1) instance_create(x + 16, y + 16, choose(Necromancer, Necromancer, Necromancer, ExploFreak, RhinoFreak, Necromancer, Necromancer, BecomeTurret, BecomeTurret, BecomeTurret, Necromancer))
    }
    if ((spawnarea == 7) && ((GameCont.subarea != 3) && (random(2) < 1))) {
        if (random(2) < random(GameCont.loops)) instance_create(x + 16, y + 16, choose(Exploguardian, DogGuardian, Sniper, DogGuardian, Exploguardian, ExploFreak, JungleBandit, JungleBandit))
        else if (random(4) < 1) instance_create(x + 16, y + 16, choose(Exploguardian, DogGuardian, Guardian, Guardian, Guardian, Guardian))
        else if (random(16) < 1) instance_create(x + 16, y + 16, IDPDSpawn)
    }
    if (spawnarea == 102) instance_create(x + 16, y + 16, Turtle)
    if (spawnarea == 101) {
        if (random(4) < 1) instance_create(x + 16, y + 16, Crab)
        else if (random(3) < 1) {
            repeat(3)
            instance_create(((x + 14) + random(4)), ((y + 14) + random(4)), BoneFish)
        }
    }
    if (spawnarea == 103) {
        if (random(5) < 1) instance_create(x + 16, y + 16, choose(FireBaller, Jock, FireBaller, Jock, FireBaller, SuperFireBaller))
        else if (random(4) < 1) {
            if (random(5) < 1) instance_create(x + 16, y + 16, GoldBarrel)
            repeat(3)
            instance_create(x + 16, y + 16, choose(Molefish, Molefish, Molefish, Molefish, Molesarge))
        }
    }
    if ((spawnarea == 106) && (GameCont.subarea != 3)) {
        if (random(12) < 1 or !instance_exists(enemy)) {
            if (random(7) < 1) instance_create(x + 16, y + 16, choose(EliteGrunt, EliteShielder, EliteInspector))
            else if (random(4) < 1) {
                repeat(5)
                instance_create(x + 16, y + 16, Grunt)
            } else if (random(3) < 1) instance_create(x + 16, y + 16, choose(Grunt, Shielder, Inspector))
        }
    }
	
    if spawnarea == 105 {
        if random(8) < 1 {
			instance_create(x + 16, y + 16, JungleFly)
		}
		else if random(30) < 1 {
            instance_create(x + 16, y + 16, Barrel)
            instance_create(x + 16 + orandom(2), y + 16 + orandom(2), JungleBandit)
            instance_create(x + 16 + orandom(2), y + 16 + orandom(2), JungleBandit)
            instance_create(x + 16 + orandom(2), y + 16 + orandom(2), JungleBandit)
        }
		else {
			instance_create(x + 16, y + 16, choose(JungleBandit, JungleBandit, JungleBandit, JungleBandit, JungleBandit, JungleBandit, Maggot, MeleeFake, MeleeFake))
		}
	}




}