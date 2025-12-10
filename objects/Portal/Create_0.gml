type = 1
image_speed = 0.4
endgame = 100

snd_play(GameCont.underwater ? sndOasisPortal : sndPortalOpen)

if instance_exists(Player) {
    with projectile {
        if (team != team_player) instance_destroy(id, 0)
	}
}

instance_create(x, y, PortalClear)
instance_create(x, y, PortalShock)

with Player {
	if (race != Race.Rogue) continue
	repeat (2) instance_create(other.x, other.y, IDPDSpawn)
    GameCont.popolevel -= 1.5
}

close = false