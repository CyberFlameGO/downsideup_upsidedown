import UnityEngine

class InGameMenuButton (MonoBehaviour): 

	private maxLevels = 5
	public controlsTextureTop as GUITexture
	public controlsTextureBot as GUITexture
	public backButton as GUIText
	public levels as GameObject

	def OnMouseDown():
		if name=="Continue":
			GameObject.Find("Pause").GetComponent(Pause).UnPause()
		if name=="Main Menu":
			paused = GameObject.Find("Pause")
			if paused:
				paused.GetComponent(Pause).UnPause()
			Application.LoadLevel("MainMenu")
		if name=="Select Level":

			numUnlocked = 1
			for i in range(maxLevels):
				if PlayerPrefs.GetInt("unlockedLevel" +i) == 1: #has unlocked this level
					numUnlocked = i

			lvls = Instantiate(levels)
			count =5
			for child as Transform in lvls.transform:
				if count>numUnlocked:
					child.gameObject.SetActive(false)
				count--
			Instantiate(backButton)

			menu = GameObject.Find("Menu Options(Clone)")
			Destroy(menu)
		if name=="Controls":
			Instantiate(controlsTextureTop)
			Instantiate(controlsTextureBot)
			Instantiate(backButton)
			menu = GameObject.Find("Menu Options(Clone)")
			Destroy(menu)
		if name=="Quit":
			Application.Quit()


	def OnMouseEnter():
		GetComponent(GUIText).material.color = Color.black

	def OnMouseExit():
		GetComponent(GUIText).material.color = Color.white