import UnityEngine

class PhaseBot (MonoBehaviour): 
	
	public player as GameObject
	public pcamera as Camera

	private currentColour = Color.white
	private redTimer = 0
	
	def LateUpdate ():
		particleSystem.emissionRate = ((-player.GetComponent(Player).GetPhase())*100 + 100)/2 + 10
		transform.position = pcamera.ScreenToWorldPoint (Vector3 (75,75,pcamera.nearClipPlane + 1.5))
		particleSystem.startColor = currentColour
		if Time.time-redTimer<1 and Time.time > 2:
			particleSystem.startColor  = Color.red
		else:
			redTimer = 0

	def setRed(isRed as bool):
		if isRed:
			currentColour = Color.red
		else:
			currentColour = Color.white

	def setTimer():
		redTimer = Time.time