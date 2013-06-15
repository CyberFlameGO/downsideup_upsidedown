import UnityEngine

class Pickup2 (MonoBehaviour): 
	
	public PickUpRange as single = 3.0
	
	private player as GameObject
	private anim as Animator
	private pickupState as int
	
	def Start ():
		player = GameObject.Find('Player2')
		transform.parent = null
		anim = player.GetComponent[of Animator]()
		pickupState = Animator.StringToHash('Pickup')
		
	def Update ():
		
		pass
		
	def OnMouseDown():
		if Player2.holding == null:
			PickUp()
		else:
			Drop()
				
				
	def Drop():
		anim.SetBool(pickupState, false)
		transform.localPosition = Vector3(0, 1.3, 1.5)
		transform.parent = null
		gameObject.AddComponent(Rigidbody)
		Player2.holding = null
		
		rigidbody.mass = 1
		rigidbody.drag = 0.05
		rigidbody.constraints = RigidbodyConstraints.FreezeRotation | RigidbodyConstraints.FreezePositionZ
		
		
	def PickUp():
		if Vector3.Distance(transform.position, player.transform.position) < PickUpRange and player.collider.enabled == true:
			anim.SetBool(pickupState, true)
			transform.parent = player.transform
			transform.localPosition = Vector3(0, 1.3, 1.5)
			Destroy(rigidbody)
			Player2.holding = gameObject
			
	def OnCollisionEnter(collision as Collision):
		#if Mathf.Abs(rigidbody.velocity.x) + Mathf.Abs(rigidbody.velocity.y) > 0.8:
			GameObject.Find("SoundEffects").GetComponent(SoundEffects).PlayBox(transform.position)
		