import UnityEngine

class BoxReturn (MonoBehaviour): 
	
	public x_limit as single
	private start_position as Vector3

	def Start ():
		start_position = transform.position
	
	def Update ():
		if transform.position.x > x_limit:
			rigidbody.velocity = Vector3(0,0,0)
			transform.position = start_position
			
