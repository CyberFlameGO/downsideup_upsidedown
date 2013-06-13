import UnityEngine

class LoadLevelsScript (MonoBehaviour): 
	public maxLevels as single = 5

	def Start ():
		PlayerPrefs.SetInt("unlockedLevel1", 1) # ensures level one is always unlocked

	def OnGUI ():
		GUILayout.BeginArea( Rect(Screen.width/2-100, Screen.height/2-100,200,200))
		GUILayout.FlexibleSpace()

		for i in range(maxLevels):
			if PlayerPrefs.GetInt("unlockedLevel" +i) == 1: #has unlocked this level
				if GUILayout.Button("Level " + i):
					Application.LoadLevel("Level"+i)

		GUILayout.FlexibleSpace()
		GUILayout.EndArea()