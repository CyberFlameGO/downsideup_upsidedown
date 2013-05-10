import UnityEngine

class CollisionDeath (MonoBehaviour): 
	public target as GameObject

	def OnCollisionEnter(collision as Collision):
		phasing = target.GetComponent(Player).isPhasing()

		if phasing and collision.gameObject == target: #if phasing into guard, kills guard
			Destroy(gameObject)
		elif collision.gameObject == target: #otherwise kill player
			collision.gameObject.GetComponent(FadeScreen).reset()
