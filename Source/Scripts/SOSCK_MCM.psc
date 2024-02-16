Scriptname SOSCK_MCM extends SKI_ConfigBase

; -----

GlobalVariable Property SOSCKToggle Auto
GlobalVariable Property SOSCKPush Auto
GlobalVariable Property SOSCKPushForce Auto
GlobalVariable Property SOSCKLastEnemy Auto
GlobalVariable Property SOSCKSlowMo Auto
GlobalVariable Property SOSCKBlur Auto
GlobalVariable Property SOSCKBW Auto
GlobalVariable Property SOSCKFirstPerson Auto
GlobalVariable Property SOSCKThirdPerson Auto
GlobalVariable Property SOSCKCameraTime Auto
GlobalVariable Property SOSCKPowerAttack Auto
GlobalVariable Property SOSCKHud  Auto 
GlobalVariable Property SOSCKSpells Auto 
GlobalVariable Property SOSCKOtherKill Auto 

int toggleFlag
int pushFlag
int fpFlag
int tpFlag
int poattFlag

; -----

Event OnPageReset(string akPage)

SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	AddHeaderOption("")
	
	toggleFlag=OPTION_FLAG_NONE
	pushFlag=OPTION_FLAG_NONE
	fpFlag=OPTION_FLAG_NONE
	tpFlag=OPTION_FLAG_NONE
	If SOSCKToggle.GetValue() as bool == false
		toggleFlag=OPTION_FLAG_DISABLED
		pushFlag=OPTION_FLAG_DISABLED
		fpFlag=OPTION_FLAG_DISABLED
		tpFlag=OPTION_FLAG_DISABLED
	Endif
	If SOSCKPush.GetValue() as bool == false
		pushFlag=OPTION_FLAG_DISABLED
	Endif
	If SOSCKFirstPerson.GetValue() as bool == true
		fpFlag=OPTION_FLAG_DISABLED
	Endif
	If SOSCKThirdPerson.GetValue() as bool == true
		tpFlag=OPTION_FLAG_DISABLED
	Endif
	
	AddToggleOptionST("TOGGLE", "Mod Active", SOSCKToggle.GetValue() as Bool)
	AddHeaderOption("")
	AddToggleOptionST("SPLL", "Enable Spells", SOSCKSpells.GetValue() as Bool, toggleFlag)
	AddHeaderOption("")
	AddToggleOptionST("POATT", "Power Attacks Only", SOSCKPowerAttack.GetValue() as Bool, toggleFlag)
	AddToggleOptionST("LAENE", "Last Enemy Only", SOSCKLastEnemy.GetValue() as Bool, toggleFlag)
	AddHeaderOption("")
	AddToggleOptionST("PUSH", "Push Effect", SOSCKPush.GetValue() as Bool, toggleFlag)
	AddSliderOptionST("PUSHFO", "Push Force", SOSCKPushForce.GetValue(), "{2}", pushFlag)

	SetCursorPosition(1)
	AddHeaderOption("Effects")
	AddToggleOptionST("SLOMO", "Slow Motion", SOSCKSlowMo.GetValue() as Bool, toggleFlag)
	AddEmptyOption()
	AddToggleOptionST("BLUR", "Blur Effect", SOSCKBlur.GetValue() as Bool, toggleFlag)
	AddToggleOptionST("BLWH", "Black and White (No ENB)", SOSCKBW.GetValue() as Bool, toggleFlag)
	AddHeaderOption("Camera")
	AddToggleOptionST("THUD", "Toggle Hud", SOSCKHud.GetValue() as Bool, toggleFlag)
	AddToggleOptionST("FOFP", "Force First Person", SOSCKFirstPerson.GetValue() as Bool, tpFlag)
	AddToggleOptionST("FOTP", "Force Third Person", SOSCKThirdPerson.GetValue() as Bool, fpFlag)
	AddSliderOptionST("CAMTI", "Camera Effects Duration", SOSCKCameraTime.GetValue(), "{2} secs", toggleFlag)
	AddHeaderOption("")
	AddToggleOptionST("OTHR", "Other Kills", SOSCKOtherKill.GetValue() as Bool, toggleFlag)
	

EndEvent

; -----

state TOGGLE ; TOGGLE
	event OnSelectST()
		SOSCKToggle.SetValue(1 - SOSCKToggle.GetValue())
		SetToggleOptionValueST(SOSCKToggle.GetValue() as Bool)
		ForcePageReset()
	endEvent

	event OnDefaultST()
		SetToggleOptionValueST(SOSCKToggle.GetValue() as Bool)
	endEvent

	event OnHighlightST()
		SetInfoText("Toggles the mod Completely")
	endEvent
endState


state POATT ; TOGGLE
	event OnSelectST()
		SOSCKPowerAttack.SetValue(1 - SOSCKPowerAttack.GetValue())
		SetToggleOptionValueST(SOSCKPowerAttack.GetValue() as Bool)
		ForcePageReset()
	endEvent

	event OnDefaultST()
		SetToggleOptionValueST(SOSCKPowerAttack.GetValue() as Bool)
	endEvent

	event OnHighlightST()
		SetInfoText("Cinematic Kills only on Power Attacks")
	endEvent
endState

state LAENE ; TOGGLE
	event OnSelectST()
		SOSCKLastEnemy.SetValue(1 - SOSCKLastEnemy.GetValue())
		SetToggleOptionValueST(SOSCKLastEnemy.GetValue() as Bool)
	endEvent

	event OnDefaultST()
		SetToggleOptionValueST(SOSCKLastEnemy.GetValue() as Bool)
	endEvent

	event OnHighlightST()
		SetInfoText("Cinematic Kills only on the Last Enemy, killcams override this most of the time so you need to disable then")
	endEvent
endState

state PUSH ; TOGGLE
	event OnSelectST()
		SOSCKPush.SetValue(1 - SOSCKPush.GetValue())
		SetToggleOptionValueST(SOSCKPush.GetValue() as Bool)
		ForcePageReset()
	endEvent

	event OnDefaultST()
		SetToggleOptionValueST(SOSCKPush.GetValue() as Bool)
	endEvent

	event OnHighlightST()
		SetInfoText("Enemies are pushed away in Cinematic Kills")
	endEvent
endState

state PUSHFO ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue(SOSCKPushForce.GetValue())
		SetSliderDialogDefaultValue(500)
		SetSliderDialogRange(10, 2000)
		SetSliderDialogInterval(10)
	endEvent

	event OnSliderAcceptST(float value)
		SOSCKPushForce.SetValue(value as int)
		SetSliderOptionValueST(SOSCKPushForce.GetValue())
	endEvent

	event OnDefaultST()
		SetSliderOptionValueST(SOSCKPushForce.GetValue())
	endEvent

	event OnHighlightST()
		SetInfoText("Push Effect Force")
	endEvent
endState

state SLOMO ; TOGGLE
	event OnSelectST()
		SOSCKSlowMo.SetValue(1 - SOSCKSlowMo.GetValue())
		SetToggleOptionValueST(SOSCKSlowMo.GetValue() as Bool)
	endEvent

	event OnDefaultST()
		SetToggleOptionValueST(SOSCKSlowMo.GetValue() as Bool)
	endEvent

	event OnHighlightST()
		SetInfoText("Slow Motion Effect on Cinematic Kills")
	endEvent
endState

state BLUR ; TOGGLE
	event OnSelectST()
		SOSCKBlur.SetValue(1 - SOSCKBlur.GetValue())
		SetToggleOptionValueST(SOSCKBlur.GetValue() as Bool)
	endEvent

	event OnDefaultST()
		SetToggleOptionValueST(SOSCKBlur.GetValue() as Bool)
	endEvent

	event OnHighlightST()
		SetInfoText("Blur Effect in Cinematic Kills")
	endEvent
endState

state BLWH ; TOGGLE
	event OnSelectST()
		SOSCKBW.SetValue(1 - SOSCKBW.GetValue())
		SetToggleOptionValueST(SOSCKBW.GetValue() as Bool)
	endEvent

	event OnDefaultST()
		SetToggleOptionValueST(SOSCKBW.GetValue() as Bool)
	endEvent

	event OnHighlightST()
		SetInfoText("Black and White effect in Cinematic Kills, most ENBs will break this effect.")
	endEvent
endState

state FOFP ; TOGGLE
	event OnSelectST()
		SOSCKFirstPerson.SetValue(1 - SOSCKFirstPerson.GetValue())
		SetToggleOptionValueST(SOSCKFirstPerson.GetValue() as Bool)
		ForcePageReset()
	endEvent

	event OnDefaultST()
		SetToggleOptionValueST(SOSCKFirstPerson.GetValue() as Bool)
	endEvent

	event OnHighlightST()
		SetInfoText("Force first person camera in Cinematic Kills for a set duration.")
	endEvent
endState

state FOTP ; TOGGLE
	event OnSelectST()
		SOSCKThirdPerson.SetValue(1 - SOSCKThirdPerson.GetValue())
		SetToggleOptionValueST(SOSCKThirdPerson.GetValue() as Bool)
		ForcePageReset()
	endEvent

	event OnDefaultST()
		SetToggleOptionValueST(SOSCKThirdPerson.GetValue() as Bool)
	endEvent

	event OnHighlightST()
		SetInfoText("Force third person camera in Cinematic Kills for a set duration.")
	endEvent
endState

state CAMTI ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue(SOSCKCameraTime.GetValue())
		SetSliderDialogDefaultValue(2)
		SetSliderDialogRange(0, 5)
		SetSliderDialogInterval(0.1)
	endEvent

	event OnSliderAcceptST(float value)
		SOSCKCameraTime.SetValue(value)
		SetSliderOptionValueST(SOSCKCameraTime.GetValue())
	endEvent

	event OnDefaultST()
		SetSliderOptionValueST(SOSCKCameraTime.GetValue())
	endEvent

	event OnHighlightST()
		SetInfoText("Duration of Camera Effects")
	endEvent
endState

state THUD ; TOGGLE
	event OnSelectST()
		SOSCKHud.SetValue(1 - SOSCKHud.GetValue())
		SetToggleOptionValueST(SOSCKHud.GetValue() as Bool)
	endEvent

	event OnDefaultST()
		SetToggleOptionValueST(SOSCKHud.GetValue() as Bool)
	endEvent

	event OnHighlightST()
		SetInfoText("Toggles Hud for a set duration, if your hud is already disabled it will toggle the hud on.")
	endEvent
endState

state SPLL ; TOGGLE
	event OnSelectST()
		SOSCKSpells.SetValue(1 - SOSCKSpells.GetValue())
		SetToggleOptionValueST(SOSCKSpells.GetValue() as Bool)
	endEvent

	event OnDefaultST()
		SetToggleOptionValueST(SOSCKSpells.GetValue() as Bool)
	endEvent

	event OnHighlightST()
		SetInfoText("Toggles Cinematic Kills for spells.")
	endEvent
endState

state OTHR ; TOGGLE
	event OnSelectST()
		SOSCKOtherKill.SetValue(1 - SOSCKOtherKill.GetValue())
		SetToggleOptionValueST(SOSCKOtherKill.GetValue() as Bool)
	endEvent

	event OnDefaultST()
		SetToggleOptionValueST(SOSCKOtherKill.GetValue() as Bool)
	endEvent

	event OnHighlightST()
		SetInfoText("Enable Cinematic Kills in kills that aren't either with weapons or spells")
	endEvent
endState
