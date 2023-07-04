/// @description Sidearts

if opt_sideart > 0 {
    var n = max_view_width / 64
    var nh = ceil(view_height / 64) + 1

    for (var i = 1; i <= n; i++) {
        var yy = 0

        repeat nh {
            draw_sprite(sprSideArt, opt_sideart, i * -64, yy)
            draw_sprite(sprSideArt, opt_sideart, view_width - 64 + i * 64, yy)

            yy += 64
        }
    }
}