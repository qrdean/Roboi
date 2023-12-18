shader_type canvas_item;

uniform vec4 u_color_key : source_color;
uniform vec4 u_replacement_color : source_color;

void fragment() {
	vec4 col = texture(TEXTURE, UV);

	if (lessThan(vec4(0.001),abs(col - u_color_key))==bvec4(false)) {
		col = u_replacement_color;
	}
	COLOR = col;
}
