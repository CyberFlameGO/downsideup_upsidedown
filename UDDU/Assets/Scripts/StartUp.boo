import UnityEngine

class StartUp (MonoBehaviour): 
	public arrowTexture as GUITexture
	public pointTop as GUITexture
	public pointBot as GUITexture


	private arrowImages = ["direction_LR", "direction_UD"]

	private currentImage = 0
	private text = []
	private currentText = 0

	private horTimer as single = 0
	private verTimer as single = 0

	def Start ():
		text.Add("")
		text.Add(" ")
		text.Add("Plasma balls indicate your existence level\n in each world")
		guiText.text = text[currentText]
		arrowTexture.texture  = Resources.Load("Controls/direction_LR") as Texture2D
		pointTop.texture = Resources.Load("Controls/point_up") as Texture2D
		pointBot.texture = Resources.Load("Controls/point_down") as Texture2D

	def Update ():
		guiText.text = text[currentText]
		if arrowTexture:
			arrowTexture.texture  = Resources.Load("Controls/" + arrowImages[currentImage]) as Texture2D

		if Input.GetAxis("Horizontal") !=0 and horTimer==0:
			horTimer = Time.time
		elif (horTimer > 0) and ((Time.time > horTimer+2.0) or verTimer>0) and (Time.time > 3.0) and guiText.text!=text[1]:
			currentImage=1
			currentText=1

		if Input.GetAxis("Vertical") !=0 and horTimer > 0 and verTimer==0:
			verTimer = Time.time
		elif (Time.time > (verTimer+6.0)) and verTimer > 0:
			Destroy(pointTop)	
			Destroy(pointBot)	
			Destroy(gameObject)
		elif (Time.time > (verTimer+3.0)) and verTimer > 0 and guiText.text!=text[2]:
			currentText=2
			Destroy(arrowTexture)
			pointTop.gameObject.SetActive(true)
			pointBot.gameObject.SetActive(true)
			horTimer=-1

