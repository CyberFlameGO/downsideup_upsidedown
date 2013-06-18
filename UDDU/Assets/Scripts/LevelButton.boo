import UnityEngine

class LevelButton (MonoBehaviour): 

	def OnMouseEnter ():
		GetComponent(GUIText).material.color = Color.black

	def OnMouseExit():
		GetComponent(GUIText).material.color = Color.white

	def OnMouseDown():
		paused = GameObject.Find("Pause")
		if paused:
			paused.GetComponent(Pause).UnPause()
		Application.LoadLevel(name)


