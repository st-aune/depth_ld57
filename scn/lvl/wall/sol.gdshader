shader_type canvas_item;


uniform vec4 overridecolor : source_color  = vec4(0.0);
uniform vec4 modulate : source_color  = vec4(1.0);
uniform sampler2D noise : repeat_enable;
uniform vec2 scaler = vec2(0.5,0.5);
uniform vec2 noise_scaler = vec2(0.5,0.5);
uniform vec2 offset = vec2(0.0,0.0);
void vertex() {
	// To deal with
	UV = ( MODEL_MATRIX * vec4(VERTEX,0.0,1.0)).xy;
}

void fragment() {
	vec2 uv = UV * scaler * TEXTURE_PIXEL_SIZE;
	vec4 sampled = texture(TEXTURE,uv+offset).rgba;
	float noiser = texture(noise,uv*noise_scaler).r;
	//COLOR.rgb = sampled.rgb;
	COLOR.rgb = mix(sampled.rgb,sampled.rgb*overridecolor.rgb,pow(noiser,1)*overridecolor.a)*modulate.rgb;
	COLOR.a = sampled.a;


}