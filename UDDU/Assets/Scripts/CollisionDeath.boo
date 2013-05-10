import UnityEngine

class CollisionDeath (MonoBehaviour): 
	public target as GameObject

	def OnCollisionEnter(collision as Collision):
		stunned = target.GetComponent(Attacked).isStunned()
		if collision.gameObject == target and stunned: #kill stunned player
			collision.gameObject.GetComponent(FadeScreen).reset()
