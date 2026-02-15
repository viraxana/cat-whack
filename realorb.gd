extends RigidBody3D

@export var max_speed: float = 6.0
#@onready var gpu_particles_3d_2: GPUParticles3D = $CSGSphere3D/GPUParticles3D2
@onready var rigid_body_3d: RigidBody3D = $"."
#@onready var audio_stream_player_3d_2: AudioStreamPlayer3D = $CSGSphere3D/AudioStreamPlayer3D2


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




func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	var is_tap = event is InputEventScreenTouch and event.pressed
	var is_click = event is InputEventMouseButton and event.pressed
	if is_tap or is_click:
		print("bubble popped")
		popped.emit(self)
