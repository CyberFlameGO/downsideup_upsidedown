import UnityEngine

class PlatformTrigger (MonoBehaviour): 

	PlatformScript as MovingPlatforms
	
	def Start ():
		PlatformScript = transform.parent.GetComponent[of MovingPlatforms]()
	
	def Update ():
		pass

	def OnTriggerEnter(other as Collider):
		if other.gameObject.tag == "Player":
			PlatformScript.PlatformForce = 150
			//Debug.Log("Player Entered")
			other.transform.parent = transform.parent
			
 			
	def OnTriggerExit(other as Collider):
		if other.gameObject.tag == "Player":
			PlatformScript.PlatformForce = 100
			//Debug.Log("Player Exited")
			other.transform.parent = null
			