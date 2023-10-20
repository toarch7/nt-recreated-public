function scrDrawSidearts() {
	with UberCont {
		var n = max_view_width / 64,
			nh = ceil(view_height / 64) + 1
		
		// hori
	    for (var i = 1; i <= n; i++) {
	        var yy = 0
			
	        repeat nh {
	            draw_sprite(sprSideArt, opt_sideart, i * -64, yy)
	            draw_sprite(sprSideArt, opt_sideart, view_width - 64 + i * 64, yy)
				
	            yy += 64
	        }
		}
		
		// verti
		for(var i = 0; i < n; i ++) {
			var yy = 0
			
			repeat 10 {
				draw_sprite(sprSideArt, opt_sideart, i * 64, -64 - yy)
				draw_sprite(sprSideArt, opt_sideart, i * 64, view_height + yy)
				
				yy += 64
			}
		}
    }
}