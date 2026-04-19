scriptname pw_utility extends quest  
globalvariable property gameday auto
globalvariable property gamehour auto
bool property debugnotificationsenabled = false auto
bool property loggingenabled = true auto
int property debugshowlevel = 2 auto
int property debugmessageboxlevel = 5 auto
string[] property level_strings auto
event oninit()
endevent
event debugmessage(form sender, int level, string msg)
endevent
function pwdebug(form sender, int level, string msg) global
endfunction
function advancetimetonext(int hour)
endfunction
function advancehours(int numofhours)
endfunction
function advancedays(int numofdays)
endfunction
float function gethourstonext(int hour)
endfunction
function removeweapons(actor from, actor to = none) global
endfunction
function setglobal(globalvariable glob, int newvalue) global
endfunction
function sendevent(string eventname) global
endfunction
function sendintevent(string eventname, int value) global
endfunction
function sendstringevent(string eventname, string value) global
endfunction
function sendintintevent(string eventname, int value1, int value2) global
endfunction
function sendintboolevent(string eventname, int intval, bool boolval) global
endfunction
function sendintfloatevent(string eventname, int intval, float floatval) global
endfunction
function sendformevent(string eventname, form formarg) global
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1