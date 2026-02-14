extends RigidBody3D

@export var max_speed: float = 6.0

signal popped(bubble)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print("Spawning bubble with velocity")
	linear_velocity = Vector3(
		randf_range(-max_speed, max_speed),
		randf_range(-max_speed, max_speed),
		randf_range(-max_speed, max_speed)
	)
	#print("Velocity set to ", linear_velocity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	var is_tap = event is InputEventScreenTouch and event.pressed
	var is_click = event is InputEventMouseButton and event.pressed
	if is_tap or is_click:
		print("bubble popped")
		popped.emit(self)
