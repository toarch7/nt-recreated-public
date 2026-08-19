# Nuclear Throne Mobile

Open Source Rebuild and a Free [Android Port](https://toncho.itch.io/nuclear-throne-mobile/) of Nuclear Throne, a Video Game Created by [Vlambeer](https://vlambeer.com/).

This rebuild is based on a decompiled source code of the Nuclear Throne Update #19. The entire project has been mostly rewritten from scratch to match the contents of the latest version of Nuclear Throne.

# Building
> [!WARNING]
> This repo doesn't come with any assets from the original game. In order to make this project buildable, you will need to extract all the assets from your own copy of Nuclear Throne.

This project is built with the GameMaker engine, much so is the original game - therefore, an installation of GameMaker is required.

## Resource extraction
> [!NOTE]
> It is required that you provide your own copy of Nuclear Throne (update 100 and above) for the scripts to work.

There's a set of tools available that would allow you to extract assets directly from your installation of the game. By default[\*](#custom-install-footnote), these tools will look for game files in your Steam library, so no action is needed as long as your Steam library is installed conventionally.

Please make sure that you have NodeJS of version 20.0+ installed on your machine. Resource extraction scripts should work on any platform that supports NodeJS runtime. (You might also need to install `npm` in case if it's not bundled with Node on your platform)

Clone this repository, open your terminal in this folder and run the following commands in your terminal:
```shell
cd node-scripts
npm ci
npm run regen
```

After that, all the assets will be automatically extracted and copied to the GameMaker project in this repository, making it compileable.

Whenever you introduce new assets that weren't part of the project before (for instance, if an update adds a new weapon), you should run `npm run regen-ignores`. This ensures that the resources ignore file is updated, preventing any of the new assets from being included in your commit.

<a name="custom-install-footnote"></a>\(*\): You can specify a custom game installation path by using a parameter when executing the installation script (`npm run regen --game-path="/your/path/here/"`)

## Target platforms

One of the primary goals of this project was portability and accessibility for sorts of platforms (by introducing touch-screen controls and impelmenting keyboard+mouse and controller support). The extent of supported platforms is strictly limited by the engine's export options - GameMaker offers you support for the platforms such as:
- **Desktop**
    - [Windows](https://gamemaker.zendesk.com/hc/en-us/articles/235186048-Setting-Up-For-Windows)
    - [Ubuntu](https://help.yoyogames.com/hc/en-us/articles/235186168-Setting-Up-For-Ubuntu)
    - [macOS](https://help.yoyogames.com/hc/en-us/articles/235186128-Setting-Up-For-macOS)
- **Mobile**
    - [Android](https://help.yoyogames.com/hc/en-us/articles/115001368727-Setting-Up-For-Android)
    - [iOS](https://help.yoyogames.com/hc/en-us/articles/115001368747-Setting-Up-For-iOS-Including-iPadOS-)

And of course the current generation of **Consoles**, but building to consoles requires a special, professional commercial GameMaker license, which is out of this project's scope. *But it is possible.*

HTML5 export is quirky, so it's actively not supported.

# Contributing
You can help with this project by contributing code, localizations, reporting bugs and so on.

There are some regulations for acceptable contributions and code style when contributing to this repo:
- It is allowed to contribute code style improvements __in bulk__ or as long as any substantial changes are introduced along.
- It is **not** allowed to introduce new content, balance changes, or anything that is not coming from the official releases of Nuclear Throne or is not permitted directly by myself. If you would want to consult, you can do that the official [Nuclear Throne Mobile Discord server](https://discord.gg/mMTTrqh).
- There are no super-strict codestyle regulations but some things to point out (GML):
  - Object names are required to be full PascalCase, so are other assets, but each asset name must begin from a prefix (like `spr` for sprites, `snd` for sounds, `scr` for scripts and so on)
  - Functions (scripts) are required to use snake_case and Pascal Case in their names.
    - When you're not certain when you should use snake_case or PascalCase to name your function, refer to the following principle: mostly all gameplay-related functions use Pascal Case (`scrBossIntro`, `scrDrop`, `scrSpawnPlayers`, etc.), meanwhile most of the API functions use Snake Case (`scr_loadout_race_get_stored_weapon`, `scr_projectile_create`, `scr_screenshake`). You may see the current codebase (as of the moment of total rewrite) doesn't follow the provided regulations, which __needs to and will be__ fixed as the development goes.
  - Local variables and function parameters must always start with an underscore `_` symbol
  - Use of Feather type notations is not strictly required, but encouraged
  - Any field, method, instance variable that is prefixed with double underscore `__` should be treated as `private` or `protected` field.
  - Numerical content type IDs must only use enums

# Third-party libraries used
- GML
    - [Input 3](https://github.com/JujuAdams/Input) - input handling, primarily used for gamepad mappings
    - [native_cursor](https://github.com/YAL-GameMaker/native_cursor) - used for native cursors on Desktop platforms
    - [execute_shell_simple](https://github.com/YAL-GameMaker/execute_shell_simple) - used for multiplayer testing; will not be shipped with the final executables
- JavaScript
    - [pngjs](https://github.com/pngjs/pngjs) - reading/writing PNG image data
