extends KinematicBody2D

export (float) var rotation_vitesse = 0.1
export (float) var rotation_direction = 0

var deplacement_horizontal = Vector2()
export (int) var vitesse_horizontale = 200

# Gravity # Vitesse initiale # Angle initial
export (int) var gravite = 2
export (int) var vitesse = 5
export (float) var angle_tir = 0

# Banana Scene
export (PackedScene) var banana_scene

# Banana Spawn
export (NodePath) var banana_spawn_path
onready var banana_spawn = get_node(banana_spawn_path)

#direction
var direction = Vector2()

#Shooting et delai?
var shooting = false
export (float) var delay = 1 #seconde
var waited = 0 

func set_banana_angle():
	angle_tir = rotation


func set_direction():
	direction = Vector2(cos(angle_tir*(PI/180)),sin(angle_tir*(PI/180))) * vitesse

func fire_once():
	shoot()
	shooting = false

func shoot():
	var banana = banana_scene.instance()
 	banana.set_global_position(banana_spawn.get_global_position())
	banana.shoot(direction,gravite)
	get_parent().add_child(banana)

func get_input():
	rotation_direction = 0
	deplacement_horizontal = Vector2()
	if Input.is_action_pressed('down'):
		rotation_direction += 0.1
	if Input.is_action_pressed('up'):
		rotation_direction -= 0.1
	if Input.is_action_pressed('right'):
		deplacement_horizontal = Vector2(+vitesse_horizontale, 0)
	if Input.is_action_pressed('left'):
		deplacement_horizontal = Vector2(-vitesse_horizontale, 0)

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_vitesse * delta
	rotation  = clamp(rotation,-PI/2,0) 
	move_and_slide(deplacement_horizontal)
	position.x = clamp(global_position.x,0,200)

func _ready():
	set_banana_angle()
	set_direction() 
	set_process_input(true)
	set_process(true)

func _input(event):
	if(event.is_action_pressed("ui_select")):
		shooting = true
	elif(event.is_action_released("ui_select")):
		shooting = false

func _process(delta):
	if(shooting && waited > delay):
		fire_once()
		waited = 0
	elif(waited <= delay):
		waited += delta
		
