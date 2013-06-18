import UnityEngine

class Player2 (MonoBehaviour): 
	
	public phase_thresh as single = 0.8
	
	public other as GameObject

	grounded = false

	private anim as Animator
	
	private turn_speed as single = 500.0
	private facing as int = 1
	private turning as bool = false

	public static holding as GameObject = null

	# HashID
	private walkingState as int
	private jumpState as int

	def Start ():
		transform.eulerAngles.y = 90
		
		walkingState = Animator.StringToHash('Walk')
		jumpState = Animator.StringToHash('Jump')
		anim = GetComponent[of Animator]()

	def GetGrounded():
		return grounded
	
	def Update ():
		current_phase = other.GetComponent(Player).GetPhase()
		rigidbody.mass = 1.01 - current_phase

		#Phase in and out of existence.
		if current_phase == 1:
			if holding != null:
				holding.GetComponent[of Pickup2]().Drop()
			switch_states(gameObject, false)
			changeTransparency(0)
		else:
			switch_states(gameObject, true)
			if current_phase == 0.5: changeTransparency(0.5)
			else: changeTransparency(1)
		
			
		#Rotation
		turning = false
		if Input.GetAxis("Horizontal") < 0:
			facing = -1
		elif Input.GetAxis("Horizontal") > 0:
			facing = 1
		if facing == 1:
			if Mathf.Round(transform.eulerAngles.y) <= 85 or Mathf.Round(transform.eulerAngles.y) >= 95:
				turning = true
				transform.eulerAngles.y = Mathf.Round(transform.eulerAngles.y+Mathf.Clamp(turn_speed*Time.deltaTime, 0, 8))
		else:
			if Mathf.Round(transform.eulerAngles.y) <= 265 or Mathf.Round(transform.eulerAngles.y) >= 275:
				turning = true
				transform.eulerAngles.y = Mathf.Round(transform.eulerAngles.y-Mathf.Clamp(turn_speed*Time.deltaTime, 0, 8))
				
		#Movement.
		anim.SetBool(walkingState, false)
		if isClear():
			if current_phase > -1 and other.GetComponent(Player).isClear() == false:
				pass
			else:
				if grounded == false:
					max_speed = Mathf.Abs(Mathf.Clamp(Player.speed*facing - Mathf.Clamp(rigidbody.velocity.x, -Player.speed, Player.speed), -Player.speed, Player.speed))
				else:
					max_speed = Player.speed
				transform.position.x += Input.GetAxis("Horizontal") * max_speed  * Time.deltaTime
				if Mathf.Abs(Input.GetAxis("Horizontal")) > 0.1:
					anim.SetBool(walkingState, true)

					
		if grounded:
			
			if Input.GetButtonDown("Jump"):
				anim.SetBool(jumpState, true)
				rigidbody.velocity.y = Player.jump_speed
			else:
				anim.SetBool(jumpState, false)			
			
		if Input.GetButtonDown('Pickup2'):
			if turning == false:
				if holding == null:
					nearest = GetNearestTagged()
					if nearest != null:
						nearest.GetComponent[of Pickup2]().PickUp()
				else:
					holding.GetComponent[of Pickup2]().Drop()
					
	def isClear():
		if holding == null:
			if Physics.Raycast(transform.position + Vector3(0, -0.9, 0), Vector3.right * facing, 0.7, ~(1 << 8)) == false:
				if Physics.Raycast(transform.position + Vector3(0, 0.9, 0), Vector3.right * facing, 0.7, ~(1 << 8)) == false:
					if Physics.Raycast(transform.position, Vector3.right * facing, 0.7, ~(1 << 8)) == false:
						return true
		else:
			if Physics.Raycast(transform.position + Vector3(0, -0.9, 0), Vector3.right * facing, 0.7, ~(1 << 8)) == false:
				if Input.GetAxis("Horizontal") > 0:
					x = 1.5
				else:
					x = -1.5
				if Physics.Raycast(transform.position + Vector3(x, 1.3, 0), Vector3.right * facing, 1.5, ~(1 << 8)) == false:
					if Physics.Raycast(transform.position, Vector3.right * facing, 0.7, ~(1 << 8)) == false:
						return true


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

	def OnMouseDown():
		
		if holding != null and turning == false:
			holding.GetComponent[of Pickup2]().Drop()
			
	def OnTriggerStay(other as Collider):
		
		if other.CompareTag("Player") == false:
			grounded = true
			
	def OnTriggerExit(other as Collider):
		
		grounded = false
			
	def GetNearestTagged() as GameObject:
        Tagged as (GameObject)= GameObject.FindGameObjectsWithTag('Pickup2')
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
