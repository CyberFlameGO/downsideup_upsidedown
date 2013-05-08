import UnityEngine

class Player2 (MonoBehaviour): 
	
	public speed as single = 6.0
	public jump_speed as single = 8.0
	public phase_thresh as single = 0.8
	
	public other as GameObject

	public weightDisplay as GUIText

	grounded = false

	def Start ():
		pass
	
	def Update ():
		
		phase = Input.GetAxis("Vertical")
		rigidbody.mass = 1.01 - phase
		
		if phase > phase_thresh:
			renderer.enabled = false
			collider.enabled = false
		else:
			renderer.enabled = true
			collider.enabled = true
		
		if Physics.Raycast(transform.position + Vector3(0, 0.25, 0), 
			Vector3.right * Input.GetAxis("Horizontal"), 0.5) == false and Physics.Raycast(
				transform.position + Vector3(0, -0.25, 0), Vector3.right * Input.GetAxis(
					"Horizontal"), 0.5) == false:
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

		weightDisplay.text = "Weight: " + Mathf.Round(((phase-1)/2) * -100.0) +"%"
		
		grounded = false
			

	def OnMouseDown():
		
		if Player.holding != null:
			Player.holding.transform.parent = null
			Player.holding = null
			
	def OnTriggerStay(other as Collider):
		
		if other.CompareTag("Player") == false:
			grounded = true
			
