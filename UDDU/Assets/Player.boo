import UnityEngine

class Player (MonoBehaviour): 
	
	public speed as single = 6.0
	public jump_speed as single = 8.0
	jumping = 0.0
	public gravity as single = 20.0
	
	static public phase as single = 0.0
	public phase_weight as single = 0.5
	public phase_friction as single = 0.1
	
	phase_speed as single = 0.0

	def Start ():
		pass
	
	def Update ():
		
		controller = GetComponent(CharacterController)
		
		moveDirection = Vector3(Input.GetAxis("Horizontal"), 0, 0)
		moveDirection = transform.TransformDirection(moveDirection)
		moveDirection *= speed
		
		if (controller.isGrounded) and Input.GetButton("Jump"):
			jumping = jump_speed
		if jumping > 0.0:
			moveDirection.y = jumping
			jumping -= gravity * Time.deltaTime
			if jumping < 0.0: jumping = 0.0
		
		moveDirection.y -= gravity 
		controller.Move(moveDirection * Time.deltaTime)
		
		if phase > 0.0:
			phase_speed -= phase_weight * Time.deltaTime
		elif phase < 0.0:
			phase_speed += phase_weight * Time.deltaTime
		
		phase_speed -= phase_speed * phase_friction * Time.deltaTime
		
		phase += phase_speed * Time.deltaTime
		
		if Mathf.Abs(phase_speed) < 0.05 and Mathf.Abs(phase) < 0.05:
			phase_speed = 0.0
			phase = 0.0
			phase_speed = Input.GetAxis("Vertical")/2
		else:
			phase_speed += Input.GetAxis("Vertical") * Time.deltaTime
			
		#phase = Input.GetAxis("Vertical")
		
		if phase > 0.0:
			gameObject.layer = 8
		elif phase < 0.0:
			gameObject.layer = 9
		else:
			gameObject.layer = 0		
                                  
		

