import UnityEngine

class MainMenuButton (MonoBehaviour): 
	private maxLevels = 5

	def OnMouseDown():

		numUnlocked = 1
		for i in range(maxLevels):
			if PlayerPrefs.GetInt("unlockedLevel" +i) == 1: #has unlocked this level
				numUnlocked = i

		if name=="Continue" and numUnlocked>1:
			Application.LoadLevel("Level" + numUnlocked)
		if name=="New Game":
			Application.LoadLevel("Level1")
		if name=="Select Level":
			Application.LoadLevel("LoadLevel")
		if name=="Controls":
			Application.LoadLevel("ControlsScreen")
		if name=="Quit":
			Application.Quit()


	def OnMouseEnter():
		GetComponent(GUIText).material.color = Color.black

	def OnMouseExit():
		GetComponent(GUIText).material.color = Color.white
