import UnityEngine

class Spring (MonoBehaviour): 
	public yForce = 500
	public xForce = 500
	public maxForce = 1000
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
		Debug.Log("mass: "+collision.gameObject.rigidbody.mass)
		if collision.gameObject.tag == "Player" and not rotatedTime>0:
			transform.Rotate(0,0,-5)
			
			flipAngle = Vector3(xForce,yForce,0)
			collision.gameObject.rigidbody.AddForce(flipAngle)
			rotatedTime = Time.time
