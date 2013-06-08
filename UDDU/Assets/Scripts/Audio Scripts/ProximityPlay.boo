import UnityEngine

class ProximityPlay (MonoBehaviour): 

	private player as GameObject
	private notPlayed as bool
	private soundCamera as GameObject
	public clip as AudioClip

	def Start ():
		player = GameObject.Find('Player1')
		soundCamera = GameObject.Find('Camera1')
		notPlayed = true
	
	def Update ():
		if notPlayed:
			if Vector3.Distance(transform.position, player.transform.position) < 3.0f:
				soundCamera.GetComponent[of CameraPlay]().PlaySound(clip)
				notPlayed = false
