import UnityEngine

class PickUp (MonoBehaviour): 
	
	public player as GameObject
	public inputString as string
	private Holding as bool

	def Start ():
		Holding = false
	
	def Update ():
		if transform.parent != null:
			if player.collider.enabled == false:
				transform.parent = null
				rigidbody.isKinematic = false
				
		if Input.GetButtonDown(inputString):
			nearestObj as GameObject = GetNearestTagged()
			if Vector3.Distance(nearestObj.transform.position, player.transform.position) < 3.0 and player.collider.enabled == true:
				if not Holding:
					nearestObj.transform.parent = player.transform
					nearestObj.transform.localPosition = Vector3(0, 1, 1.5)
					nearestObj.rigidbody.isKinematic = true
					Holding = true
				else:
					nearestObj.transform.parent = null
					nearestObj.rigidbody.isKinematic = false
					Holding = false
					
		
	def OnMouseDown():
		if Vector3.Distance(transform.position, player.transform.position) < 3.0 and player.collider.enabled == true:
			if transform.parent == null:
				transform.parent = player.transform
				transform.localPosition = Vector3(0, 1, 1.5)
				rigidbody.isKinematic = true
			else:
				transform.parent = null
				rigidbody.isKinematic = false	
				
				
	def GetNearestTagged() as GameObject:
        Tagged as (GameObject)= GameObject.FindGameObjectsWithTag(inputString)
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
				

