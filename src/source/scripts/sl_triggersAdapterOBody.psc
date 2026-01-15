scriptname sl_triggersAdapterOBody

; Example: "Data\\CalienteTools\\BodySlide\\SliderPresets\\Teru Apex V2 3BBB.xml"
Function ApplyPresetByFile(Actor a_actor, string a_pathToFile) Global
    OBodyNative.ApplyPresetByFile(a_actor, a_pathToFile)
EndFunction

; Must be a preset loaded into memory, i.e. already in the preset folder
Function ApplyPresetByName(Actor a_actor, String a_name) Global
    OBodyNative.ApplyPresetByName(a_actor, a_name)
EndFunction

Function MarkForReprocess(Actor a_actor) Global
    OBodyNative.MarkForReprocess(a_actor)
EndFunction

Function RemoveClothesOverlay(Actor a_actor) Global
    OBodyNative.RemoveClothesOverlay(a_actor)
EndFunction

Function AddClothesOverlay(Actor a_actor) Global
    OBodyNative.AddClothesOverlay(a_actor)
EndFunction

String[] Function GetAllPossiblePresets(actor a_actor) Global
    return OBodyNative.GetAllPossiblePresets(a_actor)
EndFunction

Int Function GetFemaleDatabaseSize() Global
    return OBodyNative.GetFemaleDatabaseSize()
EndFunction

Int Function GetMaleDatabaseSize() Global
    return OBodyNative.GetMaleDatabaseSize()
EndFunction

Function SetORefit(Bool a_enabled) Global
    OBodyNative.SetORefit(a_enabled)
EndFunction

Function SetNippleSlidersORefitEnabled(Bool a_enabled) Global
    OBodyNative.SetNippleSlidersORefitEnabled(a_enabled)
EndFunction

Function SetNippleRand(Bool a_enabled) Global
    OBodyNative.SetNippleRand(a_enabled)
EndFunction

Function SetGenitalRand(Bool a_enabled) Global
    OBodyNative.SetGenitalRand(a_enabled)
EndFunction

Function SetPerformanceMode(Bool a_enabled) Global
    OBodyNative.SetPerformanceMode(a_enabled)
EndFunction

Function SetDistributionKey(String a_distributionKey) Global
    OBodyNative.SetDistributionKey(a_distributionKey)
EndFunction

Function ResetActorOBodyMorphs(Actor a_actor) Global
    OBodyNative.ResetActorOBodyMorphs(a_actor)
EndFunction

Function ReapplyActorOBodyMorphs(Actor a_actor) Global
    OBodyNative.ReapplyActorOBodyMorphs(a_actor)
EndFunction

; OBody began keeping track of the preset assigned to an actor via native code
; starting after version 4.3.7.
String Function GetPresetAssignedToActor(Actor a_actor) Global
    return OBodyNative.GetPresetAssignedToActor(a_actor)
EndFunction

; Unlike `ApplyPresetByName` this applies a preset only if a preset with the name
; is found instead of falling back to a random preset.
; Additionally, this can be used to remove the preset assignment from an actor
; by supplying an empty string.
; `a_doNotApplyMorphs` takes precedence over `a_forceImmediateApplicationOfMorphs`.
; This returns whether the preset assignment succeeded or not.
Bool Function AssignPresetToActor(Actor a_actor, String a_presetName, Bool a_forceImmediateApplicationOfMorphs = True, Bool a_doNotApplyMorphs = False) Global
    return OBodyNative.AssignPresetToActor(a_actor, a_presetName, a_forceImmediateApplicationOfMorphs, a_doNotApplyMorphs)
EndFunction
