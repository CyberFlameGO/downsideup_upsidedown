import UnityEngine

class MovingPlatforms (MonoBehaviour): 

	public TravelDistance as Vector3 = Vector3(10,0,0)
	private pointA as Vector3 = Vector3(0,0,0)
	private pointB as Vector3 = Vector3(0,0,0)
	public travelTime = 2.0
	public startTime = 0
	private currentWeight as single
	private Direction as Vector3 
	public HForce as single = 10
	public Elasticity as single = 50
	public VForce as single = 50
	private PointRange as single = 1.0f
	private height as single
	private directon = 1
	private switch = 0
	public return_trip as bool = true

	def Start():
		pointA = transform.position
		pointB = transform.position + TravelDistance
		
		height = transform.position.y
		currentWeight = rigidbody.mass

	def Update():
		//Debug.Log("Position: " + transform.position)
		if Time.time >= (travelTime+startTime):
			if return_trip:
				tmp = pointA
				pointA = pointB
				pointB = tmp
				
				startTime = Time.time
				#directon = directon * -1
				#switch = Time.time
				rigidbody.velocity = Vector3(0,0,0)
			else:
				transform.position = pointA
				startTime = Time.time
				#rigidbody.velocity = Vector3(0,0,0)

	def FixedUpdate():

		velocity = Mathf.Abs(transform.position.x - pointB.x)/((startTime + travelTime) - Time.time)
		
		if Mathf.Abs(rigidbody.velocity.x) < velocity:
			if pointB.x-transform.position.x < 0:
				Direction.x = -HForce
			else:
				Direction.x = HForce
		else:
			Direction.x = 0
			
		Direction.y = ((height-transform.position.y)*Elasticity)+VForce	
		Direction.z = 0
		rigidbody.AddForce(Direction)
		
#		acceleration = velocity/travelTime
#		HForce = currentWeight * acceleration
#		Direction.x = directon * HForce
#		Direction.y = ((height-transform.position.y)*Elasticity)+VForce
#		Direction.z = 0
#		rigidbody.AddForce(Direction)

#	def OnCollisionEnter(col as Collision):
#		if col.transform.name == "Feet":
#			playerMass = col.transform.parent.gameObject.rigidbody.mass
#			currentWeight += playerMass
#		if col.transform.name in ["Player1", "Player2"]:
#			playerMass = col.rigidbody.mass
#			currentWeight += playerMass

#	def OnCollisionExit(col as Collision):
#
#		if col.transform.name == "Feet":
#			playerMass = col.transform.parent.gameObject.rigidbody.mass
#			currentWeight -= playerMass
#		if col.transform.name in ["Player1", "Player2"]:
#			playerMass = col.rigidbody.mass
#			currentWeight -= playerMass

	def OnDrawGizmosSelected():
		
		if pointB.x == 0:
			Gizmos.DrawWireCube (transform.position + TravelDistance, Vector3 (1,1,1))
		else:
			Gizmos.DrawWireCube (pointB, Vector3 (1,1,1))