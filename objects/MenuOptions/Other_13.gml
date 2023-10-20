/// @description Open profile category (to set nickname/color)

self.category_set(OptionCategory.Game_Profile, false)

var items = options[category]

for(var i = 0; i < array_length(items); i ++) {
	var item = items[i]
	
	if item.key == "etc_name" {
		element_functions.input(item)
		
		break
	}
}

dispose_on_empty = true
