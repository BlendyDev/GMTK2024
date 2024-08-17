 shader_type canvas_item;

uniform vec4 unlit_color : hint_color = vec4(0f, 0f, 0f, 1f); uniform sampler2D unlit_texture : hint_albedo;

void fragment() {
// I want to use the detailed texture's alpha at all times.
// The unlit texture can be low res or unassigned
float a = texture(TEXTURE, UV).a;

if(!AT_LIGHT_PASS) {
// Just show the unlit texture/color.
COLOR = vec4(unlit_color.rgb * texture(unlit_texture, UV).rgb, a);
} else {
// White, the only way to get the correct LIGHT value as input.
// Lights are multiplied by the COLOR output from fragment in the
// light pass (!!), so having pure white will show the exact light
// values.
COLOR = vec4(vec3(1f), a);
}
}

void light() {
// The lit texture's color
vec4 color = texture(TEXTURE, UV);

// Here's the tricky part: the LIGHT output is multiplied by the
// fragment()'s AT_LIGHT_PASS output. So, setting it to transparent
// black doesn't mean my terrains don't show up, it means I only see
// what is put out by the fragment()'s non-light pass part. Because I
// use LIGHT as alpha to mix between the two, the mix statement is
// executed per color channel. So a red light will only show the red
// channel of my lit texture.
LIGHT = mix(vec4(0f), color, LIGHT);
} 