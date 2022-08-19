extends CollisionShape2D

func _ready() -> void:
	set_z_index(global_position.y + get_shape().get_extents().y)
