/// @description Volume controls, event dates, options
if !instance_exists(Player) {
    UberCont.hardmode = false
    SetVolumeControl(false)
    scrLoadoutMenuInit()
}
else if os_type == os_android {
    SetVolumeControl(opt_volumecontrol)
}

call_after(5, function() {
	if (instance_exists(MakeGame)) exit
	
	if ((!instance_exists(Player) || scrGameIsGenerationScreen())
		&& ((current_time - update_request_since_last) > 120_000)
	) {
		if (!update_notified) {
			scrGameQueryUpdateVersion()
		}
		else if (scrGameIsEventRun()) {
			daily_request = tb_api("daily")
			weekly_request = tb_api("weekly")
		}
	}
})

scrOptionsUpdate()

if ((scrGameIsDailyRun() && daily_grill) || (scrGameIsWeeklyRun() && weekly_grill)) {
	opt_griller = true
}

april_fools = (current_day == 1 && current_month == 4)
xmas = ((current_day >= 25 && current_month == 12) || (current_day <= 7 && current_month == 1))
halloween = (current_day >= 30 && current_month == 10)
birthday = (current_day == 7 && current_month == 8)

if (!april_fools) cgot[Race.BigDog] = false
