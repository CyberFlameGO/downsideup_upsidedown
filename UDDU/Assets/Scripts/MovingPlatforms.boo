import UnityEngine

class MovingPlatforms (MonoBehaviour): 

	public TravelDistance as Vector3 = Vector3(10,0,0)
	private pointA as Vector3 
	private pointB as Vector3 
	private Direction as Vector3 
	public PlatformForce as single = 100
	private PointRange as single = 4.0f

	def Start(): 
	    pointA = transform.position
	    //Debug.Log("Starting pointA = " + pointA)
	    pointB.x = pointA.x + TravelDistance.x
	    pointB.y = pointA.y + TravelDistance.y
	    pointB.z = pointA.z + TravelDistance.z
	    //Debug.Log("Starting pointB = " + pointB)

	def Update():
		//Debug.Log("Position: " + transform.position)
		//Debug.Log("Distance: " + Vector3.Distance(transform.position, pointB))
		if Vector3.Distance(transform.position, pointB) < PointRange:
			//Debug.Log("point reached!")
			tempVector as Vector3 = pointA
			pointA = pointB
			pointB = tempVector
			//Debug.Log("pointA = " + pointA)
			//Debug.Log("pointB = " + pointB)
		
		//Debug.Log("Position: " + transform.position)
		MoveObject(pointB)
		
	def MoveObject(endPos as Vector3):
		Direction.x = FindDirection(transform.position.x , endPos.x)
		Direction.y = 0
		Direction.z = 0
		rigidbody.AddForce(Direction * PlatformForce)

	def FindDirection(pos1 as single, pos2 as single) as single:
		finalPos = pos2 - pos1
		if finalPos < 0:
			return -1
		if finalPos > 0:
			return 1
		if finalPos == 0:
			return 0
