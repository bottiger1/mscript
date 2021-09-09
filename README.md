# mscript

Sourcemod Mscript - Framework for map specific plugins

This plugin will automatically load a plugin with the name of the map in the addons/disabled/mscript directory. 

When the map ends, the plugin will be unloaded. 

For example if you made a plugin in addons/disabled/mscript/ctf_2fort.smx it will be loaded when your server changes to ctf_2fort. 

When the map ends it will be unloaded.

## Why is this needed?

Valve added real scripting languages for mappers called vscript in newer games like l4d and csgo but never bothered to port it back to older games such as TF2. 

While mappers are making use of vscript in these new games, maps in older games are stagnating and some mappers are even changing games so they can use vscripts.

This is not necessary at all, almost anything you can do in vscript is possible in sourcemod and sourcemod can also do things that vscript cannot do.

## Why do you need this plugin to run a plugin

This plugin is simply a framework that makes loading and unloading map specific plugins cleanly. One major reason why people don't want to use plugins is because sourcemod automatically loads them all on startup and then you'd have 20 map specific plugins taking up ram and cpu. This plugin solves that issue completely.

## Commands

These commands are mostly for debugging purposes. You do not need these for normal usage.

- mscript_load [plugin]
Load a plugin in the addons/disabled/mscript directory. Do not add .smx to the end. Plugins with the same name of the map will be loaded automatically so you do not need this unless you want to load more plugins.

- mscript_unload
Unload all plugins loaded through mscript_load this map.

- mscript_reload
Reload all plugins loaded through mscript_load this map.