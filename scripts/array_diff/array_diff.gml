function array_diff(a, b) {
	var list = [],
		l1 = array_length(a),
		l2 = array_length(b)
	
	for(var i = 0; i < l1; i ++) {
		var el = a[i],
			any = false
		
		for(var j = 0; j < l2; j ++) {
			if el == b[j] {
				any = true; break
			}
		}
		
		if !any
			array_push(list, el)
	}
	
	return list
}