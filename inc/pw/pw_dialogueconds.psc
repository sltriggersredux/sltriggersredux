scriptname pw_dialogueconds extends quest  conditional
event oninit()
endevent
event setdgcond(string c, bool v)
endevent
bool property hasenough = false auto conditional ;checked when determining if the player has enough gold for something
bool property isfinished = false auto conditional ;checked when determining if the player has finished duty
bool property overtimereported = false auto conditional
bool property voluntary = false auto conditional
bool property isrape = false auto conditional ;is the player being raped right now
bool property difficultclient = false auto conditional
bool property notpaying = false auto conditional
bool property beggar = false auto conditional
bool property sadisticrape = false auto conditional ;when a sadistic roll ends in an npc raping the player immediately with no pay
bool property solicitfailure = false auto conditional ;the next solicitation will fail
bool property sadisticclient = false auto conditional
function rerollsolicitfailure()
endfunction
function rerollsadisticclient()
endfunction
function rerollclientconds()
endfunction
globalvariable property solicitfailchance auto
globalvariable property sadisticclientchance auto
;This file was cleaned with PapyrusSourceHeadliner 1