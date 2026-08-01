scriptname sl_triggersCmdLibLeashFramework

import sl_triggersStatics

; sltname leash_applyleash
; sltgrup Leash Framework
; sltdesc Returns: bool: true when arguments are valid and the leash is accepted
; sltargs Form: holder: Actor holding the leash; The current attachment bone is NPC R Hand [RHnd]
; sltargs Form: leashed: Actor wearing the leash mesh; An actor can have only one active leash
; sltargs string: parentBone: Exact node name to find on the leashed actor before searching its descendants
; sltargs string: leashBoneMatch: Text found anywhere in each ordered leash bone name beneath parentBone; For example, Main_ matches hdtSSEPhysics_AutoRename_Armor_00000004 Main_01 after SMP renames the node
; sltargs float: minLength: Distance where active leash pulling stops; Must be zero or greater
; sltargs float: maxLength: Maximum holder-to-collar distance; Must be positive and at least minLength
; sltargs bool: persistent: When true, the leash is saved and restored until explicitly disconnected
; sltsamp If you are using the leash included with Leash Framework, here are values used by the mod author in their example
; sltsamp This example would add a leash from the player (as holder) to the script target (as leashed)
; sltsamp NOTE: All parameters must be provided; none are optional
; sltsamp leash_applyleash $system.player $system.self "NPC Spine2 [Spn2]" "Leash1" 200.0 500.0 true
function leash_applyleash(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    bool result = false

    if ParamLengthEQ(CmdPrimary, param.length, 8)
        Actor holder = CmdPrimary.ResolveActor(param[1])
        Actor leashed = CmdPrimary.ResolveActor(param[2])
        string parentBone = CmdPrimary.ResolveString(param[3])
        string leashBoneMatch = CmdPrimary.ResolveString(param[4])
        float minLength = CmdPrimary.ResolveFloat(param[5])
        float maxLength = CmdPrimary.ResolveFloat(param[6])
        bool persistent = CmdPrimary.ResolveBool(param[7])
        if (holder && leashed && parentBone && leashBoneMatch && minLength > 0 && maxLength > 0 && maxLength >= minLength)
            result = sl_triggersAdapterLeashFramework.leash_applyleash(holder, leashed, parentBone, leashBoneMatch, minLength, maxLength, persistent)
        else
            if !holder
                CmdPrimary.SFW("leash_applyleash: could not resolve holder from :" + param[1] + ":")
            endif
            if !leashed
                CmdPrimary.SFW("leash_applyleash: could not resolve leashed from :" + param[2] + ":")
            endif
            if !parentBone
                CmdPrimary.SFW("leash_applyleash: could not resolve parentBone from :" + param[3] + ":")
            endif
            if !leashBoneMatch
                CmdPrimary.SFW("leash_applyleash: could not resolve leashBoneMatch from :" + param[4] + ":")
            endif
            if minLength <= 0
                CmdPrimary.SFW("leash_applyleash: could not resolve minLength > 0 from :" + param[5] + ":")
            endif
            if maxLength <= 0
                CmdPrimary.SFW("leash_applyleash: could not resolve maxLength > 0 from :" + param[6] + ":")
            endif
            if maxLength < minLength
                CmdPrimary.SFW("leash_applyleash: could not resolve minLength <= maxLength from :" + param[5] + "/" + param[6] + ":")
            endif
        endif
    endif

    CmdPrimary.MostRecentBoolResult = result

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname leash_disconnectleash
; sltgrup Leash Framework
; sltdesc Returns: bool: true when the matching leash was disconnected
; sltargs Form: holder: leash holding actor
; sltargs Form: leashed: leashed actor
function leash_disconnectleash(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    bool result = false

    if ParamLengthEQ(CmdPrimary, param.length, 3)
        Actor holder = CmdPrimary.ResolveActor(param[1])
        Actor leashed = CmdPrimary.ResolveActor(param[2])
        if holder && leashed
            result = sl_triggersAdapterLeashFramework.leash_disconnectleash(holder, leashed)
        else
            if !holder
                CmdPrimary.SFW("leash_disconnectleash: could not resolve holder from :" + param[1] + ":")
            endif
            if !leashed
                CmdPrimary.SFW("leash_disconnectleash: could not resolve leashed from :" + param[2] + ":")
            endif
        endif
    endif

    CmdPrimary.MostRecentBoolResult = result

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname leash_unleashall
; sltgrup Leash Framework
; sltdesc Returns: bool: true when at least one leash was disconnected
; sltargs Form: actor: leash holder actor to remove leashes from
function leash_unleashall(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    bool result = false

    if ParamLengthEQ(CmdPrimary, param.length, 2)
        Actor targetActor = CmdPrimary.ResolveActor(param[1])
        if targetActor
            result = sl_triggersAdapterLeashFramework.leash_unleashall(targetActor)
        else
            CmdPrimary.SFW("leash_unleashall: could not resolve actor from :" + param[1] + ":")
        endif
    endif

    CmdPrimary.MostRecentBoolResult = result

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname leash_isleashed
; sltgrup Leash Framework
; sltdesc Returns: bool: true when actor currently has an active leash
; sltargs Form: actor: actor to check leashed status of
function leash_isleashed(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    bool result = false

    if ParamLengthEQ(CmdPrimary, param.length, 2)
        Actor targetActor = CmdPrimary.ResolveActor(param[1])
        if targetActor
            result = sl_triggersAdapterLeashFramework.leash_isleashed(targetActor)
        else
            CmdPrimary.SFW("leash_isleashed: could not resolve actor from :" + param[1] + ":")
        endif
    endif

    CmdPrimary.MostRecentBoolResult = result

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname leash_isleashholder
; sltgrup Leash Framework
; sltdesc Returns: bool: true when actor currently holds at least one active leash
; sltargs Form: actor: actor to check leash holder status of
function leash_isleashholder(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    bool result = false

    if ParamLengthEQ(CmdPrimary, param.length, 2)
        Actor targetActor = CmdPrimary.ResolveActor(param[1])
        if targetActor
            result = sl_triggersAdapterLeashFramework.leash_isleashholder(targetActor)
        else
            CmdPrimary.SFW("leash_isleashholder: could not resolve actor from :" + param[1] + ":")
        endif
    endif

    CmdPrimary.MostRecentBoolResult = result

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname leash_getleashholder
; sltgrup Leash Framework
; sltdesc Returns: Form: Actor: actor holding leashed's active leash, or None when leashed has no active leash
; sltargs Form: leashed: leashed actor to get leash holder from
function leash_getleashholder(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    Form result = none

    if ParamLengthEQ(CmdPrimary, param.length, 2)
        Actor targetActor = CmdPrimary.ResolveActor(param[1])
        if targetActor
            result = sl_triggersAdapterLeashFramework.leash_getleashholder(targetActor)
        else
            CmdPrimary.SFW("leash_getleashholder: could not resolve actor from :" + param[1] + ":")
        endif
    endif

    CmdPrimary.MostRecentFormResult = result

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname leash_getleashedactors
; sltgrup Leash Framework
; sltdesc Returns: Form[]: Actor[]: every actor currently leashed to holder. Returns an empty array when holder has no active leashes
; sltargs Form: holder: leash holder to get leashed actors from
function leash_getleashedactors(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    Form[] result = PapyrusUtil.FormArray(0)

    if ParamLengthEQ(CmdPrimary, param.length, 2)
        Actor targetActor = CmdPrimary.ResolveActor(param[1])
        if targetActor
            Actor[] actorList = sl_triggersAdapterLeashFramework.leash_getleashedactors(targetActor)
            result = ActorArrayToFormArray(actorList)
        else
            CmdPrimary.SFW("leash_getleashedactors: could not resolve actor from :" + param[1] + ":")
        endif
    endif

    CmdPrimary.MostRecentListFormResult = result

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname leash_getminleashlength
; sltgrup Leash Framework
; sltdesc Returns: float: minimum length of leashed's active leash, or -1.0 when leashed has no active leash
; sltargs Form: actor: actor to get min leash length of
function leash_getminleashlength(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float result = -1

    if ParamLengthEQ(CmdPrimary, param.length, 2)
        Actor targetActor = CmdPrimary.ResolveActor(param[1])
        if targetActor
            result = sl_triggersAdapterLeashFramework.leash_getminleashlength(targetActor)
        else
            CmdPrimary.SFW("leash_getminleashlength: could not resolve actor from :" + param[1] + ":")
        endif
    endif

    CmdPrimary.MostRecentFloatResult = result

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname leash_getmaxleashlength
; sltgrup Leash Framework
; sltdesc Returns: float: maximum length of leashed's active leash, or -1.0 when leashed has no active leash
; sltargs Form: actor: actor to get max leash length of
function leash_getmaxleashlength(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float result = -1

    if ParamLengthEQ(CmdPrimary, param.length, 2)
        Actor targetActor = CmdPrimary.ResolveActor(param[1])
        if targetActor
            result = sl_triggersAdapterLeashFramework.leash_getmaxleashlength(targetActor)
        else
            CmdPrimary.SFW("leash_getmaxleashlength: could not resolve actor from :" + param[1] + ":")
        endif
    endif

    CmdPrimary.MostRecentFloatResult = result

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname leash_setminleashlength
; sltgrup Leash Framework
; sltdesc Returns: bool: false when leashed has no active leash or newLength is invalid
; sltargs Form: actor: actor to set min leash length for
; sltargs float: newLength: new min length for actor leash
function leash_setminleashlength(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    bool result = false

    if ParamLengthEQ(CmdPrimary, param.length, 3)
        Actor targetActor = CmdPrimary.ResolveActor(param[1])
        if targetActor
            result = sl_triggersAdapterLeashFramework.leash_setminleashlength(targetActor, CmdPrimary.ResolveFloat(param[2]))
        else
            CmdPrimary.SFW("leash_setminleashlength: could not resolve actor from :" + param[1] + ":")
        endif
    endif

    CmdPrimary.MostRecentBoolResult = result

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname leash_setmaxleashlength
; sltgrup Leash Framework
; sltdesc Returns: bool: false when leashed has no active leash or newLength is invalid
; sltargs Form: actor: actor to set max leash length for
; sltargs float: newLength: new max length for actor leash
function leash_setmaxleashlength(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    bool result = false

    if ParamLengthEQ(CmdPrimary, param.length, 3)
        Actor targetActor = CmdPrimary.ResolveActor(param[1])
        if targetActor
            result = sl_triggersAdapterLeashFramework.leash_setmaxleashlength(targetActor, CmdPrimary.ResolveFloat(param[2]))
        else
            CmdPrimary.SFW("leash_setmaxleashlength: could not resolve actor from :" + param[1] + ":")
        endif
    endif

    CmdPrimary.MostRecentBoolResult = result

    CmdPrimary.CompleteOperationOnActor()
endFunction