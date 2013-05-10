import UnityEngine

class FadeScreen (MonoBehaviour): 

	public fadeDuration as single = 2

	private backgroundStyle as GUIStyle = GUIStyle() 
	private texture as Texture2D
	private blackness = Color(0,0,0,1)
	private currentBlack = Color(0,0,0,0)
	private colourDelta as Color = Color(0,0,0,0)
	private timeFactor = 0.02

	private resetLevel = false
	private startNew = false
	private newLevelName = ""

	def Awake():
		texture = Texture2D(1, 1) 
		texture.SetPixel(0, 0, blackness) 
		texture.Apply() 
		backgroundStyle.normal.background=texture
		colourDelta= (blackness - currentBlack) / fadeDuration 

	def reset():
		resetLevel = true

	def startLevel(levelName):
		startNew = true
		newLevelName = levelName

	def OnGUI():
		if resetLevel or startNew:
			Time.timeScale=0 #pause the game

			if (currentBlack != blackness): #moar fading
				currentBlack = (currentBlack + (colourDelta * timeFactor))
				texture.SetPixel(0, 0, currentBlack) 
				texture.Apply() 
				GUI.depth = 1000
				GUI.Label(Rect(-10, -10, Screen.width + 10, Screen.height + 10), texture,backgroundStyle)
			else:
				texture.SetPixel(0, 0, blackness) 
				texture.Apply()
				GUI.depth = 1000
				GUI.Label(Rect(-10, -10, Screen.width + 10, Screen.height + 10), texture,backgroundStyle)
				if resetLevel: Application.LoadLevel(Application.loadedLevel)
				else: Application.LoadLevel(newLevelName)
				Time.timeScale=1 #un-pause the game


