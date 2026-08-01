scriptname sl_triggersAdapterLeashFramework

bool function leash_applyleash(Actor holder, Actor leashed, String parentBone, String leashBoneMatch, Float minLength, Float maxLength, Bool persistent) Global
    return LeashFramework.ApplyLeash(holder, leashed, parentBone, leashBoneMatch, minLength, maxLength, persistent)
endfunction

Bool Function leash_DisconnectLeash(Actor holder, Actor leashed) Global
    return LeashFramework.DisconnectLeash(holder, leashed)
endfunction

Bool Function leash_UnleashAll(Actor _actor) Global
    return LeashFramework.UnleashAll(_actor)
endfunction

Bool Function leash_IsLeashed(Actor _actor) Global
    return LeashFramework.IsLeashed(_actor)
endfunction

Bool Function leash_IsLeashHolder(Actor _actor) Global
    return LeashFramework.IsLeashHolder(_actor)
endfunction

Actor Function leash_GetLeashHolder(Actor leashed) Global
    return LeashFramework.GetLeashHolder(leashed)
endfunction

Actor[] Function leash_GetLeashedActors(Actor holder) Global
    return LeashFramework.GetLeashedActors(holder)
endfunction

Float Function leash_GetMinLeashLength(Actor leashed) Global
    return LeashFramework.GetMinLeashLength(leashed)
endfunction

Float Function leash_GetMaxLeashLength(Actor leashed) Global
    return LeashFramework.GetMaxLeashLength(leashed)
endfunction

Bool Function leash_SetMinLeashLength(Actor leashed, Float newLength) Global
    return LeashFramework.SetMinLeashLength(leashed, newLength)
endfunction

Bool Function leash_SetMaxLeashLength(Actor leashed, Float newLength) Global
    return LeashFramework.SetMaxLeashLength(leashed, newLength)
endfunction