import UnityEngine


class Attacked (MonoBehaviour): 

	public dragIncrease as single = 100
	public recoveryTime as single = 5

	private stunnedTime as single =0
	private stunned = false
	private attacker as GameObject

	def isStunned():
		return stunned

	def Update ():
		if (stunned and Time.time-stunnedTime > recoveryTime): #recover
			stunned = false
			transform.Rotate(-90, 0, 0)
			if (attacker!=null): #if havn't killed them
				attacker.GetComponent(Shoot).setHit(false)

	#NOTE: This currenty rotates and leaves the player hanging in midair
	# this will be animated differently later
	def stun(direction as Vector3, guard as GameObject):
		transform.Rotate(90, 0, 0)
		stunned = true
		stunnedTime = Time.time
		attacker = guard


