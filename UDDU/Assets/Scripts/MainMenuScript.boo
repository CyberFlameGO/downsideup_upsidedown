import UnityEngine

class MainMenuScript (MonoBehaviour): 

	def OnGUI ():
		GUILayout.BeginArea( Rect(Screen.width/2-100, Screen.height/2-100,200,200))
		GUILayout.FlexibleSpace()

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