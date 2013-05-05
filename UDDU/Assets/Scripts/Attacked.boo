import UnityEngine


class Attacked (MonoBehaviour): 

	public dragIncrease as single = 100
	public recoveryTime as single = 5

	public fadeDuration as single = 2

	private stunnedTime as single =0
	private stunned = false
	private dead = false

	private backgroundStyle as GUIStyle = GUIStyle() 
	private texture as Texture2D
	private blackness = Color(0,0,0,1)
	private current_black = Color(0,0,0,0)
	private colourDelta as Color = Color(0,0,0,0)
	private timeFactor = 0.02

	def setDead(isDead):
		dead = isDead

	def Awake():
		texture = Texture2D(1, 1) 
		texture.SetPixel(0, 0, blackness) 
		texture.Apply() 
		backgroundStyle.normal.background=texture
		colourDelta= (blackness - current_black) / fadeDuration 


	def OnGUI():
		if dead:
			Time.timeScale=0 #pause the game

			if (current_black != blackness):
				current_black = (current_black + (colourDelta * timeFactor))
				texture.SetPixel(0, 0, current_black) 
				texture.Apply() 
			else:
				Application.LoadLevel(Application.loadedLevel) #reload level
				# dead = false
				Time.timeScale=1 #pause the game
				texture.SetPixel(0, 0, blackness) 
				texture.Apply() 
			GUI.depth = 1000
			GUI.Label(Rect(-10, -10, Screen.width + 10, Screen.height + 10), texture,backgroundStyle)

	def Update ():
		if (stunned and Time.time-stunnedTime > recoveryTime): #recover
			stunned = false
			transform.Rotate(-90, 0, 0)
			GetComponent(Player).other.rigidbody.drag = GetComponent(Player).other.rigidbody.drag-dragIncrease

	#NOTE: This currenty rotates and leaves the player hanging in midair
	# this will be animated differently later
	def stun(direction as Vector3):
		transform.Rotate(90, 0, 0)
		GetComponent(Player).other.rigidbody.drag = GetComponent(Player).other.rigidbody.drag+dragIncrease

		stunned = true
		stunnedTime = Time.time


