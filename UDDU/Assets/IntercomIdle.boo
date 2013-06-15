import UnityEngine

class IntercomIdle (MonoBehaviour): 
	
	private idle_time as single = 0
	public wait_time as single = 30.0
	public player as Transform

	def Start ():
		pass
	
	def Update ():
		if Mathf.Abs(player.position.x - transform.position.x) < 5*transform.localScale.x and Mathf.Abs(player.position.y - transform.position.y) < 5*transform.localScale.y:
			idle_time += Time.deltaTime
		else:
			idle_time = 0.0
			
		if idle_time > wait_time:
			idle_time = 0.0
			GameObject.Find("SoundEffects").GetComponent(SoundEffects).PlayInteridle()

	def OnDrawGizmos():
		
		Gizmos.DrawWireCube (transform.position, Vector3 (10*transform.localScale.x,10*transform.localScale.y,10))