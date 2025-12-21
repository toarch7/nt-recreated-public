//instance_create(x + 16, y, TopSmall)
//instance_create(x - 16, y, TopSmall)
//instance_create(x, y + 16, TopSmall)
//instance_create(x, y - 16, TopSmall)

//instance_create(x + 16, y - 16, TopSmall)
//instance_create(x - 16, y + 16, TopSmall)
//instance_create(x + 16, y + 16, TopSmall)
//instance_create(x - 16, y - 16, TopSmall)

instance_create(x, y, TopSmall)
instance_create(x + 16, y, TopSmall)
instance_create(x, y + 16, TopSmall)
instance_create(x + 16, y + 16, TopSmall)

instance_destroy()