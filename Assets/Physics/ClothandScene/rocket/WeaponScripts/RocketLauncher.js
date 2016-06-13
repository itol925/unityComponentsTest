var projectile : Rigidbody;
var initialSpeed = 20.0;
var reloadTime = 0.5;
var ammoCount = 20;
private var lastShot = -10.0;

function Update () {

	if (Input.GetButton ("Fire1"))

	if (Time.time > reloadTime + lastShot && ammoCount > 0) {
	
		var instantiatedProjectile : Rigidbody = Instantiate (projectile, transform.position, transform.rotation);
			
	
		instantiatedProjectile.velocity = transform.TransformDirection(Vector3 (0, 0, initialSpeed));


		Physics.IgnoreCollision(instantiatedProjectile.collider, transform.root.collider);
		
		lastShot = Time.time;
		ammoCount--;

		}

}