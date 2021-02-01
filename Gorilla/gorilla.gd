extends KinematicBody2D

# Gravity
export (int) var gravite = 5
# Vitesse initiale
export (int) var vitesse = 3
# Angle initial
export (float) var angle = 345 setget set_banana_angle

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


func set_banana_angle(value):
	angle = clamp(value,0,359)

func set_direction():
	direction = Vector2(cos(angle*(PI/180)),sin(angle*(PI/180))) * vitesse


func _ready():
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
		
func fire_once():
	shoot()
	shooting = false


func shoot():
	var banana = banana_scene.instance()
	banana.set_global_position(banana_spawn.get_global_position())
	banana.shoot(direction,gravite)
	get_parent().add_child(banana)

	
