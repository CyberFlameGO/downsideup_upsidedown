import UnityEngine

class BackButton (MonoBehaviour): 

	def OnMouseEnter ():
		GetComponent(GUIText).material.color = Color.black

	def OnMouseExit():
		GetComponent(GUIText).material.color = Color.white

	def OnMouseDown():
		Application.LoadLevel("MainMenu")


