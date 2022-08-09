extends Node2D

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var ground

func _ready() -> void:
	ground = get_node("Ground/GroundSurface")
	hide()
