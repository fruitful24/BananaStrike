#La classe qui gère le gorille et son déplacement
extends KinematicBody2D

class_name Gorilla

#Initialisation du vecteur deplacement horizontal
export var deplacement_horizontal = Vector2()
#Vitesse de deplacement horizontal
export (int) var vitesse_horizontale = 200

#On recupere les actions du clavier
func get_input():
	deplacement_horizontal = Vector2()
	#fleche droite
	if Input.is_action_pressed('right'):
		deplacement_horizontal = Vector2(+vitesse_horizontale, 0)
	#fleche gauche
	if Input.is_action_pressed('left'):
		deplacement_horizontal = Vector2(-vitesse_horizontale, 0)

#On réalise de déplacement physique du gorille
func _physics_process(delta):
	get_input()
	deplacement_horizontal=move_and_collide(deplacement_horizontal*delta)
	position.x = clamp(global_position.x,170,230)
	
