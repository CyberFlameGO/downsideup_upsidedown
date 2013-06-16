import UnityEngine

class DoorController (MonoBehaviour): 

	public target as GameObject
	public OpenFromRight as bool
	public OpenFromLeft as bool
	public openDistance as single = 5.0f
	private anim as Animator
	private col as BoxCollider
	private doorState as int
	private DistanceFromTarget as single
	private doorOpen as bool
	private previousState as bool
	private inSameWorld as bool
	


	def Start ():
		anim = GetComponent[of Animator]()
		col = GetComponent[of BoxCollider]()
		doorState = Animator.StringToHash('Open')
		doorOpen = false
		previousState = false
	
	def Update ():
		previousState = doorOpen
		doorOpen = false
		
		if (LayerMask.NameToLayer("Top World") == gameObject.layer) and (LayerMask.NameToLayer("Top World") == target.layer) and (target.renderer.enabled):
			inSameWorld = true
		elif (LayerMask.NameToLayer("Bottom World") == gameObject.layer) and (LayerMask.NameToLayer("Bottom World") == target.layer) and (target.renderer.enabled):
			inSameWorld = true
		else:
			inSameWorld = false
			
		if Vector3.Distance(transform.position, target.transform.position) <= openDistance and inSameWorld:
			DistanceFromTarget = target.transform.position.x - transform.position.x
			if DistanceFromTarget <= 0 and OpenFromLeft:
				doorOpen = true
			elif DistanceFromTarget >= 0 and OpenFromRight:
				doorOpen = true
		
		if previousState != doorOpen:
			if doorOpen:
				OpenDoor()
			else:
				CloseDoor()

	def OpenDoor():
		anim.SetBool(doorState,true)
		col.center.y = 1.15
		col.size.y = 0.4
		GameObject.Find("SoundEffects").GetComponent(SoundEffects).PlayDoor(transform.position)

		
		
	def CloseDoor():
		anim.SetBool(doorState,false)
		col.center.y = 0
		col.size.y = 2.7
		GameObject.Find("SoundEffects").GetComponent(SoundEffects).PlayDoor(transform.position)

		