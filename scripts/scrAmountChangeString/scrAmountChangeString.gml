function scrAmountChangeString(_amount) {
	if _amount >= 0 {
		return $"+{abs(_amount)}"
	}
	
	return $"-{abs(_amount)}"
}