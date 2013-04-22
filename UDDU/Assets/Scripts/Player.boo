import UnityEngine

class Player (MonoBehaviour): 
	
	public speed as single = 6.0
	public jump_speed as single = 8.0
	public other as GameObject
	public phase_thresh as single = 0.8
	
	grounded = 0.0
	public static holding as GameObject = null

	def Start ():
		pass
	
	def Update ():
		
		phase = Input.GetAxis("Vertical")
		print(phase)
		#Change mass based on phase.
		rigidbody.mass = phase + 1.01
		#Phase in and out of existence.
		if phase < -phase_thresh:
			renderer.enabled = false
			collider.enabled = false
		else:
			renderer.enabled = true
			collider.enabled = true
		
		rigidbody.velocity.x = Input.GetAxis("Horizontal") * speed
		if Input.GetAxis("Horizontal") < 0:
			if Mathf.Round(transform.eulerAngles.y) != 180:
				transform.eulerAngles.y = Mathf.Round(transform.eulerAngles.y-10)
		elif Input.GetAxis("Horizontal") > 0:
			if Mathf.Round(transform.eulerAngles.y) != 0:
				transform.eulerAngles.y = Mathf.Round(transform.eulerAngles.y+10)
		
		#Only jump if we've been grounded at least briefly.
		if grounded > 0.1:
			if Input.GetButtonDown("Jump"):
				rigidbody.velocity.y = jump_speed
		if Mathf.Abs(rigidbody.velocity.y) < 0.5:
			grounded += Time.deltaTime
		else:
			grounded = 0
			
		if phase > -phase_thresh and phase < phase_thresh:
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
		else:
			#Player2 is inactive, set to player1.
			other.transform.position.x = transform.position.x
			other.transform.position.y = transform.position.y
			other.rigidbody.velocity.x = rigidbody.velocity.x
			other.rigidbody.velocity.y = rigidbody.velocity.y
			
	def OnMouseDown():
		
		if holding != null:
			holding.transform.parent = null
			holding = null