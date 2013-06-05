import UnityEngine


class Crushed (MonoBehaviour): 
	public mat as Material
	public crushingObject as GameObject
	private matInstance as Material
	private fall_threshold = -0.3

	public BloodExplosion as GameObject

	def OnTriggerStay(col as Collider):
		if col.gameObject.name==crushingObject.name:
			g = gameObject
			blood = Instantiate(BloodExplosion, g.transform.position, g.transform.rotation)
			blood.layer = g.layer
			for child as Transform in blood.transform:
				child.gameObject.layer = g.layer
			blood.transform.position.y += .3
			Destroy(g) #close enough to centre of guard, so kill em

