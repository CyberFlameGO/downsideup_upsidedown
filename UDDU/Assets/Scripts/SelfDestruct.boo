import UnityEngine

class SelfDestruct (MonoBehaviour): 

	def Start ():
		pass
	
	def Update ():
		Destroy(gameObject, 1)
