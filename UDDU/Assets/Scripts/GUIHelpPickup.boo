import UnityEngine

class GUIHelpPickup (MonoBehaviour): 
	public xTexture as GUITexture
	public target as GameObject
	public position as Transform

	private text = []
	private current_text = 0
	private pickupTimer as single =0
	private dropTimer as single =0

	def Start ():
		text.Add("")
		text.Add("Press 'X' again to drop")

	def Update ():
		if target.transform.position.x > position.position.x and guiText:
			guiText.text = text[current_text]
			
			if xTexture:
				xTexture.texture  = Resources.Load("Controls/pickup") as Texture2D

			if Input.GetButtonDown('Pickup1') and pickupTimer==0:
				pickupTimer = Time.time
			elif (pickupTimer > 0) and (Time.time > pickupTimer+0.8) and dropTimer==0:
				current_text=1
				Destroy(xTexture)


			if Input.GetButtonDown('Pickup1') and dropTimer==0 and guiText.text == text[1]:
				dropTimer = Time.time
			elif (dropTimer > 0) and (Time.time > dropTimer+0.8):
				Destroy(guiText)


