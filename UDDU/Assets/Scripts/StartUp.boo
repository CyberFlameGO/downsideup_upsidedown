import UnityEngine

class StartUp (MonoBehaviour): 

	def Start ():
		guiText.text = "Use up and down arrows \nto change existence level \nin each world"


	def Update ():
		if(Time.time>10):
			Destroy(gameObject)
		elif(Time.time>5):
			guiText.text = "Check weight figure\n above and below\n for existence levels"
