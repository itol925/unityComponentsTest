using UnityEngine;
using System.Collections;

public class DestroyBullit : MonoBehaviour {
	
	public float lifeTime = 2.0f;

	void Start () {
		Destroy(gameObject, lifeTime);
	
	}
	
}
