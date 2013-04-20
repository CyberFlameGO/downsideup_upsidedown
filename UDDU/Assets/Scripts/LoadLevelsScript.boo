import UnityEngine

class LoadLevelsScript (MonoBehaviour): 

	def Start ():
		pass
	
	def Update ():
		pass

	def OnGUI ():
		GUILayout.BeginArea( Rect(Screen.width/2-100, Screen.height/2-100,200,200))
		GUILayout.FlexibleSpace()
		if GUILayout.Button("Level 1"):
			Application.LoadLevel("prototype")
		GUILayout.FlexibleSpace()
		GUILayout.EndArea()