import UnityEngine

class StartUp (MonoBehaviour): 
	public texture as GUITexture

	private images = ["arrows", "arrows_leftright", "arrows_updown"]
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
		current_texture = Resources.Load("Controls/"+images[currentImage]) as Texture2D
		texture.texture = current_texture

	def Update ():
		guiText.text = text[currentText]
		if texture and Mathf.Round(Time.time)%2 !=0:
			texture.texture  = Resources.Load("Controls/"+images[currentImage]) as Texture2D
		elif texture:
			texture.texture  = Resources.Load("Controls/"+images[0]) as Texture2D

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
			Destroy(texture)
			horTimer=-1

