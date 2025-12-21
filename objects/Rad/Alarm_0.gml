if blink > 0 {
	visible ^= 1
	alarm[0] = 2
	blink --
}
else instance_destroy()