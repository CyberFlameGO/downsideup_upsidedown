import UnityEngine

class Shoot (MonoBehaviour): 
	public bullet as Transform
	public bulletSpeed as single  = 1000F

	private shootTime as single =0
	private shootDir as Vector3 = Vector3(-1,0,0)

	def Start ():
		pass
	
	def Update ():
		if (Time.time-shootTime) > 2: #shoot every 2 secs
			pos as Vector3 = Vector3(transform.position.x,transform.position.y+0.5,transform.position.z)
			bullet as Transform = Instantiate(bullet, pos, transform.rotation)
			Physics.IgnoreCollision(bullet.collider, collider)

	    	# Add force to the cloned object in the object's forward direction
			bullet.rigidbody.AddForce(shootDir * bulletSpeed)
			shootTime = Time.time
