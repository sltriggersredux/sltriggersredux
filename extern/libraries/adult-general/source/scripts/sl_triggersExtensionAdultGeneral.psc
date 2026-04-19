scriptname sl_triggersExtensionAdultGeneral extends sl_triggersExtension

import sl_triggersStatics

int		EVENT_ID_ASF 						= 1

string ATTR_MOD_VERSION						= "__slt_mod_version__"
string ATTR_EVENT							= "event"
string ATTR_CHANCE							= "chance"
string ATTR_DAYTIME							= "daytime"
string ATTR_DEEPLOCATION					= "deeplocation"
string ATTR_IS_ARMED						= "is_armed"
string ATTR_IS_CLOTHED						= "is_clothed"
string ATTR_IS_WEAPON_DRAWN					= "is_weapon_drawn"
string ATTR_DO_1							= "do_1"
string ATTR_DO_2							= "do_2"
string ATTR_DO_3							= "do_3"
string ATTR_DO_4							= "do_4"
string ATTR_ASF_RESPONSE					= "asf_response"
string ATTR_ASF_CONSENSUAL					= "asf_consensual"
string ATTR_ASF_POTENTIAL_ORGY				= "asf_potential_orgy"
string ATTR_ASF_SEX							= "asf_sex"


string[]	triggerKeys_ASF

bool Function IsMCMConfigurable()
	return true
EndFunction

Event OnInit()
	If (SLT.Debug_Extension || SLT.Debug_Extension_AdultGeneral)
		SLTDebugMsg("AdultGeneral.OnInit")
	EndIf

	if !self
		return
	endif

	SLTInit()

	; REQUIRED CALL
	UnregisterForUpdate()
	RegisterForSingleUpdate(0.01)
EndEvent

Function DoPlayerLoadGame()
	If (SLT.Debug_Extension || SLT.Debug_Extension_AdultGeneral)
		SLTDebugMsg("AdultGeneral.DoPlayerLoadGame")
	EndIf

	SLTInit()
EndFunction

Event OnUpdate()
	If (SLT.Debug_Extension || SLT.Debug_Extension_AdultGeneral)
		SLTDebugMsg("AdultGeneral.OnUpdate")
	EndIf
	QueueUpdateLoop(60)
EndEvent

; SLTReady
; OPTIONAL
Function SLTReady()
	If (SLT.Debug_Extension || SLT.Debug_Extension_AdultGeneral)
		SLTDebugMsg("AdultGeneral.SLTReady")
	EndIf
	RefreshData()
EndFunction

Function RefreshData()
	If (SLT.Debug_Extension || SLT.Debug_Extension_AdultGeneral)
		SLTDebugMsg("AdultGeneral.RefreshData")
	EndIf
	RegisterEvents()
EndFunction

Function VersionUpdateTriggerFile(string _triggerFile)
EndFunction

Function HandleVersionUpdate(int oldVersion, int newVersion)
	If (SLT.Debug_Extension || SLT.Debug_Setup || SLT.Debug_Extension_AdultGeneral)
		SLTDebugMsg("AdultGeneral.HandleVersionUpdate: oldVersion(" + SLTRVersion + ") newVersion(" + newVersion + ")")
	EndIf
	int i = 0
	string[] updateKeys = sl_triggers_internal.GetTriggerKeys(SLTExtensionKey)
	while i < updateKeys.Length
		string _triggerFile = FN_T(updateKeys[i])

		VersionUpdateTriggerFile(_triggerFile)

		i += 1
	endwhile
EndFunction

bool Function CustomResolveScoped(sl_triggersCmd CmdPrimary, string scope, string token)
	return false
EndFunction

; selectively enables only events with triggers
Function RegisterEvents()
	If (SLT.Debug_Extension || SLT.Debug_Extension_AdultGeneral)
		SLTDebugMsg("AdultGeneral.RegisterEvents")
	EndIf
	UnregisterForModEvent("ASF_PlayerConsent")
	if IsEnabled && triggerKeys_ASF.Length > 0
		SafeRegisterForModEvent_Quest(self, "ASF_PlayerConsent", "ASF_PlayerConsent")
	endif
EndFunction

; EXTERNAL EVENT HANDLERS
Event ASF_PlayerConsent(String OptionSelected, Bool PlayerConsents, Bool PotentialOrgy, Form RequestorRef)
	If (SLT.Debug_Extension || SLT.Debug_Extension_AdultGeneral)
		SLTDebugMsg("AdultGeneral.ASF_PlayerConsent")
	EndIf

	if !Self
		return
	endif

	if !IsEnabled
		return
	endif
	
	; OptionSelected - Accept, Acquiesce, Decline, Refuse, Cancel ; Accept and Refuse are available by default; Acquiesce and Decline are optional
	HandleASFEvent(OptionSelected, PlayerConsents, PotentialOrgy, RequestorRef)
EndEvent

Function RefreshTriggerCache()
	If (SLT.Debug_Extension || SLT.Debug_Extension_AdultGeneral)
		SLTDebugMsg("AdultGeneral.RefreshTriggerCache")
	EndIf
	triggerKeys_ASF = PapyrusUtil.StringArray(0)
	
	int i = 0
	while i < TriggerKeys.Length
		string _triggerFile = FN_T(TriggerKeys[i])

		VersionUpdateTriggerFile(_triggerFile)

		if !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())
			int eventCode = JsonUtil.GetIntValue(_triggerFile, ATTR_EVENT)
			if eventCode == EVENT_ID_ASF
				triggerKeys_ASF = PapyrusUtil.PushString(triggerKeys_ASF, TriggerKeys[i])
			else
				If (SLT.Debug_Extension_AdultGeneral)
					SLTDebugMsg("AdultGeneral.RefreshTriggerCache: _triggerFile(" + _triggerFile + ") has unknown eventCode(" + eventCode + "); skipping")
				EndIf
			endif
		else
			If (SLT.Debug_Extension_AdultGeneral)
				SLTDebugMsg("AdultGeneral.RefreshTriggerCache: _triggerFile(" + _triggerFile + ") has DELETED_ATTRIBUTE; skipping")
			EndIf
		endif
		
		i += 1
	endwhile
	
	If (SLT.Debug_Extension_AdultGeneral)
		string inmsg
		int inside
		string t_key
		string t_file

		inmsg = "\n\n===========\ntriggerKeys_ASF:\n"
		inside = triggerKeys_ASF.Length
		while inside
			inside -= 1
			t_key = triggerKeys_ASF[inside]
			t_file = FN_T(t_key)
			inmsg += "key(" + t_key + ") file(" + t_file +")\n"
		endwhile

		inmsg += "===========\n\n"
		SLTDebugMsg(inmsg)
	EndIf
EndFunction

Function HandleASFEvent(string msg_string, bool is_consenting, bool is_maybe_orgy, Form requestor)
	If (SLT.Debug_Extension_AdultGeneral)
		SLTDebugMsg("\n====\n"\
		+ "triggerKeys_ASF.length (" + triggerKeys_ASF.Length + ")\n" \
		+ "msg_string (" + msg_string + ")\n" \
		+ "is_consenting (" + is_consenting + ")\n" \
		+ "is_maybe_orgy (" + is_maybe_orgy + ")\n" \
		+ "requestor (" + requestor + ")\n" \
		+ "\n===="\
		)
	EndIf

	int i = 0
	string triggerKey
	string command
	string _triggerFile
	string value
	int    ival
	bool   doRun
	float chance
	int cmdRequestId
	int		requestTargetFormId = PlayerRef.GetFormID() ; conveniently so, in this case
	bool playerWasInInterior = PlayerRef.IsInInterior()
	Location pLoc = SLT.PlayerRef.GetCurrentLocation()

	while i < triggerKeys_ASF.Length
		triggerKey = triggerKeys_ASF[i]
		_triggerFile = FN_T(triggerKey)

		If (SLT.Debug_Extension_AdultGeneral)
			SLTDebugMsg("AdultGeneral: checking trigger(" + triggerKey + ")")
		EndIf

		doRun = !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())

		If (SLT.Debug_Extension_AdultGeneral)
			SLTDebugMsg("AdultGeneral: doRun(" + doRun + ") after DELETED")
		EndIf

		if doRun
			chance = JsonUtil.GetFloatValue(_triggerFile, ATTR_CHANCE, 100.0)
			doRun = chance >= 100.0 || chance >= Utility.RandomFloat(0.0, 100.0)
		endif

		If (SLT.Debug_Extension_AdultGeneral)
			SLTDebugMsg("AdultGeneral: doRun(" + doRun + ") after ATTR_CHANCE")
		EndIf

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_DAYTIME)
			if ival != 0 ; 0 is Any
				if 		ival == 1
					doRun = dayTime()
				elseIf 	ival == 2
					doRun = !dayTime()
				endIf

				If (SLT.Debug_Extension_AdultGeneral && !doRun)
					SLTDebugMsg("AdultGeneral: doRun(" + doRun + ") due to ATTR_DAYTIME")
				EndIf
			endIf
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_DEEPLOCATION)
			if ival != 0
		;/
		0 - Any

		1 - Inside
		2 - Outside
		3 - Safe (Home/Jail/Inn)
		4 - City (City/Town/Habitation/Dwelling)
		5 - Wilderness (!pLoc(DEFAULT)/Hold/Fort/Bandit Camp)
		6 - Dungeon (Cave/et. al.)

		; LocationKeywords[i - 7]
		5 - Player Home
		6 - Jail
		...
		/;

				if ival == 1
					doRun = playerWasInInterior
				elseif ival == 2
					doRun = !playerWasInInterior
				elseif ival == 3
					doRun = SLT.IsLocationSafe(pLoc)
				elseif ival == 4
					doRun = SLT.IsLocationInCity(pLoc)
				elseif ival == 5
					doRun = SLT.IsLocationInWilderness(pLoc)
				elseif ival == 6
					doRun = SLT.IsLocationInDungeon(pLoc)
				else
					doRun = pLoc.HasKeyword(SLT.LocationKeywords[ival - 7])
				endif

				If (SLT.Debug_Extension_AdultGeneral && !doRun)
					SLTDebugMsg("AdultGeneral: doRun(" + doRun + ") after ATTR_DEEPLOCATION")
				EndIf
			endif
		endIf
					
		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_ARMED)
			if ival != 0
				if 		ival == 1
					doRun = PlayerRef.GetEquippedItemType(0) != 0 || PlayerRef.GetEquippedItemType(1) != 0
				elseif 	ival == 2
					doRun = PlayerRef.GetEquippedItemType(0) == 0 && PlayerRef.GetEquippedItemType(1) == 0
				elseif 	ival == 3
					doRun = PlayerRef.GetEquippedItemType(1) == 0
				endif

				If (SLT.Debug_Extension_AdultGeneral && !doRun)
					SLTDebugMsg("AdultGeneral: doRun(" + doRun + ") due to ATTR_IS_ARMED")
				EndIf
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_CLOTHED)
			if ival != 0
				if 		ival == 1
					doRun = PlayerRef.GetEquippedArmorInSlot(32) != none
				elseif 	ival == 2
					doRun = PlayerRef.GetEquippedArmorInSlot(32) == none
				elseif 	ival == 3
					Armor bodyItem = PlayerRef.GetEquippedArmorInSlot(32)
					doRun = (bodyItem == none) || bodyItem.HasKeywordString("zad_Lockable")
				endif

				If (SLT.Debug_Extension_AdultGeneral && !doRun)
					SLTDebugMsg("AdultGeneral: doRun(" + doRun + ") due to ATTR_IS_CLOTHED")
				EndIf
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_WEAPON_DRAWN)
			if ival != 0
				if 		ival == 1
					doRun = PlayerRef.IsWeaponDrawn()
				elseif 	ival == 2
					doRun = !PlayerRef.IsWeaponDrawn()
				endif

				If (SLT.Debug_Extension_AdultGeneral && !doRun)
					SLTDebugMsg("AdultGeneral: doRun(" + doRun + ") due to ATTR_IS_WEAPON_DRAWN")
				EndIf
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_ASF_RESPONSE)
			if ival != 0
				if 		ival == 1
					doRun = ("Accept" == msg_string)
				elseif	ival == 2
					doRun = ("Acquiesce" == msg_string)
				elseif 	ival == 3
					doRun = ("Decline" == msg_string)
				elseif 	ival == 4
					doRun = ("Refuse" == msg_string)
				elseif	ival == 5
					doRun = ("Cancel" == msg_string)
				endif

				If (SLT.Debug_Extension_AdultGeneral && !doRun)
					SLTDebugMsg("AdultGeneral: doRun(" + doRun + ") due to ATTR_ASF_RESPONSE")
				EndIf
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_ASF_CONSENSUAL)
			if ival != 0
				if 		ival == 1
					doRun = (is_consenting == true)
				elseif	ival == 2
					doRun = (is_consenting == false)
				elseif ival == 3
					doRun = (is_consenting == false) && "Cancel" != msg_string
				endif

				If (SLT.Debug_Extension_AdultGeneral && !doRun)
					SLTDebugMsg("AdultGeneral: doRun(" + doRun + ") due to ATTR_ASF_CONSENSUAL")
				EndIf
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_ASF_POTENTIAL_ORGY)
			if ival != 0
				if 		ival == 1
					doRun = (is_maybe_orgy == true)
				elseif	ival == 2
					doRun = (is_maybe_orgy == false)
				endif

				If (SLT.Debug_Extension_AdultGeneral && !doRun)
					SLTDebugMsg("AdultGeneral: doRun(" + doRun + ") due to ATTR_ASF_POTENTIAL_ORGY")
				EndIf
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_ASF_SEX)
			if ival != 0
				Actor reqActor = requestor as Actor
				if reqActor
					ActorBase reqBase = reqActor.GetActorBase()
					int reqSex = -1
					if reqBase
						reqSex = reqBase.GetSex()
					endif
					if 		ival == 1
						doRun = (reqSex == 0)
					elseif	ival == 2
						doRun = (reqSex == 1)
					endif
				endif

				If (SLT.Debug_Extension_AdultGeneral && !doRun)
					SLTDebugMsg("AdultGeneral: doRun(" + doRun + ") due to ATTR_ASF_SEX")
				EndIf
			endif
		endif

		if doRun
			int cmdThreadId
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_1)
			if command
				cmdRequestId = GetNextASFRequestId(requestTargetFormId, cmdRequestId, msg_string, is_consenting, is_maybe_orgy, requestor)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_2)
			if command
				cmdRequestId = GetNextASFRequestId(requestTargetFormId, cmdRequestId, msg_string, is_consenting, is_maybe_orgy, requestor)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_3)
			if command
				cmdRequestId = GetNextASFRequestId(requestTargetFormId, cmdRequestId, msg_string, is_consenting, is_maybe_orgy, requestor)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_4)
			if command
				cmdRequestId = GetNextASFRequestId(requestTargetFormId, cmdRequestId, msg_string, is_consenting, is_maybe_orgy, requestor)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
		endif

		i += 1
	endwhile
EndFunction

int Function GetNextASFRequestId(int requestTargetFormId, int cmdRequestId, string msg_string, bool is_consenting, bool is_maybe_orgy, Form requestor)
	if !cmdRequestId
		cmdRequestId = SLT.GetNextInstanceId()

		sl_triggersCmd.PrecacheRequestString(SLT, requestTargetFormId, cmdRequestId, "adult.asf.player_response", msg_string)
		sl_triggersCmd.PrecacheRequestBool(SLT, requestTargetFormId, cmdRequestId, "adult.asf.player_consents", is_consenting)
		sl_triggersCmd.PrecacheRequestBool(SLT, requestTargetFormId, cmdRequestId, "adult.asf.potential_orgy", is_maybe_orgy)
		sl_triggersCmd.PrecacheRequestForm(SLT, requestTargetFormId, cmdRequestId, "adult.asf.requestor", requestor)
	endif
	return cmdRequestId
EndFunction
