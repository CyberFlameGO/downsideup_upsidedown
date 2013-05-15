import UnityEngine

class Player (MonoBehaviour): 
	
	public speed as single = 6.0
	public jump_speed as single = 8.0
	public other as GameObject
	public phase_thresh as single = 0.8

	public weightDisplay as GUIText

	public exit as GameObject
	
	grounded = false
	public static holding as GameObject = null

	#state variables
	private TOP_PHASE as single = 0
	private BOTTOM_PHASE as single = 1
	private BOTH_PHASE as single = 2
	private phaseState = BOTH_PHASE

	private distanceToKill as single = 0.0F #distance from centre of guard which will explode them

	def Start ():
		guards = GameObject.FindGameObjectsWithTag('Guard')
		if guards.Length > 0:
			mesh as Mesh = guards[0].GetComponent(MeshFilter).mesh
			distanceToKill = mesh.bounds.size.x/1.5

	def Update ():
		if transform.position.x > exit.transform.position.x:
			finishLevel()

		phase = Input.GetAxis("Vertical")

		#Change mass based on phase.
		rigidbody.mass = phase + 1.01
		#Phase in and out of existence.
		if phase < -phase_thresh:
			renderer.enabled = false
			collider.enabled = false
		else:
			renderer.enabled = true
			collider.enabled = true
		
		mask as LayerMask = 8
		if Physics.Raycast(transform.position + Vector3(0, 0.4, 0), 
			Vector3.right * Input.GetAxis("Horizontal"), 0.5, ~(1 << 9)) == false and Physics.Raycast(
				transform.position + Vector3(0, -0.4, 0), Vector3.right * Input.GetAxis(
					"Horizontal"), 0.5, ~(1 << 9)) == false:
			rigidbody.velocity.x = Input.GetAxis("Horizontal") * speed
		
		#Rotation.
		if Input.GetAxis("Horizontal") < 0:
			if Mathf.Round(transform.eulerAngles.y) != 270:
				transform.eulerAngles.y = Mathf.Round(transform.eulerAngles.y+10)
		elif Input.GetAxis("Horizontal") > 0:
			if Mathf.Round(transform.eulerAngles.y) != 90:
				transform.eulerAngles.y = Mathf.Round(transform.eulerAngles.y-10)
		
		#Only jump if we're grounded.
		if grounded:
			if Input.GetButtonDown("Jump"):
				rigidbody.velocity.y = jump_speed
				
			
		if phase > -phase_thresh and phase < phase_thresh:
			if phaseState == BOTTOM_PHASE or phaseState == TOP_PHASE:
				phaseState = BOTH_PHASE
				checkPhaseKill()

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
			rigidbody.velocity.x = (rigidbody.velocity.x + other.rigidbody.velocity.x)/2
			rigidbody.velocity.y = (rigidbody.velocity.y + other.rigidbody.velocity.y)/2
			other.rigidbody.velocity.x = (x + other.rigidbody.velocity.x)/2
			other.rigidbody.velocity.y = (y + other.rigidbody.velocity.y)/2
		elif phase < -phase_thresh:
			#Player1 is inactive, set to player2.
			transform.position.x = other.transform.position.x
			transform.position.y = other.transform.position.y
			rigidbody.velocity.x = other.rigidbody.velocity.x
			rigidbody.velocity.y = other.rigidbody.velocity.y

			if phaseState == BOTH_PHASE:
				phaseState = BOTTOM_PHASE

		else:
			#Player2 is inactive, set to player1.
			other.transform.position.x = transform.position.x
			other.transform.position.y = transform.position.y
			other.rigidbody.velocity.x = rigidbody.velocity.x
			other.rigidbody.velocity.y = rigidbody.velocity.y

			if phaseState == BOTH_PHASE:
				phaseState = TOP_PHASE

		weightDisplay.text = "Weight: " + Mathf.Round(((phase+1)/2) * 100.0) +"%"
		
	def OnMouseDown():
		
		if holding != null:
			holding.transform.parent = null
			holding = null

	def finishLevel():
		#Finished level, load one level past current 
		#(accounting for index0=main menu, index1=loadLevelScreen, index(n)=winningscreen)
		nextLevelNum = Application.loadedLevel
		PlayerPrefs.SetInt("unlockedLevel"+(nextLevelNum-1),1)

		if nextLevelNum < (Application.levelCount-2):
			GetComponent(FadeScreen).startLevel("Level"+nextLevelNum)
		else: #No more levels
			GetComponent(FadeScreen).startLevel("WinningScreen")
			
	#check if you are centred enough beneath a guard to explode them
	def checkPhaseKill():
		guards = GameObject.FindGameObjectsWithTag('Guard')
		for g in guards:
			if (Mathf.Abs(g.transform.position.x - transform.position.x) < distanceToKill):
				Destroy(g) #close enough to centre of guard, so kill em
				break 
				
	def OnTriggerStay(other as Collider):
		if other.CompareTag("Player") == false:
			grounded = true
			
	def OnTriggerExit(other as Collider):
		grounded = false
	



		