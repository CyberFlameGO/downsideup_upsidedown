import UnityEngine

#Testing commiting from uni macs
class Falls (MonoBehaviour): 

	def Start ():
		pass
	
	def Update ():
		pass
	
	def OnCollisionEnter(collision as Collision):
		
		rigidbody.isKinematic = false
