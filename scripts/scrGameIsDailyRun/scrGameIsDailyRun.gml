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
	return UberCont.hardmode
}

function scrGameIsContinuedRun() {
	return UberCont.continued_run
}

function scrGameIsCustomMode() {
	return UberCont.custom
}


