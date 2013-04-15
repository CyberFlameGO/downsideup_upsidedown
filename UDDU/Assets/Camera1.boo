import UnityEngine

class Camera1 (MonoBehaviour): 
	
	public target as Transform
	public height as single = 3.0

	def Start ():
		pass
	
	def Update ():
		
		transform.position.x = target.position.x
		transform.position.y = target.position.y + height
		
		#transform.LookAt(target)

