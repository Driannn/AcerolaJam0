extends CharacterBody2D

#Tutorials for this code:
#https://www.youtube.com/watch?v=9u6edV5-EEI&list=PLhXFaKLHQJdXpwaNt6gGwpHLTWL0m-TSL
#https://www.youtube.com/watch?v=JLGzCZPzFnI&list=PLhBqFleCVBkUO80cBS5DDL0qvW362FmMb&index=8

#region @export variables
@export_category("Player")
##Player speed on X
@export var h_speed : float = 300.0
##Dash speed
@export var dash_speed := 900.0
##Define if it is dashing or not
@export var dashing := false
##Limit when the player can dash
@export var can_dash := true
##Jump forceof the player
@export var jump_force : float = 200.0
##Determines the maximun of jumps the player can do
@export var max_jumps : int = 2
##Player Health
@export var health := 100

@export_category("World")
##Gravity acceleration
@export var gravity_acceleration : float = 500.0
##Gravity max speed
@export var gravity_max_speed : float = 1000.0

@export_category("VFX")
##Trail lenght
@export var trail_lenght := 12
#endregion

#region @onready variables
##Reference to the animation player node
@onready var ap = %AnimationPlayer
##Reference to the Sprite2D player node
@onready var sprite = %Sprite2D
##Reference to the sword node
@onready var sword = %WeaponSword
##Reference to health bar
@onready var health_bar = %HeathBar
##Reference to Timer for hurt animation
@onready var hurt_anim = $HurtAnim
##Reference to trail
@onready var my_trails = %MyTrails
##Reference to Dash timer
@onready var dash_durantion = %DashDurantion
##Dash cooldown
@onready var dash_cooldown = %DashCooldown

#endregion

#region normal variables
##Count amount of jumps, for double jump feature
var jump_count : int = 0
##Is player dead
var is_dead := false
#endregion

#NATIVE GODOT FUNCTIONS

func _ready():
	health_bar.init_health(health)

func _physics_process(delta):
	
	#PLAYER MOVEMENT FUNCTIONS
	
	apply_gravity(delta)
	 
	if !is_dead:
		move_on_x(delta)
		jump()
		#AMINATION LOGIC
		update_animations(get_movement_input())
	
	dead_no_slippery(delta)
	#Moves the body based on player's velocity
	move_and_slide()
	

#MY FUNCTIONS

##Get players input
func get_movement_input() -> float:
	
	if Input.is_action_just_pressed("dash") and can_dash and velocity.x != 0:
		dashing = true
		can_dash = false
		dash_durantion.start()
		dash_cooldown.start()
	return Input.get_axis("move_left", "move_right")

##Use players input and apply it to the X velocity
func move_on_x(delta : float) -> void:
	var horizontal_direction = get_movement_input()
	
	if dashing:
		if horizontal_direction < 0:
			velocity.x = dash_speed * -1 * delta * 50
		elif horizontal_direction > 0:
			velocity.x = dash_speed * 1 * delta * 50
		velocity.y = 0
	else:
		velocity.x = h_speed * horizontal_direction * delta * 50
	
	sprite_flip(horizontal_direction)

##Flip the sprite based on horizontal direction
func sprite_flip(horizontal_direction):
	#If the player is moving
	if horizontal_direction != 0:
		#flip the sprite if the direction is left and go back to normal if direction is right
		sprite.flip_h = horizontal_direction < 0
		flip_sword()
		
func flip_sword():
	if sprite.flip_h:
		sword.scale.x = -1
	else:
		sword.scale.x = 1

##Apply force to the Y velocity if the player is not on the floor
func apply_gravity(delta : float) -> void:
	#If the player is not on floor and havent reached maximun gravity speed
	#then apply acceleration force to Y velocity
	if !is_on_floor() && velocity.y < gravity_max_speed:
		velocity.y += gravity_acceleration * delta

##Check if it is possible to jump and returns a bool, resent the jump count on floor
func handle_jump() -> bool:
	
	
	if is_on_floor():
		jump_count = 0
	if Input.is_action_just_pressed("jump") && jump_count < max_jumps:
		return true
	return false

##Get input and apply jump force to Y
func jump():
	if handle_jump():
		velocity.y = -jump_force
		jump_count += 1

##Handle the chages between animation states
func update_animations(horizontal_direction : float) -> void:
	
	if !hurt_anim.is_stopped():
		return
	
	if is_on_floor():
		if horizontal_direction == 0:
			ap.play("idle")
		else:
			ap.play("run")
	elif velocity.y < 0:
		ap.play("jump")
	elif velocity.y > 0:
		ap.play("fall")

func take_damage(amount: int) -> void:

	if is_dead:
		return
	set_health(amount)
	health -= amount
	ap.play("hurt")
	hurt_anim.start()

	check_dead()
	print("Player take damage. health: ", health)

func check_dead():
	if health <= 0:
		is_dead = true
		sword.visible = false
		sword.queue_free()
		ap.play("dead")


func dead_no_slippery(_delta):
	if is_dead:
		velocity.x = 0

func set_health(value):
	health_bar.health -= value

#SIGNALS
#hurt animation timer
#func _on_timer_timeout():
	#update_animations(get_movement_input())
	#pass # Replace with function body.

#stop dashing
func _on_dash_durantion_timeout():
	dashing = false


func _on_dash_cooldown_timeout():
	can_dash = true
