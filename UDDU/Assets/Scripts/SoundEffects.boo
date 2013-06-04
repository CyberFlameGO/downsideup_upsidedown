import UnityEngine

class SoundEffects (MonoBehaviour): 
	
	private zaps = []
	private growls = []
	private chatters = []
	
	
	def Start ():
		for n in range(10):
			z = Resources.Load("zap" + n.ToString())
			if z != null:
				zaps.Add(z)
				
			z = Resources.Load("growl" + n.ToString())
			if z != null:
				growls.Add(z)
				
			z = Resources.Load("chatter" + n.ToString())
			if z != null:
				chatters.Add(z)
	
	def Update ():
		pass
	
	def PlayZap(position as Vector3):
		
		audio.PlayClipAtPoint(zaps[Random.Range(0, zaps.Count)], position)
		
	def PlayGrowl(position as Vector3):
		
		audio.PlayClipAtPoint(growls[Random.Range(0, growls.Count)], position)
		
	def PlayChatter(position as Vector3):
		
		audio.PlayClipAtPoint(chatters[Random.Range(0, chatters.Count)], position)