extends KinematicBody2D

#Gravity
var _gravite = 0
var _vent = rand_range(-4,4)
var _movement = Vector2()


func shoot(direction,gravite):
	_movement = direction
	_gravite = gravite
	#set_physics_process(true)
	
func _physics_process(delta):
	#Création de la gravité
	_movement.y += delta * _gravite
	_movement.x += -delta*_vent
	# Move !
# warning-ignore:return_value_discarded
	rotation = 100*_movement.angle()
	#rotation += rotation_direction * rotation_vitesse * delta
	move_and_slide(_movement)
