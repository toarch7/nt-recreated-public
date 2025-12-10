if scr_projectile_generic_hit(false, true) {
	if (other.hp <= 0 && other.object_index == Player && !other.spirit) {
		scrAchievementUnlock(Achievement.SINCERE_APPOLOGIES)
	}
	
	snd_play(sndDiscHit)
    sleep(10)
}