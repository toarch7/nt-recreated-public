if opt_gamepad or volqueue == -1 or paused exit

ds_queue_enqueue(volqueue, [async_load[? "type"], async_load[? "volume"]])