import UnityEngine

class WalkLoop (MonoBehaviour): 

	def Start ():
		pass
	
	def Update ():
		if not animation.IsPlaying("Walking"):
			animation.Play("Walking")
