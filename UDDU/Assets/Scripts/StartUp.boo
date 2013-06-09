import UnityEngine

class StartUp (MonoBehaviour): 
	public arrowTexture as GUITexture
	public wasdTexture as GUITexture
	private arrowImages = ["arrows", "arrows_leftright", "arrows_updown"]
	private wasdImages = ["wasd", "wasd_leftright", "wasd_updown"]

	private currentImage = 1
	private text = []
	private currentText = 0

	private horTimer as single = 0
	private verTimer as single = 0

	def Start ():
		text.Add("Use left and right arrows to move")
		text.Add("Use up and down arrows \nto change existence level \nin each world")
		text.Add("Check weight figure\n above and below\n for existence levels")
		guiText.text = text[currentText]
		arrowTexture.texture = Resources.Load("Controls/"+arrowImages[currentImage]) as Texture2D
		wasdTexture.texture = Resources.Load("Controls/"+wasdImages[currentImage]) as Texture2D

	def Update ():
		guiText.text = text[currentText]
		guiText.material.color.a = 0.65
		if arrowTexture and Mathf.Round(Time.time)%2 !=0:
			arrowTexture.texture  = Resources.Load("Controls/"+arrowImages[currentImage]) as Texture2D
			wasdTexture.texture  = Resources.Load("Controls/"+wasdImages[currentImage]) as Texture2D

		elif arrowTexture:
			arrowTexture.texture  = Resources.Load("Controls/"+arrowImages[0]) as Texture2D
			wasdTexture.texture  = Resources.Load("Controls/"+wasdImages[0]) as Texture2D

		if Input.GetAxis("Horizontal") !=0 and horTimer==0:
			horTimer = Time.time
		elif (horTimer > 0) and ((Time.time > horTimer+2.0) or verTimer>0) and (Time.time > 3.0) and guiText.text!=text[1]:
			currentImage=2
			currentText=1

		if Input.GetAxis("Vertical") !=0 and horTimer > 0 and verTimer==0:
			verTimer = Time.time
		elif (Time.time > (verTimer+6.0)) and verTimer > 0:
			Destroy(gameObject)
		elif (Time.time > (verTimer+2.0)) and verTimer > 0 and guiText.text!=text[2]:
			currentText=2
			Destroy(arrowTexture)
			Destroy(wasdTexture)			
			horTimer=-1

