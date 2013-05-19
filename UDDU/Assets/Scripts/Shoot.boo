import UnityEngine

class Shoot (MonoBehaviour): 
	# public bullet as GameObject
	# public bulletSpeed as single  = 1000F
	public followDistance as single = 10
	public shootDistance as single = 5
	public lazer as GameObject
	public speed as single = 2.0

	private target as GameObject

	#state variables
	private SHOOTER as bool =false
	private SEEKING as bool =false 
	private PATROL as bool =true 
	private HIT as bool =false 

	private shootTime as single =0
	private shootDir as Vector3 = Vector3(-1,0,0)
	private direction as single = -1

	def setHit(isHit as bool):
		HIT = isHit

	def Start ():
        target = GetComponent(CollisionDeath).target

	def Update ():
		inSameWorld = (target.GetComponent(Player).GetPhase() > -1 )

		if HIT:
			if (inSameWorld):
				SHOOTER=false
				SEEKING=true
			else:
				#hit and phased out
				SHOOTER=false
				SEEKING=false
				PATROL=true
		elif inSameWorld and (Vector3.Distance(target.transform.position, transform.position) <=shootDistance):
			SHOOTER=true #close enough to shoot
			SEEKING=true 
			HIT = false

		elif inSameWorld and (Vector3.Distance(target.transform.position, transform.position) <=followDistance):
			SEEKING=true #close enough to seek him
			HIT = false
		else:
			SHOOTER=false
			SEEKING=false
			PATROL=true
			HIT = false
		if (SEEKING):
			if direction > 0 and (target.transform.position.x < transform.position.x):
				direction = direction*-1
				transform.Rotate(0, 180*direction, 0)
			elif direction < 0 and (target.transform.position.x > transform.position.x):
				direction = direction*-1
				transform.Rotate(0, 180*direction, 0)


		if (SHOOTER and Time.time-shootTime > 0.1): 
			lazer.SetActive(false)
		if (SHOOTER and Time.time-shootTime > 3): #shoot every 3 secs
			# --stun gun --
			pos as Vector3 = Vector3(transform.position.x,transform.position.y+0.5,transform.position.z)
			shootDir = Vector3(direction,0,0)
			layerMask = 1 << gameObject.layer #filter ray to objects level only
			hitinfo as RaycastHit
			hitPlayer = Physics.Raycast (pos, shootDir, hitinfo, shootDistance, layerMask)

			#display gun's beam on screen (TODO: Designers can make this prettier...)
			lazer.SetActive(true)
			lazer.transform.position = transform.position
			lazer.GetComponent(LineRenderer).SetPosition(0, lazer.transform.position)
			if direction < 0: lazerEndXPos = lazer.transform.position.x - shootDistance
			else: lazerEndXPos = lazer.transform.position.x + shootDistance

			if hitPlayer and hitinfo.transform.position.x > lazerEndXPos:
				lazerEndXPos = hitinfo.transform.position.x
			lazerEndPos = Vector3(lazerEndXPos, lazer.transform.position.y,lazer.transform.position.z)
			lazer.GetComponent(LineRenderer).SetPosition(1, lazerEndPos);

			shootTime = Time.time
			if hitPlayer and hitinfo.transform.name == target.name: #hit player, so stun them
				target.GetComponent(Attacked).stun(shootDir, gameObject)
				HIT = true
		elif (SEEKING and Time.time-shootTime > 0.1): #move towards player
			lazer.SetActive(false)
			if(Vector3.Distance( transform.position, target.transform.position)<followDistance): 
				#close enough to "see", so try to collect
				rigidbody.velocity.x = speed * direction
			else:
				phaseState=SHOOTER
		else: #must be patrolling
			rayDir as Vector3 = direction*Vector3.right
			hitObjectHigh as RaycastHit
			hitObjectLow as RaycastHit
			layerMask = 1 << gameObject.layer #filter ray to objects level only
			highPos = Vector3(transform.position.x,transform.position.y+0.8,transform.position.z)
			lowPos = Vector3(transform.position.x,transform.position.y-0.5,transform.position.z)

			hitSomething = Physics.Raycast (highPos, rayDir, hitObjectHigh, shootDistance/3,layerMask)
			hitSomethingLow = Physics.Raycast (lowPos, rayDir, hitObjectLow, shootDistance/3, layerMask)
			# if hit something high other than player, change directions
			if hitSomething and hitObjectHigh.rigidbody!=target.rigidbody: 
				direction = direction*-1
				transform.Rotate(0, 180*direction, 0)
			# if hit low object, jump
			elif hitSomethingLow: 
				rigidbody.velocity.y = 6.0


			#move
			rigidbody.velocity.x = speed * direction


			#-- bullets --
			# pos as Vector3 = Vector3(transform.position.x,transform.position.y+0.5,transform.position.z)
			# bullet as GameObject = Instantiate(bullet, pos, transform.rotation)
			# bullet.layer = gameObject.layer
			# Physics.IgnoreCollision(bullet.collider, collider)

	  #   	# Add force to the cloned object in the object's forward direction
			# bullet.rigidbody.AddForce(shootDir * bulletSpeed)
			# shootTime = Time.time
