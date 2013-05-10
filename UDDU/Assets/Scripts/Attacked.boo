import UnityEngine


class Attacked (MonoBehaviour): 

	public dragIncrease as single = 100
	public recoveryTime as single = 5

	private stunnedTime as single =0
	private stunned = false

				
	def Update ():
		if (stunned and Time.time-stunnedTime > recoveryTime): #recover
			stunned = false
			transform.Rotate(-90, 0, 0)
			GetComponent(Player).other.rigidbody.drag = GetComponent(Player).other.rigidbody.drag-dragIncrease

	#NOTE: This currenty rotates and leaves the player hanging in midair
	# this will be animated differently later
	def stun(direction as Vector3):
		transform.Rotate(90, 0, 0)
		GetComponent(Player).other.rigidbody.drag = GetComponent(Player).other.rigidbody.drag+dragIncrease

		stunned = true
		stunnedTime = Time.time


