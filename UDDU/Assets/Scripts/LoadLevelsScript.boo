import UnityEngine

class LoadLevelsScript (MonoBehaviour): 
	public maxLevels as single = 5

	def Start ():
		PlayerPrefs.SetInt("unlockedLevel1", 1) # ensures level one is always unlocked
		for i in range(maxLevels):
			level = GameObject.Find("Level"+(i+1))
			if PlayerPrefs.GetInt("unlockedLevel" +(i+1)) == 1: #has unlocked this level
				level.active = true
			else:
				level.active = false