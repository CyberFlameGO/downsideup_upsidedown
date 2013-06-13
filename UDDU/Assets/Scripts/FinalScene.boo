import UnityEngine

class FinalScene (MonoBehaviour): 

	private anim as Animator
	private walkingState as int
	private idleState as int
	public BloodExplosion as GameObject

	private isDead = false
	private creditSpeed = 0.2
	private text as GameObject

	def Start ():
		walkingState = Animator.StringToHash('Walk')
		idleState = Animator.StringToHash('Idle')

		anim = GetComponent[of Animator]()

		text = GameObject.Find("Credits")
		credits = "Created By:\n\n"

		credits += "Dawn Richardson\n"
		credits += "Francis\n"
		credits += "Katie\n"
		credits += "Richard\n"
		credits += "Ryan Sumner\n"
		credits += "Stephen Bennet\n"
		text.GetComponent(GUIText).text = credits
		text.GetComponent(GUIText).material.color = Color.black
	
	def Update ():
		if transform.position.x > GameObject.Find("DeathSpot").transform.position.x and not isDead:
			blood = Instantiate(BloodExplosion, transform.position, transform.rotation)
			blood.transform.position.y += .3
			# Destroy(gameObject)
			transform.Rotate(-90,0,0)
			isDead = true
			Destroy (anim)
		elif not isDead:
			rigidbody.velocity.x = 5
			anim.SetBool(walkingState, true)

		if isDead:
			text.transform.Translate(Vector3.up * Time.deltaTime * creditSpeed)


