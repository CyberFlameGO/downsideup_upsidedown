import UnityEngine


class Crushed (MonoBehaviour): 
	public mat as Material
	private matInstance as Material
	private fall_threshold = -0.3
	def Start ():
		pass
	
	def Update ():
		pass

	def OnCollisionEnter(collision as Collision):
		if collision.rigidbody: Debug.Log(collision.rigidbody.velocity)
		if transform.localScale.y < 0.1:
			matInstance = Instantiate(mat)
			renderer.material = matInstance # BLOOD!
			# Destroy(gameObject)
		elif collision.rigidbody and collision.rigidbody.velocity.y < fall_threshold: # falling, crush them
			transform.localScale += Vector3(transform.localScale.y*1.5, -transform.localScale.y/1.5, transform.localScale.y*1.5)
