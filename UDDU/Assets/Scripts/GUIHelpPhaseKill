import UnityEngine

class GUIHelpPickup (MonoBehaviour): 
	public target as GameObject
	public position as Transform

	private text = []
	private current_text = 0
	private pickupTimer as single =0
	private dropTimer as single =0

	def Start ():
		text.Add("Try phasing inside a guard\n to destroy them!")

	def Update ():
		if target.transform.position.x > position.position.x and guiText:
			guiText.text = text[current_text]

			pickupTimer = Time.time
			if (pickupTimer > 0) and (Time.time > pickupTimer+0.3):
				Destroy(guiText)



