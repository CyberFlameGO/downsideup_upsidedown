import UnityEngine

class PhaseTop (MonoBehaviour): 
	
	public player as GameObject
	
	public pcamera as Camera

	def Start ():
		pass
	
	def LateUpdate ():
		particleSystem.emissionRate = (player.GetComponent(Player).PhaseLevel()*100 + 100)/2 + 10
		transform.position = pcamera.ScreenToWorldPoint (Vector3 (75,Screen.height-75,pcamera.nearClipPlane + 1.5))
