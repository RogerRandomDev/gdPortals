shader_type spatial;
render_mode unshaded;

uniform sampler2D TEXTURE;


void vertex() {
}

void fragment() {
	vec2 base_uv = SCREEN_UV;
	vec4 albedo_tex = texture(TEXTURE,base_uv);
	ALBEDO = albedo_tex.rgb;
}
