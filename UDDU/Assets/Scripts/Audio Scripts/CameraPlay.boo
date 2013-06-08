import UnityEngine

class CameraPlay (MonoBehaviour): 

	def Start ():
		pass
	
	def Update ():
		pass

	public def PlaySound(clip as AudioClip):
		audio.PlayOneShot(clip, 1f)