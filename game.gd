extends Node3D

@export var bubble_scene: PackedScene
var pop_effect_scene = preload("particle_audio.tscn")
const FARTS = preload("uid://crxo0xsyaq0lv")


@onready var min_distance: float = 0.6
@onready var spawn_area_x: float = 1.5
@onready var spawn_area_y: float = 1.5
@onready var spawn_area_z: float = 1.5

var bubbles: Array[Node3D] = []

#@onready var intro_canvas: CanvasLayer = $CanvasLayer
#@onready var play_button: TextureButton = $CanvasLayer/TextureButton
var intro = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	intro = load("res://intro.tscn").instantiate()
	add_child(intro)
	
	var play_button = intro.find_child("TextureButton")
	play_button.pressed.connect(_on_play_pressed)
	
func _on_play_pressed():
	intro.queue_free()
	spawn_bubbles()

func spawn_bubbles():
	print("LESSSGOOOOO")
	var count = randi_range(6,10)
	print("Spawning ",count," spheres")
	for i in range(count):
		print("Sphere ",i," spawned")
		var bubble = bubble_scene.instantiate()
		var position_found = false 
		var new_position = Vector3.ZERO 
		for attempt in range(50): 
			new_position = Vector3( 
				randf_range(-spawn_area_x, spawn_area_x), 
				spawn_area_z, randf_range(-spawn_area_z, spawn_area_z) 
			) 
		var is_clear = true 
		for existing_bubble in bubbles: 
			if new_position.distance_to(existing_bubble.position) < min_distance: 
				is_clear = false 
				break 
			if is_clear: 
				position_found = true 
				break 
		if position_found: 
			bubble.position = new_position 
			add_child(bubble) 
			bubbles.append(bubble) 
		else: 
			bubble.position = new_position 
			add_child(bubble) 
			bubbles.append(bubble) 
			#bubble.queue_free() 
			#print("Couldn't find space for bubble ", i, ", skipping it")
		bubble.popped.connect(pop_bubble)

func pop_bubble(bubble):
	print("Popping bubble birdie!")
	var effect = pop_effect_scene.instantiate()
	effect.position = bubble.global_position
	add_child(effect)
	var particles = effect.get_child(0)
	
	particles.call_deferred("set_emitting", true)
	particles.call_deferred("restart")
	
	#particles.set_emitting(true)
	#particles.restart()
	
	effect.get_child(1).play(true)
	get_tree().create_timer(particles.lifetime + 0.5).timeout.connect(effect.queue_free)
	
	
	bubbles.erase(bubble)
	bubble.queue_free()
	
