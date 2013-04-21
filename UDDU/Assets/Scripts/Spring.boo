import UnityEngine

class Spring (MonoBehaviour): 

	def Start ():
		pass
	
	def Update ():
		pass
	
	def OnCollisionEnter(collision as Collision):
		
		collision.gameObject.rigidbody.AddForce(Vector3.up * 500)