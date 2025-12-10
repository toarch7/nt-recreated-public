function scrShadows() {
	//shadow works

	if instance_exists(GenCont) exit

	if !surface_exists(shad) {
		shad = surface_create(view_width, view_height)
		surface_set_target(shad)
		draw_clear_alpha(c_black, 0)
		surface_reset_target()
	}

	surface_set_target(shad)
	draw_clear_alpha(c_black, 0)
	
	var _xview = view_xview, _yview = view_yview
	
	#region Walls
	
	var _list = global.lis_walls_visible,
		_count = ds_list_size(_list)
		
	for (var i = _count - 1; i >= 0; --i) {
		with _list[| i] {
			if !position_meeting(x, y + 16, TopSmall) {
				draw_sprite_ext(outspr, outindex, x - _xview, y + 2 + 16 - _yview, 1, -1, 0, c_black, 1)
			}
		}
	}
	
	#endregion
	
	with CrownObject {
		if (visible) draw_sprite(shd16, 0, x - _xview, y - _yview + 3)
	}
		
	with CrownPickup {
		draw_sprite(shd16, 0, x - _xview, y - _yview + 3)
	}
		
	with CarThrow {
		draw_sprite(shd32, 0, x - _xview, y - _yview)
	}
		
	with CampChar {
		draw_sprite(spr_shadow, 0, x - _xview, y - _yview)
	}
	
	with chestprop {
		draw_sprite(spr_shadow, 0, x - _xview + spr_shadow_x, y - _yview + spr_shadow_y)
	}
	
	with BigWeaponChest {
		draw_sprite(shd32, 0, x - _xview, y - _yview)
	}
	
	with SnowBotCar {
		draw_sprite(shd32, 0, x - _xview, y - _yview)
	}
	
	with BigDogExplo {
		draw_sprite(shd96, 0, x - _xview, y - _yview)
	}
	
	with CrystalShield {
		if (image_speed == 0) draw_sprite(shd64, 0, x - _xview, y - _yview + 2)
	}

	with hitme {
		if (visible) draw_sprite(spr_shadow, 0, x - _xview + spr_shadow_x, y - _yview + spr_shadow_y)
	}

	with LilHunterFly {
		draw_sprite(spr_shadow, 0, x - _xview + spr_shadow_x, y - _yview + spr_shadow_y)
	}
		
	with Yeti {
		if sprite_index != sprYetiBurrowed
		&& (sprite_index != sprYetiAppear || image_index >= 5)
		&& (sprite_index != sprYetiDisappear || image_index < 3) {
			draw_sprite(shd48, 0, x - _xview, y - _yview)
		}
	}
		
	with SodaCan {
		draw_rectangle(x - 2, bbox_bottom, x + 2, bbox_bottom + 2, false)
	}
		
	with RavenFly {
		draw_sprite(spr_shadow, 0, x - _xview + spr_shadow_x, y - _yview + spr_shadow_y)
	}
	
	surface_reset_target()
}