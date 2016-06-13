using UnityEngine;
using System.Collections;

public class Hero : MonoBehaviour {
	private NavMeshAgent agent;  
	public Transform Destination;
	void Start(){ 
		agent = GetComponent<NavMeshAgent>();  
	}  

	void Update(){ 
		if (Input.GetMouseButtonDown(0)){
			//摄像机到点击位置的的射线  
			Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);  
			RaycastHit hit;  
			if (Physics.Raycast(ray, out hit)){  
				if (!hit.collider.name.Equals("surface")){  
					return;  
				}
				//点击位置坐标  
				Vector3 point = hit.point;
				Destination.position = new Vector3(point.x, 1, point.z);
				//转向  
				transform.LookAt(new Vector3(point.x, transform.position.y, point.z));  
				//设置寻路的目标点  
				agent.SetDestination(point);  
			}  
		}
	}  
}
