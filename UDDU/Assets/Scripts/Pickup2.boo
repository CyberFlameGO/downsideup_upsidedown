import UnityEngine

class Pickup2 (MonoBehaviour): 
	
	public PickUpRange as single = 3.0
	
	private player as GameObject
	
	def Start ():
		player = GameObject.Find('Player2')
		transform.parent = null
		
	def Update ():
		
		pass
		
	def OnMouseDown():
		if Player2.holding == null:
			PickUp()
		else:
			Drop()
				
				
	def Drop():
		transform.localPosition = Vector3(0, 1.3, 1.5)
		transform.parent = null
		gameObject.AddComponent(Rigidbody)
		Player2.holding = null
		
		rigidbody.mass = 100
		rigidbody.constraints = RigidbodyConstraints.FreezeRotation | RigidbodyConstraints.FreezePositionZ
		
		
	def PickUp():
		if Vector3.Distance(transform.position, player.transform.position) < PickUpRange and player.collider.enabled == true:
			transform.parent = player.transform
			transform.localPosition = Vector3(0, 1.3, 1.5)
			Destroy(rigidbody)
			Player2.holding = gameObject
		