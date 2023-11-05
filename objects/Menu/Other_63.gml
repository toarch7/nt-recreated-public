if async_load[? "id"] == seed_prompt {
	var str = async_load[? "result"]
	
	if str == "" or str == "0" or (string_starts(str, "-") && string_is_real(str)) or string_lower(str) == "random" {
		global.custom_seed = 0
		seed_text = "random"
		snd_play(sndMutant0Cnfm)
		
		exit
	}
	
	seed_text = str
	
	var _seed = string_is_real(str) ? real(str) : scrGenerateUID(str, true)
	
	random_set_seed(_seed)
	global.custom_seed = _seed
	global.seed = _seed
	
	snd_play(sndMutant0Slct)
	
	rng_reset()
	
}