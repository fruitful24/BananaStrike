<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# Launcher

**Extends:** [KinematicBody2D](../KinematicBody2D)

## Description

La classe qui gère le lanceur de banane et son tir

## Property Descriptions

### rotation\_vitesse

```gdscript
export var rotation_vitesse = 1
```

Initialisation des conditions initiales pour la rotation-déplacement du lanceur
Vitesse de rotation du launcher sur lui-même

### rotation\_direction

```gdscript
export var rotation_direction = 0
```

Initialement le launcher est à l'horizontale

### vitesse\_horizontale

```gdscript
export var vitesse_horizontale = 200
```

Vitesse de déplacement horizontal du laucnher, synchronisée sur celle du gorille
Dans l'idéal il faudrait récupérer la valeur de l'autre scène

### deplacement\_horizontal

```gdscript
export var deplacement_horizontal = "(0, 0)"
```

Initialisation du vecteur2D du déplacement horizontal du laucnher

### angle\_de\_tir

```gdscript
export var angle_de_tir = 0
```

Initialisation des conditions initiales du tir

### puissance\_de\_tir

```gdscript
export var puissance_de_tir = 5
```

Vitesse initiale du tir / puissance

### gravite

```gdscript
export var gravite = 8
```

On règle la valeur de la gravité

### direction\_du\_tir

```gdscript
var direction_du_tir
```

Initialisation du vecteur2D qui permet d'obtnir l'oriantation du vecteur v0

### power\_change

```gdscript
var power_change
```

Variable qui permet de choisir une puissance de tir avec les touches + et -

### bornes

```gdscript
var bornes
```

On génère les bornes entre lesquelles le vent est généré

### vent

```gdscript
var vent
```

On tire au hasard la valeur du premier vent pour le premier tir

### waited

```gdscript
var waited
```

Initialisation du compteur de temps entre chaque tir
Intialement on a jamais attendu

### shooting

```gdscript
var shooting
```

Initialement on ne tire pas

### delay

```gdscript
export var delay = 1
```

duree entre chaque tir en seconde

### banana\_scene

```gdscript
export var banana_scene = "[Object:null]"
```

Gestion de l'import Banana Scene et Banana Spawn
On importe la scene de la banane-projectile

### banana\_spawn\_path

```gdscript
export var banana_spawn_path = ""
```

On importe l'endroit plancé sur la carte où la banane spawn

### banana\_spawn

```gdscript
var banana_spawn
```

On fait appraître la banane à cette endroit quand on est prêt à tirer

## Method Descriptions

### set\_direction

```gdscript
func set_direction()
```

Fonction qui règle l'angle initial et la puissance du tir#

### fire\_once

```gdscript
func fire_once()
```

Fonction appelée à l'appui de la touche espace, le tir est déclecnhé

### wind\_generator

```gdscript
func wind_generator()
```

Fonction qui est appelée après chaque tir, ainsi on change la valeur du vent

### shoot

```gdscript
func shoot()
```

Quand l'ordre de tirer est donné, on tire la banane dans la direction donnée

### maj\_label

```gdscript
func maj_label()
```

Fcontion qui récupère les caractéristiques du tir et qui permet ensuite de les afficher d'an le GUI

### get\_input

```gdscript
func get_input()
```

A chaque frame, on analyse si les touches du clavier sont pressées et on agit en conséquence