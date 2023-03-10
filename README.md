# Nuclear Throne Recreated
Open source rebuild of Nuclear Throne and [Android port](https://toncho.itch.io/nuclear-throne-mobile/)

[Nuclear Throne](https://nuclearthrone.com/]) is a game created and owned by [Vlambeer](https://vlambeer.com/). All rights reserved.

The recreation is based on update 19th of the game, which is officially claimed as a version allowed to be decompiled and modded.

General purpose of this modification is a mobile support, to allow much wider range of people to get into Nuclear Throne which is being an amazing game.

The source is public for education and modding reasons. For more convenient exploration I recommend using [GMEdit](https://yellowafterlife.itch.io/gmedit) by YellowAfterlife

# Resources legality and foreword to building
 Unfortunately it is not possible to run project from this source right away, due to an Vlambeer respecting work of their contributors and employees,
not allowing to publicly store (most of) assets made by them unless all rights are cleared by myself.
And, sadly, most of the creators weren't able grant me legal permissions to do so.

I'm not allowed to give any alternative downloads, although you can extract resources from release version of the game yourself with help of [UndertaleModTool](https://github.com/krzys-h/UndertaleModTool) additional tinkering. 

Additionally you can bring your own assets which are fine to be distributed safely.

# Building
 Building from this source is only possible with GameMakerStudio 2.

## Android
Build configurations:
 * Build Tools: 28.0.3
 * Support Library: 28.0.1
 * Target SDK: 28
 * Minimum SDK: 16,
 * Compile SDK: 28
 * NDK: r23 or r24

If you'd like to be able to access external storage, downgrade your IDE and Runtime the following:
 * IDE: v2.3.7.606
 * Runtime: 2.3.7.476

This is needed since newest GooglePlay Requirements (which are followed by default) are essentially restricting most of the storage permissions.

Download SDK & NDK using [AndroidStudio](https://developer.android.com/studio/)

## Other platforms
 * Windows doesn't require anything special
 * Ubuntu (or generally most of Linux distros) build instructions can be viewed [here](https://help.yoyogames.com/hc/en-us/articles/235186168-Setting-Up-For-Ubuntu)
 * Mac and iOS are requiring you to own Apple Developer status (which is around $100 per month). There were no official builds to any apple devices, so I have nothing to say about it

# Contributing
 Contributions are welcomed, unless your changes don't match what is present in release version of the original game.
 
 Please do not commit changes if they're just fixing the syntax and don't contain any actual codebase changes.
 
 If you'd like to be mentioned in credits, you can edit your nickname in at `Credits` object [create event](https://github.com/toarch7/nt-recreated-public/blob/main/objects/Credits/Create_0.gml) as contributor or translator depending on your commit.

# Distributing
 Requirements of usermade builds weren't strictly stated by Vlambeer, but the general rules are:
 * No form of monetary barrier should exists to access the game or any form of content and source
 * You must clearly state that this is not an official build of Nuclear Throne
 * You should not remove any Vlambeer branding
 * You should not proclaim your build is a result of a partnership with original authors
 * Distribuing the game with official assets is purely on your risk. Vlambeer won't take action unless creators are opposite about it
