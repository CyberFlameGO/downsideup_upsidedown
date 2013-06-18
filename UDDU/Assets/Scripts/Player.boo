import UnityEngine

class Player (MonoBehaviour): 
	
	public BloodExplosion as GameObject
	public PhaseOut as GameObject
	public PhaseIn as GameObject
	
	#constants
	public static speed as single = 6.0
	public static jump_speed as single = 8.0
	public static min_jump as single = 2.0
	
	public phase_thresh as single = 0.8

	#Gui variables
	public other as GameObject


	private distanceToKillX as single =1 #distance from centre of guard which will explode them
	private distanceToKillY as single =1.2

	#state variables
	public static holding as GameObject = null
	private current_phase as single = 1.0F #starts in top world
	private grounded = false
	private stunnedTime as single = 0

	# Variables so if user holds down phase key, will phase again after some time period
	private keyHoldCount = 2.0
	private keyWait = 2.0
	
	private idle = 0.0
	
	private anim as Animator
	
	# HashID
	private walkingState as int
	private jumpState as int
	
	private phase_freeze as single
	private timeScale as single = 1.0
	private vert_input as single = 0
	private glow as single = 0
	
	private isPaused as bool
	private timeWon = 0
	private exit as GameObject
	
	private explodeGuard as GameObject
	
	private facing as int = 1
	private turn_speed as single = 500.0
	private turning as bool = false
	
	private end_movie as MovieTexture


	def Start ():
		end_movie = Resources.Load("end_movie")
		
		transform.eulerAngles.y = 90
		
		walkingState = Animator.StringToHash('Walk')
		jumpState = Animator.StringToHash('Jump')
		anim = GetComponent[of Animator]()
		exit = GameObject.Find("ExitDoor")
		explodeGuard = GameObject.Find("GuardExplode")
	
	def GetPhase():
		return current_phase

	def GetGrounded():
		return grounded

	def GetOther():
		return other

	def stunPlayer(target as GameObject):
		if target.name == gameObject.name: #player 1 has been stunned, so force into bottom world
			current_phase = -1
			PhaseDown()
			PhaseDown()
			PhaseDown()
		else: #player 2 has been stunned, so force into top world
			current_phase = 1
			PhaseUp()
			PhaseUp()
			PhaseUp()
		stunnedTime = Time.time
		GameObject.Find("SoundEffects").GetComponent(SoundEffects).PlayStun(transform.position)


	def Update ():
		isPaused = GameObject.Find('Pause').GetComponent[of Pause]().GetIsPaused()
		
#		if (Time.realtimeSinceStartup > phase_freeze + 0.35) and isPaused == false:
#			Time.timeScale = 1.0
		
		if transform.position.x > exit.transform.position.x or timeWon>0:
			if timeWon==0:
				timeWon = Time.time
				end_movie.Play()
			endTime = 1.0
			if end_movie:
				endTime = end_movie.duration
			if Time.time > (timeWon+endTime):
				finishLevel()
			else:
				return
				
				
		#Idle chatter. Needs better conditions.
		if Time.time > idle + 10.0:
			GameObject.Find("SoundEffects").GetComponent(SoundEffects).PlayUchatter(transform.position)
			idle = Time.time

		if Time.time > stunnedTime + 5.0:
			stunnedTime = 0 #unstun after 2 seconds
		
		old_phase = current_phase
		if Input.GetAxisRaw("Vertical") != 0:
			vert_input += (Input.GetAxisRaw("Vertical") * Time.deltaTime)/0.25
		else:
			vert_input = 0
		if current_phase == 1:
			vert_input = Mathf.Clamp(vert_input, -1, 0)
		elif current_phase == -1:
			vert_input = Mathf.Clamp(vert_input, 0, 1)
			
		if stunnedTime == 0:
			if vert_input >= 1.0:
				if current_phase < 1: 
					if current_phase == -1: 			
						GameObject.Find("SoundEffects").GetComponent(SoundEffects).PlayPhase(transform.position)
					current_phase+=0.5
					vert_input = 0
			elif vert_input <= -1.0:
				if current_phase > -1: 
					if current_phase == 1: 			
						GameObject.Find("SoundEffects").GetComponent(SoundEffects).PlayPhase(transform.position)
					current_phase-=0.5
					vert_input = 0
		elif Mathf.Abs(vert_input) >= 1:
			Camera.main.GetComponent(CameraPlay).Shake(0.1)
			
		if glow <= Mathf.Abs(vert_input):
			glow = Mathf.Abs(vert_input)
		else:
			glow -= Time.deltaTime/0.25
		if stunnedTime == 0:
			changeGlow(glow*2)
			other.GetComponent(Player2).changeGlow(glow*2)
			GameObject.Find("PhaseTop").GetComponent(PhaseTop).setRed(false)
			GameObject.Find("PhaseBot").GetComponent(PhaseBot).setRed(false)
		else:
			changeRedGlow(glow*2)
			other.GetComponent(Player2).changeRedGlow(glow*2)
			GameObject.Find("PhaseTop").GetComponent(PhaseTop).setRed(true)
			GameObject.Find("PhaseBot").GetComponent(PhaseBot).setRed(true)

		
#		old_phase = current_phase
#		vert_input = Input.GetAxisRaw("Vertical")
#		if vert_input!=0 and stunnedTime==0:
#			keyHoldCount-=Time.deltaTime
#			if (Input.GetButtonDown("Vertical") or keyHoldCount<0) and isPaused == false:
#				if vert_input>0 and current_phase<1: 
#					current_phase+=0.5
#					keyHoldCount=keyWait
#				elif vert_input<0 and current_phase>-1: 
#					current_phase-=0.5
#					keyHoldCount=keyWait
#		elif vert_input!=0 and stunnedTime>0: #trying to phase while stunned, punish with camera shake!
#			Camera.main.GetComponent(CameraPlay).Shake(0.1)

					
		if (old_phase == 1 and current_phase == 0.5) or (old_phase == -1 and current_phase == -0.5) : 
				#phased into other world, so check valid and if hit guard
				if not checkPhaseSafe(old_phase):
					#if old_phase = 1:
					#	stunPlayer(gameObject)
					#else:
					#	stunPlayer(other)
					current_phase = old_phase
				else:
					checkPhaseKill(old_phase)
					
		#Change mass based on phase.
		rigidbody.mass = current_phase + 1.01
		#Phase in and out of existence.
		if current_phase == -1:
			if holding != null:
				holding.GetComponent[of Pickup1]().Drop()
			switch_states(gameObject, false)
			changeTransparency(0)
		else:
			switch_states(gameObject, true)
			if current_phase == -0.5: changeTransparency(0.5)
			else: changeTransparency(1)
			
		#Phasing effects.
		if (current_phase > old_phase) and isPaused == false:
			PhaseUp()
		elif (current_phase < old_phase) and isPaused == false:
			PhaseDown()
		
		#Rotation
		turning = false
		if Input.GetAxis("Horizontal") < 0:
			facing = -1
		elif Input.GetAxis("Horizontal") > 0:
			facing = 1
		if facing == 1:
			if Mathf.Round(transform.eulerAngles.y) >= 90:
				turning = true
				transform.eulerAngles.y = Mathf.Round(transform.eulerAngles.y-Mathf.Clamp(turn_speed*Time.deltaTime, 0, 8))
		else:
			if Mathf.Round(transform.eulerAngles.y) <= 270:
				turning = true
				transform.eulerAngles.y = Mathf.Round(transform.eulerAngles.y+Mathf.Clamp(turn_speed*Time.deltaTime, 0, 8))
			
			
		#Movement.
		anim.SetBool(walkingState, false)
		if isClear():
			if current_phase < 1 and other.GetComponent(Player2).isClear() == false:
				pass
			else:
				if grounded == false:
					max_speed = Mathf.Abs(Mathf.Clamp(speed*facing - Mathf.Clamp(rigidbody.velocity.x, -speed, speed), -speed, speed))
				else:
					max_speed = speed
				transform.position.x += Input.GetAxis("Horizontal") * max_speed * Time.deltaTime
				if Mathf.Abs(Input.GetAxis("Horizontal")) > 0.1:
					anim.SetBool(walkingState, true)
					
		#Only jump if we're grounded.
		if grounded:
			if Input.GetButtonDown("Jump"):
				anim.SetBool(jumpState, true)
				GameObject.Find("SoundEffects").GetComponent(SoundEffects).PlayHup(transform.position)

				rigidbody.velocity.y = jump_speed
			else:
				anim.SetBool(jumpState, false)
		
		if current_phase > -1 and current_phase < 1:

			#Average character positions.
			x = transform.position.x
			y = transform.position.y
			transform.position.x = (transform.position.x + other.transform.position.x)/2
			transform.position.y = (transform.position.y + other.transform.position.y)/2
			other.transform.position.x = (x + other.transform.position.x)/2
			other.transform.position.y = (y + other.transform.position.y)/2
			#Average character velocities.
			x = rigidbody.velocity.x
			y = rigidbody.velocity.y

			rigidbody.velocity.x = (x + other.rigidbody.velocity.x)/2
			rigidbody.velocity.y = (y + other.rigidbody.velocity.y)/2
			other.rigidbody.velocity.x = (x + other.rigidbody.velocity.x)/2
			other.rigidbody.velocity.y = (y + other.rigidbody.velocity.y)/2

		elif current_phase == -1:
			#Player1 is inactive, set to player2.
			transform.position.x = other.transform.position.x
			transform.position.y = other.transform.position.y
			rigidbody.velocity.x = other.rigidbody.velocity.x
			rigidbody.velocity.y = other.rigidbody.velocity.y

		else:
			#Player2 is inactive, set to player1.
			other.transform.position.x = transform.position.x
			other.transform.position.y = transform.position.y
			other.rigidbody.velocity.x = rigidbody.velocity.x
			other.rigidbody.velocity.y = rigidbody.velocity.y		
		
		if Input.GetButtonDown('Pickup1'):
			if turning == false:
				if holding == null:
					nearest = GetNearestTagged()
					if nearest != null:
						nearest.GetComponent[of Pickup1]().PickUp()
				else:
					holding.GetComponent[of Pickup1]().Drop()
					
	def PhaseUp():
		p = Instantiate(PhaseIn, transform.position, transform.rotation)
		p.transform.parent = transform
		p.layer = gameObject.layer
			
		p = Instantiate(PhaseOut, other.transform.position, other.transform.rotation)
		p.layer = other.layer
		p.transform.parent = other.transform
		
	def PhaseDown():
		p = Instantiate(PhaseOut, transform.position, transform.rotation)
		p.layer = gameObject.layer
		p.transform.parent = transform
			
		p = Instantiate(PhaseIn, other.transform.position, other.transform.rotation)
		p.transform.parent = other.transform
		p.layer = other.layer
		
	def isClear():
		if holding == null:
			if Physics.Raycast(transform.position + Vector3(0, -0.9, 0), Vector3.right * facing, 0.7, ~(1 << 9)) == false:
				if Physics.Raycast(transform.position + Vector3(0, 0.9, 0), Vector3.right * facing, 0.7, ~(1 << 9)) == false:
					if Physics.Raycast(transform.position, Vector3.right * facing, 0.7, ~(1 << 9)) == false:
						return true
		else:
			if Physics.Raycast(transform.position + Vector3(0, -0.9, 0), Vector3.right * facing, 0.7, ~(1 << 9)) == false:
				if Input.GetAxis("Horizontal") > 0:
					x = 1.5
				else:
					x = -1.5
				if Physics.Raycast(transform.position + Vector3(x, 1.3, 0), Vector3.right * facing, 1.5, ~(1 << 9)) == false:
					if Physics.Raycast(transform.position, Vector3.right * facing, 0.7, ~(1 << 9)) == false:
						return true
				
		
	def OnMouseDown():
		
		if holding != null and turning == false:
			holding.GetComponent[of Pickup1]().Drop()

	def changeTransparency(alpha as single):
		for child as Transform in gameObject.transform:
			if child.GetComponent(SkinnedMeshRenderer):
				child.GetComponent(SkinnedMeshRenderer).material.color.a = alpha
				
	def changeGlow(glow as single):
		for child as Transform in gameObject.transform:
			if child.GetComponent(SkinnedMeshRenderer):
				child.GetComponent(SkinnedMeshRenderer).material.color.r = 1 + glow
				child.GetComponent(SkinnedMeshRenderer).material.color.g = 1 + glow
				child.GetComponent(SkinnedMeshRenderer).material.color.b = 1 + glow
				
	def changeRedGlow(glow as single):
		for child as Transform in gameObject.transform:
			if child.GetComponent(SkinnedMeshRenderer):
				child.GetComponent(SkinnedMeshRenderer).material.color.r = 1 + glow
				child.GetComponent(SkinnedMeshRenderer).material.color.g = 1 + glow/3
				child.GetComponent(SkinnedMeshRenderer).material.color.b = 1 + glow/3

	#enable/disable the collider and render of an object AND all its children
	# (in particular, the foot trigger child)
	def switch_states(gameObject as GameObject, isActive as bool):
		if (gameObject.renderer):
			gameObject.renderer.enabled = isActive
		if (gameObject.collider):
			gameObject.collider.enabled = isActive

		for  child  as Transform in gameObject.transform:
			if child.CompareTag("Particle") == false and child.name!="Feet":
				switch_states(child.gameObject, isActive)

	def finishLevel():
		# #Finished level, load one level past current 
		# #(accounting for index0=main menu, index1=loadLevelScreen, index(n)=winningscreen)
		nextLevelNum = Application.loadedLevel
		PlayerPrefs.SetInt("unlockedLevel"+(nextLevelNum-1),1)

		if nextLevelNum < (Application.levelCount-2):
			GetComponent(FadeScreen).startLevel("Level"+nextLevelNum)
		else: #No more levels
			GetComponent(FadeScreen).startLevel("WinningScreen")
	
	#check if world phasing is blocked by some object
	def checkPhaseSafe(phaseLevel as single): 
		#checks sphere on top and sphere on bottom just to be safe
		buffer = 0.2
		collider_rad = collider.bounds.extents.x + buffer # bound + buffer
		disToTop = collider.bounds.extents.y
		top_height = (collider.bounds.center.y + disToTop) - collider_rad - buffer
		bot_height = (collider.bounds.center.y - disToTop) + collider_rad + buffer
		top_pos = Vector3(collider.bounds.center.x, top_height, collider.bounds.center.z)
		bot_pos = Vector3(collider.bounds.center.x, bot_height, collider.bounds.center.z)

		hitTop = Physics.OverlapSphere(top_pos, collider_rad)
		canHit = ["Player","Guard","Ground","Lazer", "Feet"]
		for h in hitTop:
			if isSameWorld(h.gameObject, phaseLevel) and (h.tag not in canHit):
				GameObject.Find("PhaseTop").GetComponent(PhaseTop).setTimer()
				GameObject.Find("PhaseBot").GetComponent(PhaseBot).setTimer()
				return false #hit something, so cant phase!
		hitBot = Physics.OverlapSphere(bot_pos, collider_rad)
		for h in hitBot:
			if isSameWorld(h.gameObject, phaseLevel) and (h.tag not in canHit):
				GameObject.Find("PhaseTop").GetComponent(PhaseTop).setTimer()
				GameObject.Find("PhaseBot").GetComponent(PhaseBot).setTimer()
				return false #hit something, so cant phase!
		return true

	#check if you are centred enough beneath a guard to explode them
	def checkPhaseKill(phaseLevel as single):
		guards = GameObject.FindGameObjectsWithTag('Guard')
		for g in guards:
			if g.name == "Lazer": continue
			#first check they are in relevant world for killing
			if (isSameWorld(g, phaseLevel)): 
				xDiff = Mathf.Abs(g.transform.position.x - transform.position.x)
				yDiff = Mathf.Abs(g.transform.position.y - transform.position.y) 
				if ( xDiff< distanceToKillX) and (yDiff< distanceToKillY):
					blood = Instantiate(BloodExplosion, g.transform.position, g.transform.rotation)
					blood.layer = g.layer
					for child as Transform in blood.transform:
						child.gameObject.layer = g.layer
					blood.transform.position.y += .3
					GameObject.Find("SoundEffects").GetComponent(SoundEffects).PlayGdeath(transform.position)
					Destroy(g) #close enough to centre of guard, so kill them
					exG = Instantiate(explodeGuard, g.transform.position, g.transform.rotation)
					exG.layer = g.layer
					ChangeLayersRecursively(exG.transform, g.layer) //change all the children to the needed layer
					break 
		
	def isSameWorld(obj as GameObject, phase as single):
		if (LayerMask.NameToLayer("Top World") == obj.layer and phase < 0): 
			return true
		if (LayerMask.NameToLayer("Bottom World") == obj.layer and phase > 0): 
			return true
				
	def OnTriggerStay(other as Collider):
		if not (other.CompareTag("Player") or other.CompareTag("Spring")):
			grounded = true
			
	def OnTriggerExit(other as Collider):
		grounded = false
		
		
	def GetNearestTagged() as GameObject:
        Tagged as (GameObject)= GameObject.FindGameObjectsWithTag('Pickup1')
        closest as GameObject
        distance as single = Mathf.Infinity
        position as Vector3 = transform.position
        
        for obj as GameObject in Tagged:
            difference as Vector3 = (obj.transform.position - position)
            curDistance as single = difference.sqrMagnitude
            if curDistance < distance:
                closest = obj
                distance = curDistance
        return closest
	
	def ChangeLayersRecursively(trans as Transform, layer as int):
	    for child as Transform in trans:
	        child.gameObject.layer = layer
	        ChangeLayersRecursively(child, layer)
		
	def OnGUI():
		
		if timeWon > 0:
			GUI.DrawTexture(Rect(0, 0, Screen.width, Screen.height), end_movie)