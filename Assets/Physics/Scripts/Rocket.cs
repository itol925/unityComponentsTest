using UnityEngine;
using System.Collections;

public class Rocket : MonoBehaviour {

	// Use this for initialization
	void Start () {
	}
	
	// Update is called once per frame
	void Update () {
		GetComponent<Rigidbody> ().AddRelativeForce (new Vector3 (0, 60 / transform.position.y, 0));
	}
}
