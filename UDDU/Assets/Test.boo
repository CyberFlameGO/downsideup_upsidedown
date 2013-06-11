import UnityEngine

class Test (MonoBehaviour): 

	def FixedUpdate () :
   		rigidbody.AddForce(Vector3.right * rigidbody.mass * 5)