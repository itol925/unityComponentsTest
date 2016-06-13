using UnityEngine;
using System.Collections;

public class car : MonoBehaviour {
	public WheelCollider BL, BR, FL, FR;
	
	// Update is called once per frame
	void Update () {

		if (Input.GetAxis ("Vertical") > 0) {
			BL.motorTorque = 10;
			BR.motorTorque = 10;
		} else if (Input.GetAxis ("Vertical") < 0) {
			BL.motorTorque = -10;
			BR.motorTorque = -10;
		} else {
			BL.motorTorque = 0;
			BR.motorTorque = 0;
		}

		if (Input.GetAxis ("Horizontal") > 0) {
			FL.steerAngle = 30;
			FR.steerAngle = 30;
		} else if (Input.GetAxis ("Horizontal") < 0) {
			FL.steerAngle = -30;
			FR.steerAngle = -30;
		} else {
			FL.steerAngle = 0;
			FR.steerAngle = 0;
		}
	
	}
}
