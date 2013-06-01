import UnityEngine

class MovingPlatforms (MonoBehaviour): 

	public TravelDistance as Vector3 = Vector3(10,0,0)
	private pointA as Vector3 
	private pointB as Vector3 
	private Direction as Vector3 
	public HForce as single = 10
	public Elasticity as single = 50
	public VForce as single = 50
	private PointRange as single = 1.0f
	private height as single

	def Start():
		height = transform.position.y
		
		pointA = transform.position
		pointB.x = pointA.x + TravelDistance.x
		pointB.y = pointA.y + TravelDistance.y
		pointB.z = pointA.z + TravelDistance.z

	def Update():
		//Debug.Log("Position: " + transform.position)
		//Debug.Log("Distance: " + Vector3.Distance(transform.position, pointB))
		if Vector3.Distance(transform.position, pointB) < PointRange:
			//Debug.Log("point reached!")
			tempVector as Vector3 = pointA
			pointA = pointB
			pointB = tempVector
			rigidbody.velocity = Vector3(0,0,0)
			//Debug.Log("pointA = " + pointA)
			//Debug.Log("pointB = " + pointB)
		
	def FixedUpdate():
		Direction.x = FindDirection(transform.position.x , pointB.x) * HForce
		Direction.y = ((height-transform.position.y)*Elasticity)+VForce
		Direction.z = 0
		rigidbody.AddForce(Direction)
		

	def FindDirection(pos1 as single, pos2 as single) as single:
		finalPos = pos2 - pos1
		if finalPos < 0:
			return -1
		if finalPos > 0:
			return 1
		if finalPos == 0:
			return 0

#	def OnTriggerEnter(other as Collider):
#		if other.gameObject.tag == "Player":
#			//Debug.Log("Player Entered")
#			other.gameObject.transform.parent = transform
#			
# 			
#	def OnTriggerExit(other as Collider):
#		if other.gameObject.tag == "Player":
#			//Debug.Log("Player Exited")
#			other.gameObject.transform.parent = null