# Nuclear Throne Recreated
Open source rebuild and [android port](https://toncho.itch.io/nuclear-throne-mobile/) of Nuclear Throne.

[Nuclear Throne](https://nuclearthrone.com) is a game created and owned by [Vlambeer](https://vlambeer.com/). All rights reserved.

Recreation is based off decompiled version of update 19th with 99%+ of everything from present version being restored. Primary reason of this' existence for me is to have fun, - but having fun all only by yourself is lame, so now this project allows much wider range of people experience Nuclear Throne, which is being an amazing game, on their mobile devices.

The public source is for *educational* and modding purposes.
Using [GMEdit](https://yellowafterlife.itch.io/gmedit) is recommended for convenient exploration.

# Building
 Building from this source is only possible with GameMaker (aka GameMaker Studio 2).
 
 As of this moment you have to extract all resources manually from your own copy of the game.
 Please do not use any official build of the recreation for assets extraction.

## Android
 For building on modern versions of the engine you can follow an [official article](https://help.yoyogames.com/hc/en-us/articles/115001368727-Setting-Up-For-Android).

Downgrade your IDE and Runtime the following way
 * IDE: v2.3.7.606
 * Runtime: 2.3.7.476

Download all necessary build tools from [AndroidStudio](https://developer.android.com/studio/).
In IDE, set these build params
 * Build Tools: 28.0.3
 * ~~Support Library: 28.0.1~~
 * Target SDK: 28
 * Minimum SDK: 16
 * Compile SDK: 28
 * NDK: r23 or r24

## Other platforms
 * [Ubuntu](https://help.yoyogames.com/hc/en-us/articles/235186168-Setting-Up-For-Ubuntu)
 * [iOS](https://help.yoyogames.com/hc/en-us/articles/115001368747-Setting-Up-For-iOS-Including-iPadOS-)
 * [Mac](https://help.yoyogames.com/hc/en-us/articles/235186128-Setting-Up-For-macOS)

# Contributing
 Contributions are welcomed, unless your changes boldly dismatch contents of the original game.
 
 You add youself to the credits [here](https://github.com/toarch7/nt-recreated-public/blob/main/objects/Credits/Create_0.gml) if any substantial changes were made.
 
 **You can help not only by contributing code, but also by improving or adding localizations.** If you've contributed to a localization, mention yourself in credits accordingly.

# Libraries used
 [Input 3](https://github.com/JujuAdams/Input)

 [native_cursor](https://github.com/YAL-GameMaker/native_cursor)

 [execute_shell_simple](https://github.com/YAL-GameMaker/execute_shell_simple)
