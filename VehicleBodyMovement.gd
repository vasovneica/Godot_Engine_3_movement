extends VehicleBody

const STEER_SPEED = 1.5
const STEER_LIMIT = 0.4
const SWIPE_SPEED=3

var is_swipe=""
var steer_target = 0

export var engine_force_value =0


func _physics_process(delta):

	var speed_sl=self.linear_velocity.length() 
	var fwd_mps = transform.basis.xform_inv(linear_velocity).x
	steer_target *= STEER_LIMIT

	if is_swipe=="left" or Input.is_action_pressed("ui_left"):
		steer_target += STEER_LIMIT
		
	if is_swipe=="right" or  Input.is_action_pressed("ui_right"):	
		steer_target -= STEER_LIMIT

	if Input.is_action_pressed("accelerate") or is_swipe=="forward":
		
		# Increase engine force at low speeds to make the initial acceleration faster.

		if speed < 1 and speed != 0:	
			engine_force = clamp(engine_force_value * 5 / speed, 0, 100)	

		else:
			engine_force = engine_force_value

	else:
		engine_force = 0
		

	if Input.is_action_pressed("reverse") or is_swipe=="back":

		if fwd_mps >= -1:
			var speed = linear_velocity.length()	
				engine_force = -clamp(engine_force_value * 5 / speed, 0, 100)

			else:
				engine_force = -engine_force_value

		else:
			brake = 1		

	else:	
		brake = 0.0



# for touchscreen swipe control

func _input(event):
	if event is InputEventScreenDrag:
		if event.relative.x > SWIPE_SPEED:
			is_swipe="right"
		
		if event.relative.x < -SWIPE_SPEED:
			is_swipe="left"	
			
		if event.relative.y < -SWIPE_SPEED:	
			is_swipe="forward"	
						
		if event.relative.y > SWIPE_SPEED:	
			is_swipe="back"		
			
	elif event is InputEventScreenTouch:
		if !event.pressed:
			is_swipe=""	
