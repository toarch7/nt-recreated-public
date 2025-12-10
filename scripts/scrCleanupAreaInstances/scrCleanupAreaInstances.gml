function scrCleanupAreaInstances() {
	instance_destroy(Floor, false)
	instance_destroy(Wall, false)
	instance_destroy(damagesource, false)
	
	with (hitme) if (!instance_is(self, Player)) instance_destroy(id, false)
	
	instance_destroy(TopSmall)
	instance_destroy(Spiral)
	instance_destroy(SpiralCont)
	instance_destroy(SpiralDebris)
	instance_destroy(SpiralStar)
	instance_destroy(Detail)
	instance_destroy(TopPot)
	
	instance_destroy(FloorMaker, false)
	instance_destroy(GenCont, false)
}