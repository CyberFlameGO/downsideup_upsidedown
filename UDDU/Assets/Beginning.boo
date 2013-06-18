import UnityEngine

class Beginning (MonoBehaviour): 
	
	private start_movie as MovieTexture
	private start as single

	def Start ():
		start_movie = Resources.Load("start_movie")
		start = Time.time + start_movie.duration
		start_movie.Play()
	
	def Update ():
		if Time.time > start:
			Application.LoadLevel("Level1")
	
	def OnGUI():

		GUI.DrawTexture(Rect(0, 0, Screen.width, Screen.height), start_movie)