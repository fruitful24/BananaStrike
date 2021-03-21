extends KinematicBody2D


export (int) var vitesse_horizontale = 200

var deplacement_horizontal = Vector2()

func get_input():
	deplacement_horizontal = Vector2()
	if Input.is_action_pressed('right'):
		deplacement_horizontal = Vector2(+vitesse_horizontale, 0).rotated(rotation)
	if Input.is_action_pressed('left'):
		deplacement_horizontal = Vector2(-vitesse_horizontale, 0).rotated(rotation)

func _physics_process(delta):
	get_input()
	move_and_slide(deplacement_horizontal)
	position.x = clamp(global_position.x,0,200)
	

