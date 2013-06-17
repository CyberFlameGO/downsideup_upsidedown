import UnityEngine

class Pickup1 (MonoBehaviour): 
	
	public PickUpRange as single = 3.0
	
	private player as GameObject
	private playerScript as Player
	private anim as Animator
	private pickupState as int
	
	def Start ():
		player = GameObject.Find('Player1')
		transform.parent = null
		playerScript = player.GetComponent[of Player]()
		anim = player.GetComponent[of Animator]()
		pickupState = Animator.StringToHash('Pickup')
		
	def Update ():
		
		pass
		
	def OnMouseDown():
		if playerScript.holding == null:
			PickUp()

		else:
			Drop()
				
				
	def Drop():
		anim.SetBool(pickupState, false)
		transform.localPosition = Vector3(0, 1.5, 1.7)
		transform.parent = null
		gameObject.AddComponent(Rigidbody)
		playerScript.holding = null
		
		rigidbody.mass = 1
		rigidbody.drag = 0.05
		rigidbody.constraints = RigidbodyConstraints.FreezeRotation | RigidbodyConstraints.FreezePositionZ
		
		
	def PickUp():
		if Vector3.Distance(transform.position, player.transform.position) < PickUpRange and player.collider.enabled == true:
			anim.SetBool(pickupState, true)
			transform.parent = player.transform
			transform.localPosition = Vector3(0, 1.5, 1.7)
			Destroy(rigidbody)
			playerScript.holding = gameObject
			
	def OnCollisionEnter(collision as Collision):
		#if Mathf.Abs(rigidbody.velocity.x) + Mathf.Abs(rigidbody.velocity.y) > 0.1:
			GameObject.Find("SoundEffects").GetComponent(SoundEffects).PlayBox(transform.position)
		
