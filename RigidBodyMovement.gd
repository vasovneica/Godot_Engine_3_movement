func _physics_process(delta):

rotate_input = 0

	if is_swipe=="left" or Input.is_action_pressed("ui_left"):
		rotate_input += speed

			
	if is_swipe=="right" or  Input.is_action_pressed("ui_right"):	
		rotate_input -= speed

	rotate_input *= deg2rad(steering)

	right_wheel.rotation.y = rotate_input
	left_wheel.rotation.y = rotate_input

	speed_input = 0

	if is_swipe=="forward" or Input.is_action_pressed("ui_up"):
		speed_input += speed
		

	if is_swipe=="back" or Input.is_action_pressed("ui_down"):
		speed_input -= speed

		if is_swipe=="left" or Input.is_action_pressed("ui_left"):
			rotate_input -= speed

			
		if is_swipe=="right" or  Input.is_action_pressed("ui_right"):	
			rotate_input += speed
	
	speed_input *= acceleration



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
