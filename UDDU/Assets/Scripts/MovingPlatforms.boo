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

	def Update():
		//Debug.Log("Position: " + transform.position)
		if Time.time >= (travelTime+startTime):
			startTime = Time.time
			directon = directon * -1
			switch = Time.time
			rigidbody.velocity = Vector3(0,0,0)


	def FixedUpdate():
		velocity = TravelDistance.x/travelTime
		acceleration = velocity/travelTime
		HForce = currentWeight * acceleration
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

