import UnityEngine

class GUIHelpJumping (MonoBehaviour): 
	public spacebarTexture as GUITexture
	public target as GameObject
	public position as Transform
	private text = "Use spacebar to jump"
	private jumpTimer as single =0

	def Update ():
		if target.transform.position.x > position.position.x and guiText:
			startUpText = GameObject.Find("FirstInstructions")
			if not startUpText:
				guiText.text = text
				guiText.material.color.a = 0.65
				if spacebarTexture and Mathf.Round(Time.time)%2 !=0:
					spacebarTexture.texture  = Resources.Load("Controls/spacebar_select") as Texture2D
				elif spacebarTexture:
					spacebarTexture.texture  = Resources.Load("Controls/spacebar") as Texture2D

				if Input.GetButtonDown("Jump"):
					jumpTimer = Time.time
				elif (jumpTimer > 0) and (Time.time > jumpTimer+2.0):
					Destroy(spacebarTexture)	
					Destroy(guiText)

