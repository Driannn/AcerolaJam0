extends CharacterBody2D

#Tutorial for this code:
#https://www.youtube.com/watch?v=9u6edV5-EEI&list=PLhXFaKLHQJdXpwaNt6gGwpHLTWL0m-TSL

#CharacterBody2D Template
#
#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#
#
#func _physics_process(delta):
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()

@export_category("Player")
##Player speed on X
@export var h_speed : float = 300.0
##Jump forceof the player
@export var jump_force : float = 200.0
##Gravity acceleration
@export var gravity_acceleration : float = 500.0
##Gravity max speed
@export var gravity_max_speed : float = 1000.0

##Count amount of jumps, for double jump feature
var jump_count : int = 0

func _physics_process(delta):
	apply_gravity(delta)
	move_on_x(delta)
	jump()
	move_and_slide()

##Get players input and apply it to the X velocity
func move_on_x(delta : float) -> void:
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = h_speed * horizontal_direction * delta * 50

##Apply force to the Y velocity if the player is not on the floor
func apply_gravity(delta : float) -> void:
	if !is_on_floor() && velocity.y < gravity_max_speed:
		velocity.y += gravity_acceleration * delta
		#print("adding gravity")
	#else:
		#print("not adding gravity")

##Get input and apply jump force to Y
func jump() -> void:
	if Input.is_action_just_pressed("jump") && jump_count < 1:
		velocity.y = -jump_force
		jump_count += 1
		print (jump_count)
	
	if is_on_floor():
		jump_count = 0
