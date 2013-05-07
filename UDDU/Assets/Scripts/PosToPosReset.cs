using UnityEngine;
using System.Collections;

public class PosToPosReset : MonoBehaviour {

	public Vector3 TravelDistance = new Vector3(0,10,0);
	private Vector3 pointA = new Vector3();
	private Vector3 pointB = new Vector3();
	private float rate = 0.0f;
	public float speed = 1.0f;
	
	void MoveObject (Vector3 startPos, Vector3 endPos) {
		//Debug.Log("position = " + transform.position);
	     transform.position = Vector3.Lerp(startPos, endPos, rate); 
		
		if (rate >= 1.0f) {//if it reaches the end position
			//Debug.Log("direction changed at: " + transform.position);
	    	transform.position = pointA; //reset position
			rate = 0.0f;
		}
	}
	
	
	void Start () {
	    pointA = transform.position;
		pointB = pointA + TravelDistance;
	}
	
	void Update(){
		rate += Time.deltaTime * speed;
		MoveObject(pointA, pointB);
	}
}
