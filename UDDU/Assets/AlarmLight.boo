import UnityEngine

class AlarmLight (MonoBehaviour): 
	
	public min_intensity as single = 0.0
	public max_intensity as single = 3.0
	public speed as single = 5.0
	private direction = true

	def Start ():
		pass
	
	def Update ():
		if direction == true:
			light.intensity += speed*Time.deltaTime
			
			if light.intensity >= max_intensity:
				direction = false
		else:
			light.intensity -= speed*Time.deltaTime
			
			if light.intensity <= min_intensity:
				direction = true
				
		print(light.intensity)
