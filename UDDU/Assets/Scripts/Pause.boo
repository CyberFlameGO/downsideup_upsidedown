import UnityEngine

class Pause (MonoBehaviour): 

	private isPaused as bool = false
	private loadLevel as bool = false
	public maxLevels as single = 5
	public MenuOptions as GameObject
	
	private menu as GameObject

	def Update ():
		if Input.GetKeyDown(KeyCode.Escape):

			if Time.timeScale!=0.0F:
				Time.timeScale=0.0F
				isPaused = true
			
			elif Time.timeScale==0.0F:
				Time.timeScale=1.0F
				isPaused = false

	def OnGUI ():
		Debug.Log("pause " + isPaused)
		isActive = false
		menu = GameObject.Find("Menu Option")
		if not menu: menu = GameObject.Find("Menu Options(Clone)")
		if isPaused and not menu:
			Instantiate(MenuOptions)
		elif menu and not isPaused:
			Destroy(menu)
			Time.timeScale=1.0F
			isPaused = false
			
	def UnPause():
		isPaused = false
				
	def GetIsPaused() as bool:
		return isPaused

		
	
