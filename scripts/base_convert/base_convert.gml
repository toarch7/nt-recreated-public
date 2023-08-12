function base_convert(number, oldbase, newbase) {
	/// base_convert(number,oldbase,newbase)
	//
	//  Returns a string of digits representing the
	//  given number converted form one base to another.
	//  Base36 is the largest base supported.
	//
	//      number      integer value to be converted, string
	//      oldbase     base of the given number, integer
	//      newbase     base of the returned value, integer
	//
	/// GMLscripts.com/license
	
    var out = "", num
    
	number = string_upper(number)
	
    var len = string_length(number),
		tab = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 	
    for (var i = 0; i < len; i ++) {
        num[i] = string_pos(string_char_at(number, i + 1), tab) - 1
    }
 
    do {
        var divide = 0,
			newlen = 0
		
        for (var i=0; i < len; i ++) {
            divide = divide * oldbase + num[i]
			
            if (divide >= newbase) {
                num[newlen] = divide div newbase
				
                newlen += 1
				
                divide = divide mod newbase
            }
			else if (newlen  > 0) {
                num[newlen] = 0
                newlen += 1
            }
        }
		
        len = newlen
        out = string_char_at(tab, divide + 1) + out
    }
	until len == 0
 
    return out
}