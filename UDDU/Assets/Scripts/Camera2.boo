import UnityEngine

class Camera2 (MonoBehaviour): 
	
	public target as Transform

	def Start ():
		pass
	
	def Update ():
		
		transform.position.x = target.position.x
		transform.position.z = -target.position.z
		transform.position.y = target.position.y
		
		#transform.LookAt(target)
