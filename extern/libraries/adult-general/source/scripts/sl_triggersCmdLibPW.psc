scriptname sl_triggersCmdLibPW

import sl_triggersStatics

; sltname pw_is_whore_anywhere
; sltgrup Public Whore
; sltdesc Returns: bool: true if currently the public whore, false otherwise
; sltsamp pw_is_whore_anywhere
; sltsamp msg_console "Currently the public whore? " $$
function pw_is_whore_anywhere(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    CmdPrimary.MostRecentBoolResult = sl_triggersAdapterPW.IsPublicWhoreAnywhere()

    CmdPrimary.CompleteOperationOnActor()
endFunction