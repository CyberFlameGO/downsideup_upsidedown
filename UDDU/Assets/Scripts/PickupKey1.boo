import UnityEngine

class PickupKey1 (MonoBehaviour): 
	
	private KeyHolding as bool
	private MouseHolding as bool
	private PlayerPos as  Vector3
	private nearestObj as GameObject
	private otherscript as PickupMouse1
	
	def GetPos():
		return PlayerPos
		
	def GetKeyHolding():
		return KeyHolding
		
	def SetKeyHolding(input as bool):
		KeyHolding = input

	def Start():
		KeyHolding = false
		PlayerPos = transform.position
		nearestObj = GetNearestTagged()
		if nearestObj!= null:
			otherscript = nearestObj.GetComponent[of PickupMouse1]()
			MouseHolding = otherscript.GetMouseHolding()
	
	def Update():
		PlayerPos = transform.position
		nearestObj = GetNearestTagged()
		if nearestObj!= null:
			otherscript = nearestObj.GetComponent[of PickupMouse1]()
			MouseHolding = otherscript.GetMouseHolding()
					
			if Input.GetButtonDown('Pickup1'):			
				if Vector3.Distance(nearestObj.transform.position, transform.position) < 3.0 and collider.enabled == true:
					if not KeyHolding and not MouseHolding:
						nearestObj.transform.parent = transform
						nearestObj.transform.localPosition = Vector3(0, 1, 1.5)
						nearestObj.rigidbody.isKinematic = true
						KeyHolding = true
						otherscript.SetMouseHolding(true)
					else:
						nearestObj.transform.parent = null
						nearestObj.rigidbody.isKinematic = false
						KeyHolding = false	
						otherscript.SetMouseHolding(false)			
				
	def GetNearestTagged() as GameObject:
        Tagged as (GameObject)= GameObject.FindGameObjectsWithTag('Pickup1')
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
				

