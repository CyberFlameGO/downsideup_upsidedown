import UnityEngine

class PickUp (MonoBehaviour): 
	
	public player as GameObject

	def Start ():
		pass
	
	def Update ():
		
		if transform.parent != null:
			if player.collider.enabled == false:
				transform.parent = null
				rigidbody.isKinematic = false
				
		if Input.GetButtonDown('Pickup'):
			if Vector3.Distance(transform.position, player.transform.position) < 3.0 and player.collider.enabled == true:
				if transform.parent == null:
					transform.parent = player.transform
					transform.localPosition = Vector3(1.5, 1, 0)
					rigidbody.isKinematic = true
				else:
					transform.parent = null
					rigidbody.isKinematic = false
		
	def OnMouseDown():
		
		if Vector3.Distance(transform.position, player.transform.position) < 3.0 and player.collider.enabled == true:
			if transform.parent == null:
				transform.parent = player.transform
				transform.localPosition = Vector3(0, 1, 1.5)
				rigidbody.isKinematic = true
			else:
				transform.parent = null
				rigidbody.isKinematic = false
