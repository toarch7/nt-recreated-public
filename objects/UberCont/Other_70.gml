if opt_gamepad or volqueue == -1 exit

ds_queue_enqueue(volqueue, [async_load[? "type"], async_load[? "volume"]])