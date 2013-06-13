import UnityEngine

class Pause (MonoBehaviour): 

	private isPaused as bool = false
	private loadLevel as bool = false
	public maxLevels as single = 5

	def Update ():
		if Input.GetKeyDown(KeyCode.Escape):

			if Time.timeScale!=0.0F:
				Time.timeScale=0.0F
				isPaused = true
			
			elif Time.timeScale==0.0F:
				Time.timeScale=1.0F
				isPaused = false

	def OnGUI ():
		if isPaused:
			GUILayout.BeginArea( Rect(Screen.width/2-100, Screen.height/2-100,200,200))
			GUILayout.FlexibleSpace()
			if not loadLevel:
				if GUILayout.Button("New Game"):
					Application.LoadLevel("Level1")
				if GUILayout.Button("Select Level"):
					loadLevel = true
				# if GUILayout.Button("Controls"):
					# Application.LoadLevel("Controls")
				if GUILayout.Button("Quit"):
					Application.Quit()
			else:
				for i in range(maxLevels):
					if PlayerPrefs.GetInt("unlockedLevel" +i) == 1: #has unlocked this level
						if GUILayout.Button("Level " + i):
							Application.LoadLevel("Level"+i)
				if GUILayout.Button("Back"):
					loadLevel = false
			
			GUILayout.FlexibleSpace()
			GUILayout.EndArea()

				
	def GetIsPaused() as bool:
		return isPaused


		
	
