import UnityEngine

class ProximityPlay (MonoBehaviour): 

	private player as GameObject
	private notPlayed as bool

	def Start ():
		player = GameObject.Find('Player1')
		notPlayed = true
	
	def Update ():
		if notPlayed:
			if Vector3.Distance(transform.position, player.transform.position) < 3.0f:
				audio.Play()
				notPlayed = false
