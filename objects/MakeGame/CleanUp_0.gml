if gamestatebuffer_c != -1
	buffer_delete(gamestatebuffer_c)

if gamestatebuffer != -1
	buffer_delete(gamestatebuffer)

if skills != -1
	ds_list_destroy(skills)