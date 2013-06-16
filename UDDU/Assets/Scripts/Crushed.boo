import UnityEngine


class Crushed (MonoBehaviour): 
	public mat as Material
	public crushingObject as GameObject
	private matInstance as Material
	private fall_threshold = -0.3
	private squishGuard as GameObject

	public BloodExplosion as GameObject
	
	def Start():
		squishGuard = GameObject.Find("GuardSquish")
		

	def OnTriggerStay(col as Collider):
		if col.gameObject.name==crushingObject.name:
			g = gameObject
			blood = Instantiate(BloodExplosion, g.transform.position, g.transform.rotation)
			blood.layer = g.layer
			for child as Transform in blood.transform:
				child.gameObject.layer = g.layer
			blood.transform.position.y += .3
			Destroy(g) #close enough to centre of guard, so kill em
			sqG = Instantiate(squishGuard, transform.position, transform.rotation)
			sqG.layer = g.layer
			for child as Transform in sqG.transform:
				child.gameObject.layer = g.layer

