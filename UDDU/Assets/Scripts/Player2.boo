import UnityEngine

class Player2 (MonoBehaviour): 
	
	public speed as single = 6.0
	public jump_speed as single = 8.0
	public phase_thresh as single = 0.8
	
	public other as GameObject

	public weightDisplay as GUIText

	grounded = false

	#enable/disable the collider and render of an object AND all its children
	# (in particular, the foot trigger child)
	def switch_states(gameObject as GameObject, isActive as bool):
		if (gameObject.renderer):
			gameObject.renderer.enabled = isActive
		if (gameObject.collider):
			gameObject.collider.enabled = isActive

		for  child  as Transform in gameObject.transform:
				switch_states(child.gameObject, isActive)

				
	def GetPhase():
		return other.GetComponent(Player).GetPhase()
	
	def Update ():
		current_phase = other.GetComponent(Player).GetPhase()
		rigidbody.mass = 1.01 - current_phase

		#Phase in and out of existence.
		if current_phase == 1:
			switch_states(gameObject, false)
			renderer.material.color.a = 0
		else:
			switch_states(gameObject, true)
			if current_phase == 0.5: renderer.material.color.a = 0.5
			else: renderer.material.color.a = 1
		
		if Physics.Raycast(transform.position + Vector3(0, 0.4, 0), 
			Vector3.right * Input.GetAxis("Horizontal"), 0.5, ~(1 << 8)) == false and Physics.Raycast(
				transform.position + Vector3(0, -0.4, 0), Vector3.right * Input.GetAxis(
					"Horizontal"), 0.5, ~(1 << 8)) == false:
			rigidbody.velocity.x = Input.GetAxis("Horizontal") * speed
			
		if Input.GetAxis("Horizontal") < 0:
			if Mathf.Round(transform.eulerAngles.y) != 270:
				transform.eulerAngles.y = Mathf.Round(transform.eulerAngles.y-10)
		elif Input.GetAxis("Horizontal") > 0:
			if Mathf.Round(transform.eulerAngles.y) != 90:
				transform.eulerAngles.y = Mathf.Round(transform.eulerAngles.y+10)
		
		if grounded:
			if Input.GetButtonDown("Jump"):
				rigidbody.velocity.y = jump_speed

		weightDisplay.text = "Weight: " + Mathf.Round(((current_phase-1)/2) * -100.0) +"%"
			

	def OnMouseDown():
		
		if Player.holding != null:
			Player.holding.transform.parent = null
			Player.holding = null
			
	def OnTriggerStay(other as Collider):
		
		if other.CompareTag("Player") == false:
			grounded = true
			
	def OnTriggerExit(other as Collider):
		
		grounded = false
			
