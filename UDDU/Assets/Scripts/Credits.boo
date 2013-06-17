import UnityEngine

class Credits (MonoBehaviour): 
	private creditSpeed = 0.2
	private text as GameObject

	def Start ():
		credits = "Created By:\n\n"

		credits += "Dawn Richardson\n"
		credits += "Francis Guerin\n"
		credits += "Katie Watson\n"
		credits += "Richard Hpa\n"
		credits += "Ryan Sumner\n"
		credits += "Stephen Bennett\n"
		GetComponent(GUIText).text = credits
		GetComponent(GUIText).material.color = Color.white
	
	def Update ():
		transform.Translate(Vector3.up * Time.deltaTime * creditSpeed)