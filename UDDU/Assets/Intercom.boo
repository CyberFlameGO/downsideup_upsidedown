import UnityEngine

class Intercom (MonoBehaviour): 
	
	private idle_time as single = 0
	public wait_time as single = 30.0
	public player as Transform
	public clip as AudioClip = null

	def Start ():
		pass
	
	def Update ():
		if Mathf.Abs(player.position.x - transform.position.x) < 5*transform.localScale.x and Mathf.Abs(player.position.y - transform.position.y) < 5*transform.localScale.y:
			idle_time += Time.deltaTime
		else:
			idle_time = 0.0
			
		if idle_time > wait_time:
			idle_time = 0.0
			if clip == null:
				GameObject.Find("SoundEffects").GetComponent(SoundEffects).PlayInteridle()
			else:
				GameObject.Find("SoundEffects").GetComponent(SoundEffects).PlayIntercom(clip)
				Destroy(gameObject)

	def OnDrawGizmos():
		
		if clip == null:
			Gizmos.color = Color.green
		else:
			Gizmos.color = Color.blue
		Gizmos.DrawWireCube (transform.position, Vector3 (10*transform.localScale.x,10*transform.localScale.y,10))