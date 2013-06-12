import UnityEngine

class CameraPlay (MonoBehaviour): 


	public def PlaySound(clip as AudioClip):
		audio.PlayOneShot(clip, 1f)

	private shakeAmount as single = 0
	private shakeTimer as single = 0

	def Shake(amount as single):
		shakeAmount = amount

	def Update ():
		if shakeTimer > 0 and Time.time > (shakeTimer+0.5):
			shakeTimer = 0
			shakeAmount = 0

		if (shakeAmount > 0 ):
			if shakeTimer == 0:
				shakeTimer = Time.time
			cam1 = GameObject.Find("Camera1")
			cam2 = GameObject.Find("Camera2")
			cam1.transform.position.x += Random.Range(-shakeAmount, shakeAmount)
			cam2.transform.position.x += Random.Range(-shakeAmount, shakeAmount)

