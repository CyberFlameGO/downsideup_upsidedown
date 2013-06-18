import UnityEngine

class InGameMenuButton (MonoBehaviour): 

	private maxLevels = 5
	public controlsTextureTop as GUITexture
	public controlsTextureBot as GUITexture
	public backButton as GUIText


	def OnMouseDown():

		numUnlocked = 1
		for i in range(maxLevels):
			if PlayerPrefs.GetInt("unlockedLevel" +i) == 1: #has unlocked this level
				numUnlocked = i

		if name=="Continue" and numUnlocked>1:
			GameObject.Find("Pause").GetComponent(Pause).UnPause()
		if name=="Main Menu":
			Application.LoadLevel("Main Menu")
		if name=="Select Level":
			Application.LoadLevel("LoadLevel")
		if name=="Controls":
			Instantiate(controlsTextureTop)
			Instantiate(controlsTextureBot)
			Instantiate(backButton)
			menu = GameObject.Find("Menu Options(Clone)")
			for child as Transform in menu.transform:
				child.gameObject.SetActive(false)
		if name=="Quit":
			Application.Quit()


	def OnMouseEnter():
		GetComponent(GUIText).material.color = Color.black

	def OnMouseExit():
		GetComponent(GUIText).material.color = Color.white