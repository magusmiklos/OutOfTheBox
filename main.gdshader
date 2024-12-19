shader_type canvas_item;

uniform vec3 color_one : source_color; 
uniform vec3 color_two : source_color;  

uniform float angle = 20.0;
uniform float line_count = 10.0; 
uniform float speed = 1.0; 
uniform float blur : hint_range(0.0, 2.0, 0); 

vec2 rotate(vec2 uv, float rotation_angle) {
    float radians_angle = radians(rotation_angle);
    float cos_angle = cos(radians_angle);
    float sin_angle = sin(radians_angle);
    mat2 rotation_matrix = mat2(vec2(cos_angle, -sin_angle), vec2(sin_angle, cos_angle));
    return uv * rotation_matrix;
}

float stripe(vec2 uv) {
    float curve = sin(uv.y * 10.0 + TIME * speed * 0.01) * 0.1; // Curve effect
    uv.x += curve; // Apply the curve effect to the x-coordinate
    
    // Increased frequency for more pronounced waves
    float wave_x = sin(uv.x * 1000.0 - TIME * speed); // Increased frequency in the x-direction
    float wave_y = cos(uv.y * 1000.0 + TIME * speed * 0.5); // Higher frequency for vertical waves
    return wave_x * wave_y; // Combining both horizontal and vertical waves for more complexity
}

void fragment() {
    vec2 uv = UV;
    vec2 resolution = 1.0 / TEXTURE_PIXEL_SIZE;
    float a = TEXTURE_PIXEL_SIZE.x / TEXTURE_PIXEL_SIZE.y;
    uv.x *= a;
    uv = rotate(uv, angle);
    float g = stripe(uv);
    vec3 col = mix(color_one, color_two, smoothstep(0.0, blur, g));
    COLOR = vec4(col, 1.0);
}
