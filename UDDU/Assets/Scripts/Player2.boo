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
		
		rigidbody.velocity.x = Input.GetAxis("Horizontal") * speed
		if grounded > 0.1:
		
			if Input.GetButtonDown("Jump"):
				rigidbody.velocity.y = jump_speed
			
		if Mathf.Abs(rigidbody.velocity.y) < 0.1:
			grounded += Time.deltaTime
		else:
			grounded = 0
