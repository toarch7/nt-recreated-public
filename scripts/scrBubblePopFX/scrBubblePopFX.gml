function scrBubblePopFX() {
	if (GameCont.underwater) {
		with (instance_create(x, y, AnimParticle)) sprite_index = sprPlayerBubblePop
	}
}