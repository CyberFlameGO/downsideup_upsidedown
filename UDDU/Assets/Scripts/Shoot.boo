import UnityEngine

class Shoot (MonoBehaviour): 
	# public bullet as GameObject
	# public bulletSpeed as single  = 1000F
	public shootDistance as single = 5
	public lazer as GameObject
	public speed as single = -2.0

	private target as GameObject

	#state variables
	private SHOOTER as single = 0 #shooting lazers state
	private COLLECTER as single = 1 #trying to catch player state
	private phaseState = SHOOTER

	private shootTime as single =0
	private shootDir as Vector3 = Vector3(-1,0,0)

	def Awake():
        target = GetComponent(CollisionDeath).target

	def Update ():
		if (phaseState==SHOOTER and Time.time-shootTime > 0.1): 
			lazer.SetActive(false)
		if (phaseState==SHOOTER and Time.time-shootTime > 3): #shoot every 3 secs
			# --stun gun --
			pos as Vector3 = Vector3(transform.position.x,transform.position.y+0.5,transform.position.z)
			layerMask = 1 << gameObject.layer #filter ray to objects level only
			hitinfo as RaycastHit
			hit = Physics.Raycast (pos, shootDir, hitinfo, shootDistance, layerMask)

			#display gun's beam on screen (TODO: Designers can make this prettier...)
			lazer.SetActive(true)
			lazer.transform.position = transform.position
			lazer.GetComponent(LineRenderer).SetPosition(0, lazer.transform.position)
			lazerEndXPos = lazer.transform.position.x - shootDistance
			if hit and hitinfo.transform.position.x > lazerEndXPos:
				lazerEndXPos = hitinfo.transform.position.x
			lazerEndPos = Vector3(lazerEndXPos, lazer.transform.position.y,lazer.transform.position.z)
			lazer.GetComponent(LineRenderer).SetPosition(1, lazerEndPos);

			shootTime = Time.time
			if hit and hitinfo.transform.name == target.name: #hit player, so stun them and switch to collector mode
				target.GetComponent(Attacked).stun(shootDir)
				phaseState = COLLECTER
				rigidbody.isKinematic = false
		elif (phaseState==COLLECTER and Time.time-shootTime > 0.1): #move towards hit
			lazer.SetActive(false)

			if(Vector3.Distance( transform.position, target.transform.position)<shootDistance): 
				#close enough to "see", so try to collect
				rigidbody.velocity.x = speed 
			else:
				phaseState=SHOOTER
				rigidbody.isKinematic = true

			#-- bullets --
			# pos as Vector3 = Vector3(transform.position.x,transform.position.y+0.5,transform.position.z)
			# bullet as GameObject = Instantiate(bullet, pos, transform.rotation)
			# bullet.layer = gameObject.layer
			# Physics.IgnoreCollision(bullet.collider, collider)

	  #   	# Add force to the cloned object in the object's forward direction
			# bullet.rigidbody.AddForce(shootDir * bulletSpeed)
			# shootTime = Time.time
