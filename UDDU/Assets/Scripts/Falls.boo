import UnityEngine

class Falls (MonoBehaviour): 

	def Start ():
		pass
	
	def Update ():
		pass
	
	def OnCollisionEnter(collision as Collision):
		
		rigidbody.isKinematic = false