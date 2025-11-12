extends Node2D

signal passed

func _on_area_2d_body_entered(body):
	passed.emit()
