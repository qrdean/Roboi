//shader_type canvas_item;

vec3 fresnel(float amount, float intensity, vec3 color, vec3 normal, vec3 view)
{
	return pow((1.0 - dot(normalize(normal), normalize(view))), amount) * color * intensity;
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() 
{
	vec3 base_color = vec3(0.5, 0.2, 0.9);
	vec3 fresnel_color = vec3(0.0, 0.7, 0.9);
	float basic_fresnal = fresnel(3.0, 4.5, fresnel_color, NORMAL, VIEW);
	ALBEDO = base_color + basic_fresnal;
}

void light() {
	// Called for every pixel for every light affecting the CanvasItem.
}
