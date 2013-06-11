import UnityEngine

class Pause (MonoBehaviour): 

	private isPaused as bool

	def Start ():
		isPaused = false
	
	def Update ():

		if Input.GetKeyDown(KeyCode.Escape):

			if Time.timeScale!=0.0F:
				Time.timeScale=0.0F
				isPaused = true
			
			elif Time.timeScale==0.0F:
				Time.timeScale=1.0F
				isPaused = false
				
	def GetIsPaused() as bool:
		return isPaused
		
	
