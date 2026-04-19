scriptname pw_modintegrationsscript extends pw_scriptcomponent conditional
bool property isslainstalled = false auto
bool property isslsfinstalled = false auto
bool property isddinstalled  = false auto
bool property isslavetatsinstalled = false auto
bool property isfadetattoosinstalled = false auto
bool property iszazinstalled = false auto
bool property isstainstalled = false auto
bool property issdplusinstalled = false auto
bool property issltrinstalled = false auto
bool property issimpleslaveryinstalled = false auto
bool property usingsla = true auto conditional
bool property usingslsf = true auto conditional
bool property usingdd = true auto conditional
bool property usingslavetats = true auto conditional
bool property usingzaz = true auto conditional
bool property usingsdplus = true auto conditional
bool property usingsltr = true auto conditional
bool property usingsimpleslavery = true auto conditional
actor property torturerm auto
actor property torturerf auto
int property tattoomode = 0 auto
armor property zbfwristleatherbinds auto
armor property zbfgag auto
function initialize()
endfunction
function startup()
endfunction
event checktimecomponents()
endevent
bool function checkmodinstalled(string pluginname) ;checks a plugin by esp name, returns whether the esp is installed
endfunction
function collarplayer()
endfunction
function removecollar()
endfunction
function removerestraints(armor which) ;not working
endfunction
function gagplayer()
endfunction
function unequipgag()
endfunction
function equipankleshackles()
endfunction
function equipyoke()
endfunction
function unequipyoke()
endfunction
function equipwristbinds()
endfunction
function equipvaginalpiercing()
endfunction
function unequipvaginalpiercing()
endfunction
function unequipwristbinds()
endfunction
furniture function getzazfurniture(string which)
endfunction
weapon function getzazweapon(string which)
endfunction
function initializegallows(objectreference which)
endfunction
function disableddgagdialogue(actor who)
endfunction
bool function addslavetat(int locindex)
endfunction
function removeslavetat(int locindex)
endfunction
function unequipalldd()
endfunction
bool function isplayerenslaved()
endfunction
event sdslaverystarted(string eventname, string strarg, float numarg, form sender)
endevent
event sdslaverystopped(string eventname, string strarg, float numarg, form sender)
endevent
bool function sendtosltr()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1