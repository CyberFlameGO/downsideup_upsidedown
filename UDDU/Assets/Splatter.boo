import UnityEngine

class Splatter (MonoBehaviour): 

	def Start ():
		GameObject.Find("SoundEffects").GetComponent(SoundEffects).PlayGdeath(transform.position)
		GameObject.Find("SoundEffects").GetComponent(SoundEffects).PlaySplatter(transform.position)
	
	def Update ():
		pass
