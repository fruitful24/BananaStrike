extends KinematicBody2D

#Gravity
var _gravite = 0

var _movement = Vector2()

func shoot(direction,gravite):
	_movement = direction
	_gravite = gravite
	#set_physics_process(true)
	
func _physics_process(delta):
	#Création de la gravité
	_movement.y += delta * _gravite
	# Move !
# warning-ignore:return_value_discarded
	move_and_collide(_movement)
