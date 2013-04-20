import UnityEngine

class MainMenuScript (MonoBehaviour): 

	def Start ():
		pass
	
	def Update ():
		pass

	def OnGUI ():
		GUILayout.BeginArea( Rect(Screen.width/2-100, Screen.height/2-100,200,200))
		GUILayout.FlexibleSpace()
		if GUILayout.Button("New Game"):
			Application.LoadLevel("prototype")
		if GUILayout.Button("Select Level"):
			Application.LoadLevel("LoadLevel")
		 #For easy debugging. May not want in actual game. To be discussed
		
		GUILayout.FlexibleSpace()
		GUILayout.EndArea()