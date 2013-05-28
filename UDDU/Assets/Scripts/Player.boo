import UnityEngine

class Player (MonoBehaviour): 
	
	#constants
	public static speed as single = 6.0
	public static jump_speed as single = 9.0
	public static min_jump as single = 2.0
	
	public phase_thresh as single = 0.8

	#Gui variables
	public weightDisplay as GUIText
	public exit as GameObject
	public other as GameObject


	#state variables
	public static holding as GameObject = null
	private current_phase as single = 1.0F #starts in top world
	private grounded = false
	private attacked as bool = false

	# Variables so if user holds down phase key, will phase again after some time period
	private keyHoldCount = 0.2
	private keyWait = 0.2

	private distanceToKill as single #distance from centre of guard which will explode them
	
	//Audio Variables
	private phaseWarning as AudioSource
	private evasiveManeuvers as AudioSource


	def Start ():
		aSource as (Component) = GetComponents(AudioSource) //currently as a list, as we may want to add more audio later
		phaseWarning = aSource[0]
		evasiveManeuvers = aSource[1]
		if GetComponent(Attacked)!=null:
			attacked = true
		guards = GameObject.FindGameObjectsWithTag('Guard')
		if guards.Length > 0:
			mesh as Mesh = guards[0].GetComponent(MeshFilter).mesh #assumes all guards are same size
			distanceToKill = mesh.bounds.size.x

	def GetPhase():
		return current_phase

	#enable/disable the collider and render of an object AND all its children
	# (in particular, the foot trigger child)
	def switch_states(gameObject as GameObject, isActive as bool):
		if (gameObject.renderer):
			gameObject.renderer.enabled = isActive
		if (gameObject.collider):
			gameObject.collider.enabled = isActive

		for  child  as Transform in gameObject.transform:
				switch_states(child.gameObject, isActive)

	def Update ():
		/*//if GetComponent[of Attacked]().isStunned():
		if GetComponent(Attacked).isStunned():
			if not evasiveManeuvers.isPlaying:
				evasiveManeuvers.Play()
		*/
		if transform.position.x > exit.transform.position.x:
			finishLevel()
		old_phase = current_phase
		vert_input = Input.GetAxisRaw("Vertical")
		if vert_input!=0:
			keyHoldCount-=Time.deltaTime
			if (Input.GetButtonDown("Vertical") or keyHoldCount<0):
				if vert_input>0 and current_phase<1: 
					current_phase+=0.5
					keyHoldCount=keyWait
				elif vert_input<0 and current_phase>-1: 
					current_phase-=0.5
					keyHoldCount=keyWait

		if (old_phase != 0.5 and current_phase==0.5) or (old_phase != -0.5 and current_phase==-0.5) : 
				#phased into other world, so check valid and if hit guard
				if not checkPhaseSafe(old_phase):
					if not phaseWarning.isPlaying://play audio
						phaseWarning.Play()
					current_phase= old_phase
				else:
					checkPhaseKill(old_phase)
		#Change mass based on phase.
		rigidbody.mass = current_phase + 1.01
		#Phase in and out of existence.
		if current_phase == -1:
			if holding != null:
				holding.GetComponent[of Pickup1]().Drop()
			switch_states(gameObject, false)
			renderer.material.color.a = 0
		else:
			switch_states(gameObject, true)
			if current_phase == -0.5: renderer.material.color.a = 0.5
			else: renderer.material.color.a = 1
		
		if not attacked or not GetComponent(Attacked).isStunned():
			#Rotation
			if Input.GetAxis("Horizontal") < 0:
				if Mathf.Round(transform.eulerAngles.y) != 270:
					transform.eulerAngles.y = Mathf.Round(transform.eulerAngles.y+10)
			elif Input.GetAxis("Horizontal") > 0:
				if Mathf.Round(transform.eulerAngles.y) != 90:
					transform.eulerAngles.y = Mathf.Round(transform.eulerAngles.y-10)
						
			#Only jump or move if we're grounded.
			if grounded:

				if Mathf.Abs(rigidbody.velocity.x) < Mathf.Abs(Input.GetAxis("Horizontal") * speed):
					rigidbody.velocity.x = Input.GetAxis("Horizontal") * speed
				
				if Input.GetButtonDown("Jump"):
					rigidbody.velocity.y = jump_speed
					
					if Mathf.Abs(rigidbody.velocity.x) < min_jump:
						if transform.eulerAngles.y > 0 and transform.eulerAngles.y < 180:
							rigidbody.velocity.x = min_jump
						else:
							rigidbody.velocity.x = -min_jump
					
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

		weightDisplay.text = "Weight: " + Mathf.Round(((current_phase+1)/2) * 100.0) +"%"
		
		
		if Input.GetButtonDown('Pickup1'):
			if holding == null:
				nearest = GetNearestTagged()
				if nearest != null:
					nearest.GetComponent[of Pickup1]().PickUp()
			else:
				holding.GetComponent[of Pickup1]().Drop()
				
		
	def OnMouseDown():
		
		if holding != null:
			holding.GetComponent[of Pickup1]().Drop()
			

	def finishLevel():
		#Finished level, load one level past current 
		#(accounting for index0=main menu, index1=loadLevelScreen, index(n)=winningscreen)
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
		collider_rad = collider.bounds.extents.x + 0.2 # bound + buffer
		disToTop = collider.bounds.extents.y
		top_height = (collider.bounds.center.y + disToTop) - collider_rad - buffer
		bot_height = (collider.bounds.center.y - disToTop) + collider_rad + buffer
		top_pos = Vector3(collider.bounds.center.x, top_height, collider.bounds.center.z)
		bot_pos = Vector3(collider.bounds.center.x, bot_height, collider.bounds.center.z)

		hitTop = Physics.OverlapSphere(top_pos, collider_rad)
		canHit = ["Player","Guard","Ground","Lazer", "Feet"]
		for h in hitTop:
			if isSameWorld(h.gameObject, phaseLevel) and (h.tag not in canHit):
				return false #hit something, so cant phase!
		hitBot = Physics.OverlapSphere(bot_pos, collider_rad)
		for h in hitBot:
			if isSameWorld(h.gameObject, phaseLevel) and (h.tag not in canHit):
				return false #hit something, so cant phase!
		return true

	#check if you are centred enough beneath a guard to explode them
	def checkPhaseKill(phaseLevel as single):
		guards = GameObject.FindGameObjectsWithTag('Guard')
		for g in guards:
			if g.name == "Lazer": continue
			#first check they are in relvant world for killing
			if (isSameWorld(g, phaseLevel)): 
				if (Mathf.Abs(g.transform.position.x - transform.position.x) < distanceToKill):
					Destroy(g) #close enough to centre of guard, so kill em
					break 
		
	def isSameWorld(obj as GameObject, phase as single):
		if (LayerMask.NameToLayer("Top World") == obj.layer and phase < 0): 
			return true
		if (LayerMask.NameToLayer("Bottom World") == obj.layer and phase > 0): 
			return true
				
	def OnTriggerStay(other as Collider):
		if other.CompareTag("Player") == false:
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
	



