#La classe qui gère le lanceur de banane et son tir
extends KinematicBody2D

class_name Launcher

#Initialisation des conditions initiales pour la rotation-déplacement du lanceur
#Vitesse de rotation du launcher sur lui-même
export (float) var rotation_vitesse = 1
#Initialement le launcher est à l'horizontale
export (float) var rotation_direction = 0
#Vitesse de déplacement horizontal du laucnher, synchronisée sur celle du gorille
export (int) var vitesse_horizontale = 200 # Dans l'idéal il faudrait récupérer la valeur de l'autre scène
#Initialisation du vecteur2D du déplacement horizontal du laucnher
export var deplacement_horizontal = Vector2()


#Initialisation des conditions initiales du tir
export (int) var angle_de_tir = 0
#Vitesse initiale du tir / puissance
export (int) var puissance_de_tir = 5
#On règle la valeur de la gravité 
export (int) var gravite = 8
#Initialisation du vecteur2D qui permet d'obtnir l'oriantation du vecteur v0
var direction_du_tir = Vector2()
#Variable qui permet de choisir une puissance de tir avec les touches + et - 
var power_change = 0 
#On génère les bornes entre lesquelles le vent est généré
var bornes = 5.1/100
#On tire au hasard la valeur du premier vent pour le premier tir
var vent = Vector2(rand_range(-bornes,bornes),rand_range(-bornes,bornes))

#Initialisation du compteur de temps entre chaque tir
#Intialement on a jamais attendu
var waited = 0
#Initialement on ne tire pas
var shooting = false 
#duree entre chaque tir en seconde
export (float) var delay = 1 

# Gestion de l'import Banana Scene et Banana Spawn
#On importe la scene de la banane-projectile
export (PackedScene) var banana_scene
#On importe l'endroit plancé sur la carte où la banane spawn
export (NodePath) var banana_spawn_path
#On fait appraître la banane à cette endroit quand on est prêt à tirer
onready var banana_spawn = get_node(banana_spawn_path)
#
#Fonction qui règle l'angle initial et la puissance du tir#
func set_direction():
	direction_du_tir = Vector2(cos(angle_de_tir),sin(angle_de_tir)) * puissance_de_tir

#Fonction appelée à l'appui de la touche espace, le tir est déclecnhé
func fire_once():
	shoot()
	shooting = false

#Fonction qui est appelée après chaque tir, ainsi on change la valeur du vent	
func wind_generator():
	vent=Vector2(rand_range(-bornes,bornes),rand_range(-bornes,bornes))


#Quand l'ordre de tirer est donné, on tire la banane dans la direction donnée
func shoot():
	#On instancie la scende de la banae
	var banana = banana_scene.instance()
	#On fait apparaître la scene banane à l'endroit choisi
	banana.set_global_position(banana_spawn.get_global_position())
	#On tire la banane avec les variabls parametres
	banana.shoot(direction_du_tir,gravite,vent)
	#On fait tourner la banane pour qu'elle soit dans le même sens que le launcher
	banana.rotation = rotation
	get_parent().add_child(banana)
	#oN regénère une autre valeur de vent une fois la banane tirée
	wind_generator()

#Fcontion qui récupère les caractéristiques du tir et qui permet ensuite de les afficher d'an le GUI
func maj_label():
	$Label_angle.text = str(int(- angle_de_tir * 180/PI ))
	$Label_puissance.text = str(int(puissance_de_tir))
	$Label_vitesse_vent.text = str(int(100 * vent.length()))
	$Label_direction_vent.text = str(float (vent.angle())*180/PI)
	
#A chaque frame, on analyse si les touches du clavier sont pressées et on agit en conséquence
func get_input():
	#On repart de l'arrêt pur la rotation et le déplacement
	rotation_direction = 0
	deplacement_horizontal = Vector2()
	if Input.is_action_pressed('down'):
		rotation_direction += 1
	if Input.is_action_pressed('up'):
		rotation_direction -= 1
	if Input.is_action_pressed('right'):
		deplacement_horizontal = Vector2(+vitesse_horizontale, 0)
	if Input.is_action_pressed('left'):
		deplacement_horizontal = Vector2(-vitesse_horizontale, 0)
	if Input.is_action_pressed("ui_power_plus"):
		power_change += 6
	if Input.is_action_pressed("ui_power_less"):
		power_change -= 6 
	
	
#Pendant le processus on déplace conjointement gorille et banane
func _physics_process(delta):
	#On récupère ici l'angle de tir avec l'orientation du launcher
	angle_de_tir = rotation 
	#On met à jour les informations à l'écran
	maj_label()
	#On surveille l'appui ou le relachement de la touche espace
	get_input()
	#Ici on fait tourner le launcher avec des valeeurs min et max 0 et un peu moins que 90 degre
	rotation += rotation_direction * rotation_vitesse * delta
	rotation  = clamp(rotation,-PI/2*0.95,0) 
	#On fait varier ici la puissance de tir après appui sur les touches + et -
	puissance_de_tir = power_change * delta
	puissance_de_tir = clamp(puissance_de_tir,2,16)
	#On déplace le launcher à l'horizontal avec la même vitesse et le même intervalle que le gorille
	deplacement_horizontal=move_and_collide(deplacement_horizontal*delta)	
	position.x = clamp(global_position.x,170,230)
	#On envoi les paramètres du tir à la fonction qui permet d'envoyer la banane dans les conditions choisies
	set_direction() 

#Dès le jeu lancé, il est prêt à gérer les processus physique est la surveillance des touches
func _ready():
	set_process_input(true)
	set_process(true)
	
#Une fois la barre d'espace pressée, on autorise le tir, puis on bascule de nouveau au relachement de la touche
func _input(event):
	if(event.is_action_pressed("ui_select")):
		shooting = true
	elif(event.is_action_released("ui_select")):
		shooting = false
		
#Fonction qui gère le compteur de tir, tant que le délai n'est pas atteint on ne peut pas tirer de nouveau
func _process(delta):
	if(shooting && waited > delay):
		fire_once()
		waited = 0
	elif(waited <= delay):
		waited += delta
#
