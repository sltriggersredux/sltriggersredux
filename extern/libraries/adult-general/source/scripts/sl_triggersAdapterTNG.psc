scriptname sl_triggersAdapterTNG

int function CanModifyActor(Actor akActor) global
    return TNG_PapyrusUtil.CanModifyActor(akActor)
endfunction

int function GetActorSize(Actor akActor) global
    return TNG_PapyrusUtil.GetActorSize(akActor)
endfunction

int function SetActorSize(Actor akActor, int aiSizeCat) global
    return TNG_PapyrusUtil.SetActorSize(akActor, aiSizeCat)
endfunction