import UnityEngine

class Spring (MonoBehaviour): 
	public yForce = 500
	public xForce = 500
	
	private rotatedTime = 0 #time since rotated
	
	private delay as single = 0.0


	def OnCollisionEnter(collision as Collision):
		if (collision.gameObject.tag == "Player" or collision.gameObject.tag == "Pickup1" or collision.gameObject.tag == "Pickup2"):
			delay = Time.time
			
#			transform.Rotate(0,0,-5)
#			flipAngle = Vector3(xForce,yForce,0)
#			collision.gameObject.rigidbody.AddForce(flipAngle)
#			rotatedTime = Time.time

	def OnCollisionStay(collision as Collision):
		if (collision.gameObject.tag == "Player" or collision.gameObject.tag == "Pickup1" or collision.gameObject.tag == "Pickup2") :
			if Time.time - delay > 0.25:
				GameObject.Find("SoundEffects").GetComponent(SoundEffects).PlayLaunch(transform.position)
				if GetComponent(Animation):
					GetComponent(Animation).Play("SpringDown")
				# transform.Rotate(0,0,-5)
				collision.gameObject.rigidbody.velocity = Vector3(0, 0, 0)
				collision.gameObject.transform.position = transform.TransformPoint(-0.5, .5, 0)
				#collision.gameObject.transform.position.y += 1.5
				#collision.gameObject.transform.position.x += 2.5
				
				flipAngle = Vector3(xForce,yForce,0)
				collision.gameObject.rigidbody.AddForce(flipAngle)
				rotatedTime = Time.time
		