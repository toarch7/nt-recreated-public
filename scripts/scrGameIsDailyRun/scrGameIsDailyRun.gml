function scrGameIsEventRun() {
	return UberCont.daily_run
}

function scrGameIsDailyRun() {
	with UberCont {
		return daily_run && !weekly_run
	}
}

function scrGameIsWeeklyRun() {
	with UberCont {
		return daily_run && weekly_run
	}
}

function scrGameIsHardmode() {
	return global.hardmode
}