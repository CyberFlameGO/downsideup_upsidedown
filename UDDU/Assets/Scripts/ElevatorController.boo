import UnityEngine

class ElevatorController (MonoBehaviour): 

	public target as GameObject
	public openDistance as single = 5.0f
	private anim as Animator
	private col as BoxCollider
	private elevatorState as int
	private DistanceFromTarget as single
	private elevatorOpen as bool
	private previousState as bool
	private inSameWorld as bool
	


	def Start ():
		anim = GetComponent[of Animator]()
		col = GetComponent[of BoxCollider]()
		elevatorState = Animator.StringToHash('Open')
		elevatorOpen = false
		previousState = false
	
	def Update ():
		previousState = elevatorOpen
		elevatorOpen = false
		DistanceFromTarget = transform.position.x - target.transform.position.x
		
		if (LayerMask.NameToLayer("Top World") == gameObject.layer) and (LayerMask.NameToLayer("Top World") == target.layer) and (target.renderer.enabled):
			inSameWorld = true
		elif (LayerMask.NameToLayer("Bottom World") == gameObject.layer) and (LayerMask.NameToLayer("Bottom World") == target.layer) and (target.renderer.enabled):
			inSameWorld = true
		else:
			inSameWorld = false
			
		if (DistanceFromTarget <= openDistance) and (DistanceFromTarget >= 0) and inSameWorld:
			elevatorOpen = true
		
		if previousState != elevatorOpen:
			if elevatorOpen:
				OpenElevator()
			else:
				CloseElevator()

	def OpenElevator():
		anim.SetBool(elevatorState,true)
		col.center.z = 10

		
		
	def CloseElevator():
		anim.SetBool(elevatorState,false)
		col.center.z = 1

