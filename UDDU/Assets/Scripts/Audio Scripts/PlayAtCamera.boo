import UnityEngine

class PlayAtCamera (MonoBehaviour): 

	private soundCamera as GameObject
	public clip as AudioClip
	private notPlayed as bool
	private player as GameObject
	private sound as AudioSource

	def Start ():
		player = GameObject.Find('Player1')
		soundCamera = GameObject.Find('Camera1')
		notPlayed = true
	
	def Update ():
		if notPlayed:
			if Vector3.Distance(transform.position, player.transform.position) < 3.0f:
				aSource as (Component) = soundCamera.GetComponents(AudioSource)
				for i in aSource:
					sound = i
					if sound.clip == clip:
						sound.Play()
				notPlayed = false
