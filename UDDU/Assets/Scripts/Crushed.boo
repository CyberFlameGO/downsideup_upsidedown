import UnityEngine


class Crushed (MonoBehaviour): 
	public mat as Material
	private matInstance as Material
	private fall_threshold = -0.3

	def OnCollisionEnter(collision as Collision):
		if collision.gameObject.name=="RustyPipe":
			if transform.localScale.y < 0.1: #when flat enough
				matInstance = Instantiate(mat)
				renderer.material = matInstance # BLOOD!
				# Destroy(gameObject)
			else:
				transform.localScale += Vector3(transform.localScale.y*1.5, -transform.localScale.y/1.5, transform.localScale.y*1.5)
