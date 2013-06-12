import UnityEngine

class Sway (MonoBehaviour): 
	public horForce as single = 300
	
	def OnCollisionEnter(col as Collision):
		if (col.transform.tag == "Player"):
			rigidbody.AddForce(Vector3(horForce,0,0))
