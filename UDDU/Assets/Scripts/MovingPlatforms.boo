import UnityEngine

class MovingPlatforms (MonoBehaviour): 

	public TravelDistance as Vector3 = Vector3(10,0,0)
	private pointA as Vector3 
	private pointB as Vector3 
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

	def Start():
		height = transform.position.y
		currentWeight = rigidbody.mass
		
		pointA = transform.position
		pointB.x = pointA.x + TravelDistance.x
		pointB.y = pointA.y + TravelDistance.y
		pointB.z = pointA.z + TravelDistance.z


	def Update():
		//Debug.Log("Position: " + transform.position)
		# Debug.Log("Distance: " + Vector3.Distance(transform.position, pointB))
		# if Mathf.Abs(transform.position.x - pointB.x) < PointRange or (Mathf.Abs(rigidbody.velocity.x) < 0.01 and Time.time > switch + 1.0):
		if Time.time >= (travelTime+startTime):
			startTime = Time.time
			directon = directon * -1
			switch = Time.time
			tempVector as Vector3 = pointA
			pointA = pointB
			pointB = tempVector
		
			# velocity = Mathf.Abs(pointA.x-pointB.x)/travelTime
			# acceleration = velocity/travelTime
			# rigidbody.AddForce(Vector3(acceleration,0,0))
			rigidbody.velocity = Vector3(0,0,0)
			//Debug.Log("pointA = " + pointA)
			//Debug.Log("pointB = " + pointB)

	def FixedUpdate():
		velocity = TravelDistance.x/travelTime
		if name=="PlatformX": Debug.Log("dis " +TravelDistance.x)

		acceleration = velocity/travelTime
		if name=="PlatformX": Debug.Log("acc " + acceleration)

		HForce = currentWeight * acceleration
		if name=="PlatformX": Debug.Log("force " + HForce + "( " + currentWeight+")")
		velocity = Mathf.Abs(pointA.x-pointB.x)/travelTime
		acceleration = velocity/travelTime
		Direction.x = directon * HForce
		Direction.y = ((height-transform.position.y)*Elasticity)+VForce
		Direction.z = 0
		rigidbody.AddForce(Direction)



	def OnCollisionEnter(col as Collision):
		if col.transform.name == "Feet":
			playerMass = col.transform.parent.gameObject.rigidbody.mass
			currentWeight += playerMass
		if col.transform.name in ["Player1", "Player2"]:
			playerMass = col.rigidbody.mass
			currentWeight += playerMass

	def OnCollisionExit(col as Collision):

		if col.transform.name == "Feet":

			playerMass = col.transform.parent.gameObject.rigidbody.mass
			currentWeight -= playerMass
		if col.transform.name in ["Player1", "Player2"]:

			playerMass = col.rigidbody.mass
			currentWeight -= playerMass

