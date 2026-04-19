scriptname pw_trackerscript extends pw_scriptcomponent conditional
bool property startinenforcedmode = false auto
pw_modintegrationsscript property mods auto
pw_dialogueconds property dgconds auto
location[] property pwcities auto
actor[] property pwthanes auto
faction property pw_thanefaction  auto  
referencealias property localpwthane auto  ;who the thane is in the player's current or last location
referencealias property localjarl auto
objectreference[] property citycentermarkers auto
int[] property citystatuses auto
quest[] property introquests  auto  
location property currentloc auto  ;the location the player is currently in
int property currentlocindex auto conditional ;the index of the player's current location in the cities array. much easier and cheaper to use than the location, this gets used a lot
int property lastlocindex auto ;displays the last valid locindex the player was in - often the same as currentlocindex, less volatile than currentlocindex
bool property currentpunishmentdue auto conditional
bool property iswhoreanywhere = false auto conditional  ;whether the player is currently the whore anywhere. useful for various things.
miscobject property gold auto
imagespacemodifier property fadetoblack auto
magiceffect property cantleaveeffect auto
spell property cantleavespell auto
bool property cantleave = false auto conditional  ;if the player can leave before quota is met
int property extensiveupdatethreshold = 10 auto
int property extensiveupdatecounter = 0 auto
bool[] property hasbeenwhore auto  ;whether, in each hold, the player has ever been the pw
bool property hasbeenwhorehere = false auto conditional ;whether the player has ever been pw in current location
referencealias[] property jarlaliasscripts auto
keyword property pwholdstatuskeyword auto
bool[] property sscityenabled auto
faction[] property crimefactions  auto  
referencealias property playerfollower auto ;todo why the fuck is this here, and its handling in main
int property loc_none = -1 auto
int property loc_dawnstar = 0 auto
int property loc_falkreath = 1 auto
int property loc_markarth = 2 auto
int property loc_morthal = 3 auto
int property loc_riften = 4 auto
int property loc_solitude = 5 auto
int property loc_whiterun = 6 auto
int property loc_windhelm = 7 auto
int property loc_winterhold = 8 auto
function initialize()
endfunction
function startup()
endfunction
event onupdategametime()
endevent
event updatelocinfoevent()
endevent
function updatelocinfo(string calledfrom = "undef")
endfunction
int function getlocindexfromlocation(location locarg)
endfunction
event checktimecomponents()
endevent
function updateiswhoreanywhere()
endfunction
event makeeligible(int locindex)
endevent
event makeeligiblelocal()
endevent
int function getcurrentstatus()
endfunction
int function getstatus(int locindex)
endfunction
function setstatus(int locindex, int status)
endfunction
event makepublicwhorelocal()
endevent
event makepublicwhore(int locindex)
endevent
event makepublicwhoreadvanced(int locindex, int specificquota, bool enforcedmode)
endevent
event makepublicwhoreselfcontained(int locindex, bool ssstart)
endevent
event clearstatus(int locindex)
endevent
event setenforcedmode(int locindex)
endevent
event clearenforcedmode(int locindex)
endevent
event pw_ssstart(string eventname, string strarg, float numarg, form sender)
endevent
int function getvalidssindex()
endfunction
event clearstatuslocal()
endevent
event clearallstatuses()
endevent
int function scrublocindex(int locindex)
endfunction
actor function getjarl(int locindex)
endfunction
function printjarls()
endfunction
function addbountylocal(int bounty, bool violent)
endfunction
function addbounty(int locindex, int bounty, bool violent)
endfunction
function trackerdebugfunc()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1