import UnityEngine

class Spring (MonoBehaviour): 
	private rotatedTime = 0 #time since rotated
	def Start ():
		pass
	
	def Update ():

		if transform.eulerAngles.z < 360 and transform.eulerAngles.z > 270 :
			transform.eulerAngles.z = Mathf.Round(transform.eulerAngles.z-5)
	
		if (transform.eulerAngles.z <=270 and not transform.eulerAngles.z==0) and (Time.time-rotatedTime>2):
			Debug.Log("reset")
			rotatedTime = 0
			# transform.rotation.x = 0
			transform.eulerAngles.z = 0


	def OnCollisionEnter(collision as Collision):

		if collision.gameObject.tag == "Player":
			transform.Rotate(0,0,-5)
			flipAngle = Vector3(500,1000,0)
			collision.gameObject.rigidbody.AddForce(flipAngle)
			rotatedTime = Time.time
