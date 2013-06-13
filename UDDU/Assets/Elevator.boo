import UnityEngine

class Elevator (MonoBehaviour): 
	private force = 0
	def Update():
		rigidbody.AddForce(Vector3(0,force,0))
	def sendUp():
		Debug.Log("forcing")
		force = 100
