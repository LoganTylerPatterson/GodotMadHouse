shader_type spatial;
render_mode world_vertex_coords;

varying vec3 color;
void vertex() {
	float x = VERTEX.x;
	float y = VERTEX.y;
	float z = VERTEX.z;
	color = vec3(x, y, z);
}

void fragment() {
  ALBEDO = color + 0.3;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
