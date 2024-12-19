shader_type canvas_item;

uniform float speed = 1.0; // Speed of the movement
uniform float size = 0.2;  // Size of the cube (half the width and height)
uniform float movement_strength = 0.1; // Strength of the vertical movement

void fragment() {
    vec2 uv = UV;
    vec2 center = vec2(0.5, 0.5);

    // Create a simple rectangular shape (cube) with a size
    vec2 half_size = vec2(size, size); 

    // Add a slight vertical movement over time
    float vertical_move = sin(TIME * speed) * movement_strength;

    // Check if the current pixel is within the bounds of the cube's movement
    if (abs(uv.x - center.x) < half_size.x && abs(uv.y - (center.y + vertical_move)) < half_size.y) {
        COLOR = texture(TEXTURE, uv); // Keep the original texture color
    } else {
        discard; // Discard fragments outside the cube to make them transparent
    }
}
