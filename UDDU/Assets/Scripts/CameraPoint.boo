import UnityEngine

class CameraPoint (MonoBehaviour): 
	
	public cameraTop as Transform
	public cameraBot as Transform
	public player as Transform
	
	public distance as single
	public player_pull as single

	def Start ():
		cameraTop.rotation.eulerAngles.x = 5
		cameraBot.rotation.eulerAngles.x = 5
	
	def Update ():
		
		speed = (Mathf.Abs(player.gameObject.rigidbody.velocity.x) + Mathf.Abs(player.gameObject.rigidbody.velocity.y))/100
		
		if Mathf.Abs(player.position.x - transform.position.x) < 5*transform.localScale.x and Mathf.Abs(player.position.y - transform.position.y) < 5*transform.localScale.y:
			cameraTop.position.x -= (cameraTop.position.x - ((transform.position.x*(1-player_pull)) + (player.position.x*player_pull))) * Time.deltaTime
			cameraTop.position.y -= (cameraTop.position.y - ((transform.position.y*(1-player_pull)) + ((player.position.y+3)*player_pull))) * Time.deltaTime
			cameraTop.position.z -= (cameraTop.position.z - -distance - -distance*speed) * Time.deltaTime
			
			cameraBot.position.x -= (cameraBot.position.x - ((transform.position.x*(1-player_pull)) + (player.position.x*player_pull))) * Time.deltaTime
			cameraBot.position.y -= (cameraBot.position.y - ((transform.position.y*(1-player_pull)) + ((player.position.y+3)*player_pull))) * Time.deltaTime
			cameraBot.position.z -= (cameraBot.position.z - distance - distance*speed) * Time.deltaTime
			
	def OnDrawGizmos():
		
		Gizmos.color = Color.white
		Gizmos.DrawWireCube (transform.position, Vector3 (10*transform.localScale.x,10*transform.localScale.y,10))
