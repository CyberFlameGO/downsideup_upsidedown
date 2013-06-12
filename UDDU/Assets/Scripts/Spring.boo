import UnityEngine

class Spring (MonoBehaviour): 
	public yForce = 500
	public xForce = 500
	
	private rotatedTime = 0 #time since rotated
	
	private delay as single = 0.0

	def Start ():
		pass
	
	def Update ():

		if transform.eulerAngles.z < 360 and transform.eulerAngles.z > 270 :
			transform.Rotate(0,0,-5)
	
		if (transform.eulerAngles.z <=270 and not transform.eulerAngles.z==0) and (Time.time-rotatedTime>2):
			rotatedTime = 0
			transform.eulerAngles.z = 0


	def OnCollisionEnter(collision as Collision):
		if (collision.gameObject.tag == "Player" or collision.gameObject.tag == "Pickup1" or collision.gameObject.tag == "Pickup2") and not rotatedTime>0:
			delay = Time.time
			
#			transform.Rotate(0,0,-5)
#			flipAngle = Vector3(xForce,yForce,0)
#			collision.gameObject.rigidbody.AddForce(flipAngle)
#			rotatedTime = Time.time

	def OnCollisionStay(collision as Collision):
		if (collision.gameObject.tag == "Player" or collision.gameObject.tag == "Pickup1" or collision.gameObject.tag == "Pickup2") and not rotatedTime>0:
			if Time.time - delay > 0.25:
				
				transform.Rotate(0,0,-5)
				collision.gameObject.rigidbody.velocity = Vector3(0, 0, 0)
				
				flipAngle = Vector3(xForce,yForce,0)
				collision.gameObject.rigidbody.AddForce(flipAngle)
				collision.gameObject.transform.position = transform.position
				collision.gameObject.transform.position.y += 2.0
				rotatedTime = Time.time
		