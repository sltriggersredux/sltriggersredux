scriptname sl_triggersSLPPAdapter

bool function slpp_is_thread_aggressive(SexLabThread slthread) global
    if !slthread
        return false
    endif
    if slthread.HasContext("Aggressive")
        return true
    elseif slthread.HasTag("Forced")
        return true
    ; unlikely
    elseif slthread.HasTag("Aggressive")
        return true
    endif
    return false
endfunction

bool function slpp_is_actor_aggressor(SexLabThread slthread, Actor theActor) global
    if (!slthread || !theActor)
        return false
    endif
    return slpp_is_thread_aggressive(slthread) && !slthread.GetSubmissive(theActor)
endfunction