shader_type canvas_item;

// Called for every vertex the material is visible on.
void vertex() {
	float speed = 0.5;
	float multiplier = 1000.0;
	
	float wave = sin(TIME * speed) * multiplier;
	vec2 vector = vec2(wave, 0);
	
	if (VERTEX.y < 0.0) {
		VERTEX += vector;
	}	
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
