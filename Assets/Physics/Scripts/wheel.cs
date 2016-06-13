using UnityEngine;
using System.Collections;

public class wheel : MonoBehaviour {
	
	public WheelCollider CorrespondingCollider;
	//GameObject SlipPrefab;
	private float RotationValue = 0.0f;

	void Update () {
		//RaycastHit hit;
		//Vector3 ColliderCenterPoint = CorrespondingCollider.transform.TransformPoint( CorrespondingCollider.center );

		//if ( Physics.Raycast( ColliderCenterPoint, -CorrespondingCollider.transform.up, hit, CorrespondingCollider.suspensionDistance + CorrespondingCollider.radius ) ) {
		//	transform.position = hit.point + (CorrespondingCollider.transform.up * CorrespondingCollider.radius);
		//}else{
		//	transform.position = ColliderCenterPoint - (CorrespondingCollider.transform.up * CorrespondingCollider.suspensionDistance);
		//}

		transform.rotation = CorrespondingCollider.transform.rotation * Quaternion.Euler( RotationValue, CorrespondingCollider.steerAngle, 0 );
		RotationValue += CorrespondingCollider.rpm * ( 360/60 ) * Time.deltaTime;

		//WheelHit CorrespondingGroundHit;
		//CorrespondingCollider.GetGroundHit( CorrespondingGroundHit );

		//if ( Mathf.Abs( CorrespondingGroundHit.sidewaysSlip ) > 2.0 ) {
		//	if ( SlipPrefab ) {
		//		Instantiate( SlipPrefab, CorrespondingGroundHit.point, Quaternion.identity );
		//	}
		//}
	}

}
