extends Control

func maj_ui():
	$Angle.text= "Angle de tir = "+ $Launcher_scene/Label_angle.text
	$Puissance.text = "Puissance du tir = " + $Launcher_scene/Label_puissance.text
	$Vitesse_vent.text = "Vitesse du vent = "	+ $Launcher_scene/Label_vitesse_vent.text
	$Direction_vent.text = "Direction du vent = "	+ $Launcher_scene/Label_direction_vent.text
	
func _physics_process(delta):
	maj_ui()
