scriptname sl_triggersCmdLibTNG

import sl_triggersStatics

; sltname tng_can_modify_actor
; sltgrup The New Gentleman (TNG)
; sltdesc Returns: int: value indicating whether the actor can be modified (presumably 0 - false, 1 - true, but I have not confirmed the API result)
; sltargs Form: actor: the Actor target for the TNG call
Function tng_can_modify_actor(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int outcome = 0

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor akActor = CmdPrimary.ResolveActor(param[1])
        outcome = sl_triggersAdapterTNG.CanModifyActor(akActor)
    endif

    CmdPrimary.MostRecentIntResult = outcome

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname tng_get_actor_size
; sltgrup The New Gentleman (TNG)
; sltdesc Returns: int: -1 if there is an issue, 0-based size category otherwise
; sltargs Form: actor: the Actor target for the TNG call
Function tng_get_actor_size(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int outcome = -1

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor akActor = CmdPrimary.ResolveActor(param[1])
        if akActor
            outcome = sl_triggersAdapterTNG.GetActorSize(akActor)
        endif
    endif

    CmdPrimary.MostRecentIntResult = outcome

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname tng_set_actor_size
; sltgrup The New Gentleman (TNG)
; sltargs Form: actor: the Actor target for the TNG call
; sltargs int: sizeCat: the size category you wish to assign to the target
Function tng_set_actor_size(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int outcome = -1

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor akActor = CmdPrimary.ResolveActor(param[1])
        if akActor
            int aiSizeCat = CmdPrimary.ResolveInt(param[2])
            outcome = sl_triggersAdapterTNG.SetActorSize(akActor, aiSizeCat)
        endif
    endif

    CmdPrimary.MostRecentIntResult = outcome

	CmdPrimary.CompleteOperationOnActor()
endFunction