import UnityEngine

class End (MonoBehaviour): 
	
	public wait_time as single = 30.0
	private end_time = 0.0
	public player as Transform
	public clip1 as AudioClip = null
	public clip2 as AudioClip = null
	private done = false

	def Start ():
		pass
	
	def Update ():
		if Mathf.Abs(player.position.x - transform.position.x) < 5*transform.localScale.x and Mathf.Abs(player.position.y - transform.position.y) < 5*transform.localScale.y:
			if done == false:
				GameObject.Find("SoundEffects").GetComponent(SoundEffects).PlayIntercom(clip1)
				GameObject.Find("SoundEffects").GetComponent(SoundEffects).PlayIntercom(clip2)
				end_time = Time.time + wait_time
				done = true
			
		if end_time != 0.0 and Time.time > end_time:
			Application.LoadLevel("Credits")

	def OnDrawGizmos():

		Gizmos.color = Color.red
		Gizmos.DrawWireCube (transform.position, Vector3 (10*transform.localScale.x,10*transform.localScale.y,10))