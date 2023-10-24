function resourcepack_priority_sort(items) {
	array_sort(items, function(a, b) {
		if a.priority == b.priority
			return sign(b.installtime - a.installtime)
		
		if b.priority > a.priority
			return 1
		
		return -1
	})
}