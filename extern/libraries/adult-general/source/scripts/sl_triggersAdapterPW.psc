scriptname sl_triggersAdapterPW

import sl_triggersStatics

bool Function IsPublicWhoreAnywhere() global
    PW_TrackerScript pwtracker = sl_triggers.GetForm("PW_Tracker") as PW_TrackerScript
    if !pwtracker
        sl_triggers_internal.LogError("sl_triggersAdapterPW.IsPublicWhoreAnywhere: failed to obtain PW_TrackerScript")
    endif
    return pwtracker.isWhoreAnywhere
EndFunction