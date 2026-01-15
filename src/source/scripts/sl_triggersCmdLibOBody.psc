scriptname sl_triggersCmdLibOBody

import sl_triggersStatics

; sltname obody_assignpresetbyfile
; sltgrup OBody
; sltdesc Form: actor: target Actor
; sltdesc string: presetFile: path to preset file e.g. "Data\\CalienteTools\\BodySlide\\SliderPresets\\Teru Apex V2 3BBB.xml"
; sltdesc Assigns the preset to the actor
; sltsamp obody_assignpresetbyfile $system.player "CBBE Curvy"
function obody_assignpresetbyfile(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            string _targetPreset = CmdPrimary.ResolveString(param[2])
            sl_triggersAdapterOBody.ApplyPresetByFile(_targetActor, _targetPreset)
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endfunction

; sltname obody_assignpresetbyname
; sltgrup OBody
; sltdesc Form: actor: target Actor
; sltdesc string: presetName: name of the preset e.g. "CBBE Curvy"
; sltdesc Assigns the preset to the actor
; sltsamp obody_assignpresetbyname $system.player "CBBE Curvy"
function obody_assignpresetbyname(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            string _targetPreset = CmdPrimary.ResolveString(param[2])
            sl_triggersAdapterOBody.ApplyPresetByName(_targetActor, _targetPreset)
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endfunction

; sltname obody_markforreprocess
; sltgrup OBody
; sltdesc Form: actor: target Actor
; sltdesc Marks the actor for OBody reprocessing (whatever that does)
; sltsamp obody_markforreprocess $system.player
function obody_markforreprocess(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            sl_triggersAdapterOBody.MarkForReprocess(_targetActor)
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endfunction

; sltname obody_resetactorobodymorphs
; sltgrup OBody
; sltdesc Form: actor: target Actor
; sltdesc Resets the actor's OBody morphs (whatever that does)
; sltsamp obody_resetactorobodymorphs $system.player
function obody_resetactorobodymorphs(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            sl_triggersAdapterOBody.ResetActorOBodyMorphs(_targetActor)
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endfunction

; sltname obody_reapplyactorobodymorphs
; sltgrup OBody
; sltdesc Only valid in OBody NG AFTER v4.3.7 (i.e. not present in v4.3.7 or earlier)
; sltdesc Form: actor: target Actor
; sltdesc Reapplies the actor's OBody morphs (whatever that does)
; sltsamp obody_reapplyactorobodymorphs $system.player
function obody_reapplyactorobodymorphs(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            sl_triggersAdapterOBody.ReapplyActorOBodyMorphs(_targetActor)
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endfunction

; sltname obody_getpresetassignedtoactor
; sltgrup OBody
; sltdesc Only valid in OBody NG AFTER v4.3.7 (i.e. not present in v4.3.7 or earlier)
; sltdesc Returns: string: the preset currently assigned to the target Actor
; sltdesc Form: actor: target Actor
; sltdesc Resets the actor's OBody morphs (whatever that does)
; sltsamp obody_getpresetassignedtoactor $system.player
; sltsamp msg_console "Preset is: " $$
function obody_getpresetassignedtoactor(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string nextResult = ""

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            nextResult = sl_triggersAdapterOBody.GetPresetAssignedToActor(_targetActor)
        endif
    endif

    CmdPrimary.MostRecentStringResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endfunction

; sltname obody_assignpresettoactor
; sltgrup OBody
; sltdesc Only valid in OBody NG AFTER v4.3.7 (i.e. not present in v4.3.7 or earlier)
; sltdesc Returns: bool: whether the preset assignment succeeded or not
; sltdesc Form: actor: target Actor
; sltdesc string: presetName: the name of the preset to assign; use an empty string to remove the preset assignment from an actor
; sltdesc bool: forceImmediateApplicationOfMorphs: (OPTIONAL: DEFAULT: true) true to immediately apply morphs
; sltdesc bool: doNotApplyMorphs: (OPTIONAL: DEFAULT: false) true to not apply morphs as part of preset assignment
; sltdesc Resets the actor's OBody morphs (whatever that does)
; sltsamp obody_assignpresettoactor $system.player "CBBE Curvy"
; sltsamp msg_console "Preset assignment success: " $$
function obody_assignpresettoactor(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    bool nextResult = false

    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            string _targetPreset = CmdPrimary.ResolveString(param[2])
            bool forceApply = true
            bool doNotApply = false
            if param.Length > 3
                forceApply = CmdPrimary.ResolveBool(param[3])
                if param.Length > 4
                    doNotApply = CmdPrimary.ResolveBool(param[4])
                endif
            endif
            nextResult = sl_triggersAdapterOBody.AssignPresetToActor(_targetActor, _targetPreset, forceApply, doNotApply)
        endif
    endif

    CmdPrimary.MostRecentBoolResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endfunction
