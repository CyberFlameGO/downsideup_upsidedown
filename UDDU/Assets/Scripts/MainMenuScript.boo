import UnityEngine

class MainMenuScript (MonoBehaviour): 
	private maxLevels = 5
	def OnGUI ():
		GUILayout.BeginArea( Rect(Screen.width/2-100, Screen.height/2-100,200,200))
		GUILayout.FlexibleSpace()

		numUnlocked = 1
		for i in range(maxLevels):
			if PlayerPrefs.GetInt("unlockedLevel" +i) == 1: #has unlocked this level
				numUnlocked = i
		if GUILayout.Button("Continue") and numUnlocked>1:
			Application.LoadLevel("Level" + numUnlocked)
		if GUILayout.Button("New Game"):
			Application.LoadLevel("Level1")
		if GUILayout.Button("Select Level"):
			Application.LoadLevel("LoadLevel")
		# if GUILayout.Button("Controls"):
			# Application.LoadLevel("Controls")
		if GUILayout.Button("Quit"):
			Application.Quit()
		
		GUILayout.FlexibleSpace()
		GUILayout.EndArea()