# la classe qui gère la trajectoire du projectile-banane
extends KinematicBody2D

class_name Banana

# La gravité est fiée à 0 mais on la récupère depuis la scène launcher, c'est la valeur locale de la classe
var _gravite = 0
# Tirage aléatoire du vent
var _vent = Vector2()
# Initialisation du vecteur de déplacement pour le projectile-banane
var _movement = Vector2()


# Méthode pour le tir -  On récupère les paramètres du tir de l'autre scène
func shoot(direction_du_tir,gravite,vent):
	_movement = direction_du_tir 
	_gravite = gravite 
	_vent = vent
	# On réalise la bascule pour qu'une fois tirée, le moteur de jeu déplace la banane
	set_physics_process(true)
	
# Le moteur de jeu fait se déplacer la banane
func _physics_process(delta):
	#Le mouvement horizontal et gérer par le vent, le vertical par la gravité
	_movement.x +=  _vent.x 
	_movement.y +=  delta * _gravite + _vent.y
	# Petite animation de la rotation de la banane sur elle-même quand elle se déplace
	rotation = 9*_movement.angle()
	# Elle se déplace
	move_and_collide(_movement*delta*50)


