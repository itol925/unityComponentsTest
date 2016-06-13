using UnityEngine;
using System.Collections;

public class Player : MonoBehaviour {
	private Animator anim;
	private AnimatorStateInfo baseLayerCurrentState;
	private AnimatorStateInfo layer2CurrentState;

	// Use this for initialization
	void Start () {
		anim = GetComponent<Animator> ();
		anim.SetLayerWeight (1, 1);
	}
	
	// Update is called once per frame
	void Update () {
		if (anim == null) {
			return;
		}
		if (anim.layerCount != 2) {
			return;
		}
		baseLayerCurrentState = anim.GetCurrentAnimatorStateInfo (0);
		layer2CurrentState = anim.GetCurrentAnimatorStateInfo (1);

		float horizontal = Input.GetAxis ("Horizontal");
		anim.SetFloat ("turnSpeed", horizontal);

		float vertical = Input.GetAxis ("Vertical");
		anim.SetFloat ("speed", vertical);

		if (Input.GetButtonUp ("Fire1")) {
			anim.SetBool ("reload", true);
		} else {
			anim.SetBool ("reload", false);
		}

		if (layer2CurrentState.nameHash != Animator.StringToHash ("Layer2.Reload") || layer2CurrentState.nameHash != Animator.StringToHash ("Layer2.WeaponSwap")) {
			if (Input.GetButtonUp ("Fire2")) {
				anim.SetBool ("swap", true);
			}
		}
		if (layer2CurrentState.nameHash == Animator.StringToHash ("Layer2.WeaponSwap")) {
			anim.SetBool ("swap", false);
		}

	}

	void OnAnimatorMove(){
		if (anim) {
			Vector3 pos = transform.position;
			pos.z += anim.GetFloat("speed") * Time.deltaTime;
			pos.x += anim.GetFloat("turnSpeed") * Time.deltaTime;
			transform.position = pos;
		}
	}
}
