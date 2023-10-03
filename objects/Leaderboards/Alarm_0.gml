// killswitch
if !UberCont.leaderboards_allowed {
	with instance_create(0, 0, DailyList)
		viewtype = other.type
	
	exit
}

var url_base = "https://raw.githubusercontent.com/toarch7/ntm-browser/main/leaderboards/"
req = scrHttpGet(url_base + type + "list.json")