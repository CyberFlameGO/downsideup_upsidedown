import UnityEngine

class Credits (MonoBehaviour): 
	private creditSpeed = 0.2
	private text as GameObject
	public stopAt as single = 0.6

	def Start ():
		gt = GetComponent(GUIText)
		if gt:
			credits = "Developed By:\n\n"

			credits += "Dawn Richardson\n"
			credits += "Ryan Sumner\n"
			credits += "Stephen Bennett\n\n\n"

			credits += "Designed By:\n\n"
			credits += "Francis Guerin\n"
			credits += "Katie Watson\n"
			credits += "Richard Hpa\n\n\n"

			credits += "Music By:\n\n"
			credits += "Michael Rowlands\n"

			GetComponent(GUIText).text = credits
			GetComponent(GUIText).material.color = Color.white
	
	def Update ():
		if (transform.position.y < stopAt):
			transform.Translate(Vector3.up * Time.deltaTime * creditSpeed)
			
		if Input.GetKeyDown(KeyCode.Escape):
			Application.LoadLevel("MainMenu")