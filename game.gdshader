shader_type spatial;

uniform sampler2D noise_texture;

varying vec3 world_position;

void vertex() {
	world_position = (WORLD_MATRIX * vec4(VERTEX, 1.0)).xyz;
	float height = texture(noise_texture, VERTEX.xz + vec2(TIME * 0.1)).r;
	VERTEX += NORMAL * height;
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
