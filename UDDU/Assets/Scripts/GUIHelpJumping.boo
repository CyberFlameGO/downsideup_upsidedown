import UnityEngine

class GUIHelpJumping (MonoBehaviour): 
	public spacebarTexture as GUITexture
	public target as GameObject
	public position as Transform
	private jumpTimer as single =0

	def Update ():
		if target.transform.position.x > position.position.x and spacebarTexture:
			startUpText = GameObject.Find("FirstInstructions")
			if not startUpText:
				guiText.material.color.a = 0.65

				spacebarTexture.texture  = Resources.Load("Controls/jump") as Texture2D

				if Input.GetButtonDown("Jump") and jumpTimer==0:
					jumpTimer = Time.time
				elif (jumpTimer > 0) and (Time.time > jumpTimer+2.0):
					Destroy(spacebarTexture)	

