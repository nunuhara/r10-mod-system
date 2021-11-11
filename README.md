Mod System for Rance 10
=======================

This is a system for creating Rance 10 mods. In this system, multiple mods are
able to coexist within the same game and build upon each other.

A mod designed for this system is just a directory containing the source code,
images and other data needed by the mod. The installation process for a mod is
to simply copy the directory into the correct location and run a build script
to rebuild the modded game files. Example mods can be found in the `examples`
directory.

In addition to defining a standard format for creating mods, this project also
comes with a library of useful functions and hooks to make common modding tasks
easier. The code for this library can be found at `src/system`.

Installation
------------

Grab the latest release from the [releases](https://github.com/nunuhara/r10-mod-system/releases)
page and extract it to your Rance 10 game directory. The directory containing
the files `build.bat` and `build.sh` should be one level below the main game
directory. E.g.

    Rance 10/
        Rance10.ain
        Mods/
            build.bat
            build.sh
            ...
        ...

On Windows, a compatible build of alice-tools should be included with the
release, so no further action is required here.

On linux, you must compile [alice-tools](https://github.com/nunuhara/alice-tools)
and put the `alice` binary somewhere on your PATH. alice-tools >= 0.11.0 is
required.

Building
--------

Each time a mod is added or removed, the build script must be run to rebuild
the the modded game files. On windows, this script is called `build.bat`.
On linux, use `build.sh` instead. The script should be run from the same
directory that it is located in.

Installing Mods
---------------

Mods are installed into the `src` directory. For example, to install the
example chibi restoration mod, you would copy the directory `examples/chibi`
to `src/chibi`. Once you've installed a mod, you must run the build script
as described above.

Creating Mods
-------------

Each mod should contain a file named `source.inc` which describes the files to
be included in the mod. The contents of this file should look something like
this:

    Source = {
        "code.jaf",
        "data.txtex",
    }

    CG = { "png", "png", "qnt", "qnt" }

With this `source.inc`, the following occurs during the build process:
* The source code file `code.jaf` is compiled and added to `Rance10.ain`
* The static data file `data.txtex` is packed and added to `Rance10ModEX.ex`
* The .png images in the `png` directory are converted to the .qnt format and
  stored in the `qnt` directory
* The .qnt files in the `qnt` directory are added to `Rance10ModCG.afa`

Study the mods in the `examples` directory and the code in `src/system` to get
a better idea of how to write mods. In order to create a mod that does
something new (i.e. not covered in the examples or supported by the system
library), you will need to study the game's code and data files (Rance10.ain
and Rance10EX.ex, respectively). These files can be dumped with alice-tools.

### Naming

Public functions defined in the `src/system` library have the prefix `ML_`
(Mod Library). Functions beginning with `_ML_` are private and should not
be used by mods.

Functions beginning with `ML_HOOK_` are meant to be overriden by mods, e.g.
to run code at startup, you can override the `ML_HOOK_init` function:

    override void ML_HOOK_init(void)
    {
        initialize_my_mod();
        super();
    }

You should always call the `super` function at the end when overriding these
functions so that other mods can use the same hooks.

Bugs
----

The compiler used to build .jaf source code files is not very mature and it is
very possible that you will encounter bugs if you stray from the well-trodden
path. Please report any bugs in the compiler via the issue tracker at the
[alice-tools](https://github.com/nunuhara/alice-tools) repository.

Disclaimer
----------

The Rance series and associated intellectual property is owned by AliceSoft.
