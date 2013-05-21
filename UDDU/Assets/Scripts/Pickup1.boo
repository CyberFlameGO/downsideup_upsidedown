import UnityEngine

class Pickup1 (MonoBehaviour): 
	
	public PickUpRange as single = 3.0
	
	private player as GameObject
	
	def Start ():
		player = GameObject.Find('Player1')
		transform.parent = null
		
	def Update ():
		
		pass
		
	def OnMouseDown():
		if Player.holding == null:
			PickUp()

		else:
			Drop()
				
				
	def Drop():
		transform.localPosition = Vector3(0, 1, 1.5)
		transform.parent = null
		gameObject.AddComponent(Rigidbody)
		Player.holding = null
		
		rigidbody.mass = 100
		rigidbody.constraints = RigidbodyConstraints.FreezeRotation | RigidbodyConstraints.FreezePositionZ
		
		
	def PickUp():
		if Vector3.Distance(transform.position, player.transform.position) < PickUpRange and player.collider.enabled == true:
			transform.parent = player.transform
			transform.localPosition = Vector3(0, 2, 0.5)
			Destroy(rigidbody)
			Player.holding = gameObject
		
