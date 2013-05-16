import UnityEngine

class PickupMouse1 (MonoBehaviour): 
	
	private player as GameObject
	private MouseHolding as bool
	private KeyHolding as bool
	private PlayerPos as  Vector3
	private otherscript as PickupKey1

	def GetMouseHolding():
		return MouseHolding
		
	def SetMouseHolding(input as bool):
		MouseHolding = input
	
	def Start ():
		MouseHolding = false
		player = GameObject.Find('Player1')
		otherscript = player.GetComponent[of PickupKey1]()
		PlayerPos = otherscript.GetPos()
		MouseHolding = otherscript.GetKeyHolding()
		
	def Update ():
		PlayerPos = otherscript.GetPos()
		MouseHolding = otherscript.GetKeyHolding()
		if transform.parent != null:
			if player.collider.enabled == false:
				transform.parent = null
				rigidbody.isKinematic = false
		
		
	def OnMouseDown():
		if Vector3.Distance(transform.position, PlayerPos) < 3.0 and player.collider.enabled == true:
			if not MouseHolding and not KeyHolding:
				transform.parent = player.transform
				transform.localPosition = Vector3(0, 1, 1.5)
				rigidbody.isKinematic = true
				MouseHolding = true
				otherscript.SetKeyHolding(true)
			else:
				transform.parent = null
				rigidbody.isKinematic = false
				MouseHolding = false
				otherscript.SetKeyHolding(false)