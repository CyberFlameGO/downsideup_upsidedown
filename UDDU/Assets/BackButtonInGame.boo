import UnityEngine

class BackButtonInGame (MonoBehaviour): 

	public MenuOptions as GameObject
	
	def OnMouseEnter ():
		GetComponent(GUIText).material.color = Color.black

	def OnMouseExit():
		GetComponent(GUIText).material.color = Color.white

	def OnMouseDown():
		conTop = GameObject.Find("ControlsTop(Clone)")
		conBot = GameObject.Find("ControlsBot(Clone)")
		if not conTop:
			levels = GameObject.Find("Levels(Clone)")
			Destroy(levels)
		else:
			Destroy(conTop)
			Destroy(conBot)
		menu = Instantiate(MenuOptions)
		Destroy(gameObject)