import UnityEngine

class MainMenuButton (MonoBehaviour): 
	private maxLevels = 5
	private numUnlocked = 1

	def Start():
		for i in range(maxLevels):
			if PlayerPrefs.GetInt("unlockedLevel" +i) == 1: #has unlocked this level
				numUnlocked = i
		if name == "Continue" and numUnlocked == 1:
			Destroy(gameObject)

	def OnMouseDown():
		if name=="Continue":
			Application.LoadLevel("Level" + numUnlocked)
		if name=="New Game":
			Application.LoadLevel("Level0")
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
