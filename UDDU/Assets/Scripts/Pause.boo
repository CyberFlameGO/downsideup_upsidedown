import UnityEngine

class Pause (MonoBehaviour): 

	private isPaused as bool = false
	private loadLevel as bool = false
	public maxLevels as single = 5
	public MenuOptions as GameObject
	
	def Update ():
		if Input.GetKeyDown(KeyCode.Escape):

			if Time.timeScale!=0.0F:
				Time.timeScale=0.0F
				isPaused = true
			
			elif Time.timeScale==0.0F:
				Time.timeScale=1.0F
				isPaused = false

	def OnGUI ():
		isActive = false
		menu = GameObject.Find("Menu Options(Clone)")
		controls = GameObject.Find("ControlsTop(Clone)")
		levels = GameObject.Find("Levels(Clone)")

		if isPaused and not (menu or controls or levels):
			Instantiate(MenuOptions)
		elif not isPaused and (menu or levels):
			Destroy(menu)
			Time.timeScale=1.0F
			isPaused = false
			
	def UnPause():
		isPaused = false
				
	def GetIsPaused() as bool:
		return isPaused

		
	
