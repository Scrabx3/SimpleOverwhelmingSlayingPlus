Scriptname SOSCK_Constant extends ActiveMagicEffect  

GlobalVariable Property SOSCKToggle  Auto  
GlobalVariable Property SOSCKPush  Auto  
GlobalVariable Property SOSCKPushForce  Auto  
GlobalVariable Property SOSCKLastEnemy  Auto  
GlobalVariable Property SOSCKSlowMo  Auto  
GlobalVariable Property SOSCKBlur  Auto  
GlobalVariable Property SOSCKBW  Auto  
GlobalVariable Property SOSCKFirstPerson  Auto  
GlobalVariable Property SOSCKThirdPerson  Auto  
GlobalVariable Property SOSCKCameraTime  Auto 
GlobalVariable Property SOSCKHud  Auto
GlobalVariable Property SOSCKSpells Auto
GlobalVariable Property SOSCKPowerAttack Auto
GlobalVariable Property SOSCKOtherKill Auto 

ImageSpaceModifier Property SOSCKISBlur  Auto  
ImageSpaceModifier Property SOSCKISBW  Auto  

SPELL Property SOSCK_SlowTimeSpell  Auto 
SPELL Property SOSCK_ConstantSpell auto 

Actor Property PlayerRef  Auto  

actor Victim

Bool PowerAttack
Bool WeaponAttack
Bool SpellAttack

float angleZ=0.0

auto State Default
	Function OnEffectStart(actor Target, actor Caster)
		Victim=Target
		if Victim
			if Victim.IsDead()
				Victim.RemoveSpell(SOSCK_ConstantSpell)
				self.GotoState("done")
			endif
		endif
	EndFunction
	
	Function OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
		SpellAttack=false
		if (akSource as Weapon)
			WeaponAttack=true
			if abPowerAttack
				PowerAttack=true
			else
				PowerAttack=false
			endif
		else
			WeaponAttack=false
		endif
	EndFunction
	
	Function OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
		WeaponAttack=false
		PowerAttack=false
		if akCaster == PlayerRef
			SpellAttack=true
		else
			SpellAttack=false
		endif
		
	EndFunction
	
	Function OnDying(actor akKiller)
		if Victim
			if akKiller == PlayerRef
				if (SOSCKPowerAttack.GetValue() && PowerAttack) || (!SOSCKPowerAttack.GetValue() && WeaponAttack) || (SOSCKSpells.GetValue() && SpellAttack) || (SOSCKOtherKill.GetValue() && !WeaponAttack && !SpellAttack)
					if SOSCKBlur.GetValue()
						SOSCKISBlur.Apply()
					endif
					if SOSCKBW.GetValue()
						SOSCKISBW.Apply()
					endif		
					if SOSCKPush.GetValue()
						angleZ=Game.GetPlayer().getAngleZ()
						Victim.ApplyHavokImpulse(math.sin(angleZ),math.cos(angleZ), 1, SOSCKPushForce.GetValue())
					endif
					if SOSCKSlowMo.GetValue()
						SOSCK_SlowTimeSpell.Cast(Game.GetPlayer(),Game.GetPlayer())
					endif
					if SOSCKHud.GetValue()
						Debug.ToggleMenus()
					endif
					if SOSCKFirstPerson.GetValue() && Game.GetCameraState() != 0
						Game.ForceFirstPerson()
					elseif SOSCKThirdPerson.GetValue() && Game.GetCameraState() == 0
						Game.ForceThirdPerson()
					endif	
					utility.wait(SOSCKCameraTime.GetValue())
					if SOSCKFirstPerson.GetValue() && Game.GetCameraState() == 0
						Game.ForceThirdPerson()
					elseif SOSCKThirdPerson.GetValue() && Game.GetCameraState() != 0
						Game.ForceFirstPerson()		
					endif
					if SOSCKHud.GetValue()
						Debug.ToggleMenus()
					endif
					Victim.RemoveSpell(SOSCK_ConstantSpell)
					self.GotoState("done")
				endif
			endif
		endif
	EndFunction 
EndState

state done

EndState


