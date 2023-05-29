# Nuclear Throne Recreated
Open source rebuild of Nuclear Throne and [mobile port](https://toncho.itch.io/nuclear-throne-mobile/)

[Nuclear Throne](https://nuclearthrone.com) is a game owned by [Vlambeer](https://vlambeer.com/). All rights reserved.

Primary reason why this exists is mobile support - allowing much wider range of people to experience Nuclear Throne, which is being an amazing game.

Recreation is based off decompiled version of update 19th with 99%+ of everything from modern versions being reimplemented on top.

The source is public for educational and modding purposes.
Using [GMEdit](https://yellowafterlife.itch.io/gmedit) is recommended for convenient exploration.

# Legal and foreword to building
Sadly you can't run this project from source as is due to legal reasons. Vlambeer respect work of their team and contributors.

It's not allowed to provide any alternative downloads and the tool for extracting resources and packing them back is not ready yet.

Not to mention that the resources are the only thing that's prohibited from being public. You can make your workarounds from here.

# Building
 Building from this source is only possible with GameMakerStudio 2.

## Android
(Any config should work actually, this is just how I have set it up for releasing builds)

 * Build Tools: 28.0.3
 * Support Library: 28.0.1
 * Target SDK: 28
 * Minimum SDK: 16,
 * Compile SDK: 28
 * NDK: r23 or r24

If you'd like to be able to access external storage, downgrade your IDE and Runtime the following:
 * IDE: v2.3.7.606
 * Runtime: 2.3.7.476

Newer versions will follow newest Google Play requirements, not allowing to use deprecated SDK.

Download SDK & NDK using [AndroidStudio](https://developer.android.com/studio/)

## Other platforms
 * Windows doesn't require anything special. The game even has support for Mouse + Keyboard controls.
 * [Ubuntu](https://help.yoyogames.com/hc/en-us/articles/235186168-Setting-Up-For-Ubuntu)
 * [iOS](https://help.yoyogames.com/hc/en-us/articles/115001368747-Setting-Up-For-iOS-Including-iPadOS-) (no official builds were made to this)
 * [Mac](https://help.yoyogames.com/hc/en-us/articles/235186128-Setting-Up-For-macOS) (there too)

(actually could've just said you can follow official Setting Up guides by YoYo smh)

# Contributing
 Contributions are welcomed, unless your changes interfere recreation's purity too much (meaning, adding new content is undesired - instead you should create mods).
 
 You can also credit yourself [here](https://github.com/toarch7/nt-recreated-public/blob/main/objects/Credits/Create_0.gml) if you have done any substantial changes.
 
 You can help not only with the code, but also by improving or adding localizations. If you've contributed to a localization, mention yourself in credits accordingly.

# Distributing
 Requirements of usermade builds weren't strictly stated, but the general rules are:
 * No form of monetary barrier should exist to access the game, content and source
 * You should not remove any Vlambeer or Nuclear Throne branding
 * You must clearly state that this is not an official build of Nuclear Throne and this is not a work of collaboration with Vlambeer
 * Distribuing the game with official assets is purely on your own risk. Vlambeer won't take actions unless you do something really weird.
