import UnityEngine


class Crushed (MonoBehaviour): 
	public mat as Material
	public crushingObject as GameObject
	private matInstance as Material
	private fall_threshold = -0.3

	def OnTriggerStay(col as Collider):
		if col.gameObject.name==crushingObject.name:
			if transform.localScale.y < 0.1: #when flat enough
				matInstance = Instantiate(mat)
				renderer.material = matInstance # BLOOD!
				for  child  as Transform in gameObject.transform:
					Destroy(child.gameObject)
			else:
				if GetComponent(Shoot):
					GetComponent(Shoot).enabled = false
				rigidbody.velocity = Vector3.zero
				transform.localScale += Vector3(transform.localScale.y*1.5, -transform.localScale.y/1.5, transform.localScale.y*1.5)
