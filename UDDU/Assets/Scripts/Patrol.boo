import UnityEngine

class Patrol (MonoBehaviour): 
    public speed as single =4F
    private rayLength as single =2F
    private direction as single = 1
    private target as GameObject
    def Awake():
        target = GetComponent(CollisionDeath).target


    def Update ():
        hit as RaycastHit
        rayDir as Vector3 = direction*Vector3.right
        layerMask = 1 << gameObject.layer #filter ray to objects level only
        hitSomething = Physics.Raycast (transform.position, rayDir, hit, rayLength,layerMask)

        if hitSomething and hit.rigidbody!=target.rigidbody: 
            # if hit something other than player, change directions
            direction = direction*-1
            transform.Rotate(0, 180*direction, 0)

        #move
        rigidbody.velocity.x = speed * direction


