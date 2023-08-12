function scrDrawBloom() {
    gpu_set_blendmode(bm_add)

    with NothingBeam {
        if !charge {
            if !disappear {
                draw_sprite_ext(sprNothingBeam, anim, x, (creator.y + 48), 2, 2, image_angle, c_white, 0.1)
                draw_sprite_ext(sprNothingBeamStretch, - 1, x, y, 2, image_yscale, 0, c_white, 0.1)
            } else {
                draw_sprite_ext(sprNothingBeamStop, anim, x, (creator.y + 48), 2, 2, image_angle, c_white, 0.1)
            }
        }
    }

    with Rocket {
        if active {
            draw_sprite_ext(sprRocketFlame, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
        }
    }

    with(JockRocket) {
        if active {
            draw_sprite_ext(sprRocketFlame, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
        }
    }

    with(Bullet1)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(NothingBeamParticle)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(NothingBeamChargeParticle)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(NothingBeamHit)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(UltraShell)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(FlameBall)
    draw_sprite_ext(sprite_index, - 1, x, y, (image_xscale * 2), (image_xscale * 2), image_angle, c_white, 0.1)
    with(UltraBullet)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(LHBouncer)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(HeavyBullet)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(HeavySlug)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(ToxicGas)
    draw_sprite_ext(sprite_index, - 1, x, y, (image_xscale * 2), (image_yscale * 2), image_angle, c_white, 0.1)
    with(MomProjectile)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(Deflect)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(Bullet2) {
        if (bonus == 1) draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.3)
        draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    }

    with(GroundFlame)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(FlameShell)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(HorrorBullet)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(ExploguardianBullet)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(LightningBall)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(LaserCannon)
    draw_sprite_ext(sprite_index, - 1, x, y, (image_xscale * 2), (image_yscale * 2), image_angle, c_white, 0.1)
    with(Lightning)
    draw_sprite_ext(sprite_index, - 1, x, y, image_xscale, (image_yscale * 2), image_angle, c_white, 0.1)
    with(FlakBullet)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(EnemyFlak)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(SuperFlakBullet)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(PlasmaBig)
    draw_sprite_ext(sprite_index, - 1, x, y, (image_xscale * 2), (image_xscale * 2), image_angle, c_white, 0.1)
    with(PlasmaHuge)
    draw_sprite_ext(sprite_index, - 1, x, y, (image_xscale * 2), (image_xscale * 2), image_angle, c_white, 0.1)
    with(PlasmaBall)
    draw_sprite_ext(sprite_index, - 1, x, y, (image_xscale * 2), (image_xscale * 2), image_angle, c_white, 0.1)
    with(PopoPlasma)
    draw_sprite_ext(sprite_index, - 1, x, y, (image_xscale * 2), (image_xscale * 2), image_angle, c_white, 0.1)
    with(PlasmaImpact)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(EnemyBullet3)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(BouncerBullet)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(Slug)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(HyperSlug)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(Disc)
    draw_sprite_ext(sprite_index, - 1, xprevious, yprevious, 1, 1, image_angle, c_white, 0.1)
    with(Laser) {
        draw_sprite_ext(sprite_index, - 1, x, y, image_xscale, 3, image_angle, c_white, 0.1)
        draw_sprite_ext(sprLaserStart, img, xstart, ystart, 3, 3, image_angle, c_white, 0.1)
        draw_sprite_ext(sprLaserEnd, img, x, y, 3, 3, image_angle, c_white, 0.1)
    }

    with(EnemyLaser) {
        draw_sprite_ext(sprite_index, - 1, x, y, image_xscale, 3, image_angle, c_white, 0.1)
        draw_sprite_ext(sprEnemyLaserStart, img, xstart, ystart, 3, 3, image_angle, c_white, 0.1)
        draw_sprite_ext(sprEnemyLaserEnd, img, x, y, 3, 3, image_angle, c_white, 0.1)
    }

    for (var i = 0; i < ds_list_size(global.floor_screen); i++) {
        with(global.floor_screen[| i]) {
            if (sprite_index == sprFloor2B) draw_sprite_ext(sprFloor2BBloom, image_index, x, y, 1, 1, image_angle, c_white, 0.1)
            if (sprite_index == sprFloor102B) draw_sprite_ext(sprFloor102BBloom, image_index, x, y, 1, 1, image_angle, c_white, 0.1)
        }
    }

    with(LaserCharge)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(EnemyBullet1)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(AllyBullet)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(RadChest)
    draw_sprite_ext(sprRadChestGlow, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(EnemyBullet2)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(EnemyBullet3)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(EnemyBullet4)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(IDPDBullet)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(LastBall)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(Throne2Ball)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(Explosion)
    draw_sprite_ext(sprite_index, - 1, x, y, image_xscale * 2, image_yscale * 2, image_angle, c_white, 0.1)
    with(GreenExplosion)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(SmallExplosion)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(Bolt)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(MeatExplosion)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(BulletHit)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(BigGuardianBullet)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(EBulletHit)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(ScorpionBulletHit)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(TrapFire)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(Flame)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(Fireball)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(Portal)
    draw_sprite_ext(sprite_index, - 1, x, y, (2 * image_xscale), (2 * image_yscale), image_angle, c_white, 0.1)
    with(IDPDSpawn)
    draw_sprite_ext(sprite_index, - 1, x, y, (2 * image_xscale), (2 * image_yscale), image_angle, c_white, 0.1)
    with(Rad)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(BigRad)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(GuardianBullet)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(ExploguardianBullet)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(PlasmaTrail)
    draw_sprite_ext(sprite_index, - 1, x, y, 2, 2, image_angle, c_white, 0.1)

    gpu_set_blendmode(bm_normal)
}