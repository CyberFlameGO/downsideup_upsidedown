import UnityEngine

class Spring (MonoBehaviour): 
	private rotatedTime = 0 #current rotation aim
	def Start ():
		pass
	
	def Update ():

		# rotation = transform.rotation.z
		# Debug.Log("update "+transform.rotation)

		if transform.eulerAngles.z < 360 and transform.eulerAngles.z > 270 :
			Debug.Log("bigger")
			# transform.eulerAngles.z = Mathf.Round(transform.eulerAngles.z+10)
			# before = transform.rotation.x
			# transform.RotateAround (collider.bounds.center , Vector3.forward, 10)	
			# transform.Rotate(0,0,-10)
			transform.eulerAngles.z = Mathf.Round(transform.eulerAngles.z-5)


			# transform.rotation.x =  before + 10	
			Debug.Log("rotate "+transform.rotation.x)
	
		if (transform.eulerAngles.z <=270 and not transform.eulerAngles.z==0) and (Time.time-rotatedTime>2):
			Debug.Log("reset")
			rotatedTime = 0
			# transform.rotation.x = 0
			transform.eulerAngles.z = 0


	def OnCollisionEnter(collision as Collision):
		# if rotation > 0 and rotation < 90:
		# 	transform.RotateAround (collider.bounds.center , Vector3.forward, -10)

		if collision.gameObject.tag == "Player":
			transform.Rotate(0,0,-5)
			flipAngle = Vector3(500,1000,0)
			collision.gameObject.rigidbody.AddForce(flipAngle)
			rotatedTime = Time.time
			# transform.eulerAngles.z = Mathf.Round(transform.eulerAngles.z-10)
			# before = transform.rotation.x
			# transform.rotation.x =  before + 10	
			# transform.eulerAngles.z = Mathf.Round(transform.eulerAngles.z-5)
			# rotation = 10
			Debug.Log("rotate "+transform.rotation.x)


			# transform.RotateAround (collider.bounds.center , Vector3.forward, 10)	

				# transform.eulerAngles.z = Mathf.Round(transform.eulerAngles.z+90)

				# transform.RotateAround (collider.bounds.center , Vector3.forward, -90)
