# Types of Integration

SLTR has been expanded to allow more external interaction, meaning rather than only being able to trigger scripts from the built-in triggered events in SLTR, mod and modpack authors can use SLT with their mods, expanding the functionality of other mods without having to modify them.

Let's look over some of the approaches you can take to request scripts be run by SLT.

## Asking SLTR To Run Scripts

### ModEvent
#### OnSLTRequestCommand
`"OnSLTRequestCommand"`

usage:
- `targetedActor.SendModEvent("OnSLTRequestCommand", "scriptname")`
  - if everything checks out (valid script, valid actor, etc.), the script will begin executing on the targetedActor

#### OnSLTRequestList
`"OnSLTRequestList"` (available v111)

usage: 
- If your list should be attached via StorageUtil to the Form that sends the mod event, either pass 0.0 as the float argument or let it default
  - `FormYouWantStorageUtilDataAnchoredTo.SendModEvent("OnSLTRequestList", "yourStorageUtilStringListKey")`
- If your list should be attached via StorageUtil to the the global namespace, pass the value `1.7` (yes, specifically `1.7`, I am weird that way)
  - `FormYouWantStorageUtilDataAnchoredTo.SendModEvent("OnSLTRequestList", "yourStorageUtilStringListKey", 1.7)`
- Upon receiving the event, SLTR will populate the indicated StorageUtil key with the list of commands.
- If you put an event name in the first index of the list prior to calling, SLTR will also fire that event back to you once the list is populated.

### API
If you would prefer to script against an API, SLTR provides `sl_triggersAPI`, and ships with a file, `sl_triggersAPI.psc.headeronly` which, as the name implies, includes only the headers, convenient for including in your builds.

The API includes the following functions:

- `int GetVersion() global` - returns the SLTR mod version number
- `string[] GetScriptsList() global` - returns the list of SLTR scripts available for execution
- `RunScript(string _scriptname, Actor _theActor = none)` - executes the requested SLTScript on the specified Actor; defaults to the Player if not specified; uses the ModEvent approach

### Console Command
If console commands are more your style, those are available as well.

If [ConsoleUtil Extended](https://www.nexusmods.com/skyrimspecialedition/mods/133569) is found, that will be used, otherwise, the current approach hooks the console window and watches for error messages when my slt command is run, then does the work and repaints the text of the console window with happy friendly SLTR messages. I am not sure this will work if scripted via Papyrus script and something like ConsoleUtil-Extended (which allows you to run custom console commands from Papyrus script calls). But manually it's just fine. See the [Console Commands page](https://github.com/lynnpye/sl_triggers/wiki/Console-Commands) for usage info.

### Extension
And for the more adventurous souls, you can create an SLTR extension. I will create an example in the future, but for now, you can look at sl_triggersExtensionCore.psc (and the base class for it, sl_triggersExtension.psc) for fairly simple examples. See the [Extensions page](https://github.com/lynnpye/sl_triggers/wiki/Extensions) for more details.

## Asking SLTR to Interact With Your Mod
As you can imagine, extending SLTR's abilities to include interacting with a new mod is a little more involved and technical than reaching out and asking it to do what it already knows how to do well. In essence, the only way SLTR can interact with other mods is through the operations performed in SLTScripts.

### Tapping Into Existing Functionality
SLTR already offers script authors the ability to send mod events, so documenting any such interfaces cleanly will obviously help.

### Creating a Function Library
If you want to maximize the ability for SLTR to operate on your mod and don't want to wait for an SLTR maintainer to add the functionality into the base library, you can create a function library. A function library is nothing more than a compiled .psc (i.e. .pex file) with global functions having specific signatures required by SLTR, along with a simple JSON file placed in an sl_triggers folder to let it know of the library's existence. See the [Function Libraries](https://github.com/lynnpye/sl_triggers/wiki/Function-Libraries) page for more details.

Although it requires Papyrus scripting knowledge, if you are already a mod author looking to create an integration between SLTR and your mod, you probably already have the necessary scripting skills. If not, feel free to ask for some assistance. :)