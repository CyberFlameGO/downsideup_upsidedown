import UnityEngine

class Player2 (MonoBehaviour): 
	
	public speed as single = 6.0
	public jump_speed as single = 8.0
	public phase_thresh as single = 0.8
	
	public other as GameObject
	
	grounded = 0.0

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
		
		if Physics.Raycast(transform.position, Vector3.right * Input.GetAxis("Horizontal"), 0.5) == false:
			rigidbody.velocity.x = Input.GetAxis("Horizontal") * speed
			
		if Input.GetAxis("Horizontal") < 0:
			if Mathf.Round(transform.eulerAngles.y) != 180:
				transform.eulerAngles.y = Mathf.Round(transform.eulerAngles.y-10)
		elif Input.GetAxis("Horizontal") > 0:
			if Mathf.Round(transform.eulerAngles.y) != 0:
				transform.eulerAngles.y = Mathf.Round(transform.eulerAngles.y+10)
		
		if grounded > 0.1:
		
			if Input.GetButtonDown("Jump"):
				rigidbody.velocity.y = jump_speed
			
		if Mathf.Abs(rigidbody.velocity.y) < 0.1:
			grounded += Time.deltaTime
		else:
			grounded = 0
			
			
	def OnMouseDown():
		
		if Player.holding != null:
			Player.holding.transform.parent = null
			Player.holding = null
