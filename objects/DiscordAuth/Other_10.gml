if instance_exists(Logo) or !available
	exit

snd_play(sndClick)

if !auth_discord_logged && !active {
	with UberCont
		event_user(10)
}