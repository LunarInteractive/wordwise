shader_type canvas_item;

uniform vec2 shadow_offset = vec2(10.0, 10.0);
uniform vec4 shadow_color : source_color = vec4(0.0, 0.0, 0.0, 0.5);
uniform float blur_radius : hint_range(0.0, 20.0) = 5.0;

void fragment() {
    // Sample the original texture color
    vec4 original_color = texture(TEXTURE, UV);
    
    // Initialize shadow color to be accumulated from neighboring pixels
    vec4 shadow_accum = vec4(0.0);
    float total_weight = 0.0;

    // Number of samples to create the blur effect
    int samples = int(blur_radius * 2.0);

    // Loop through nearby pixels based on blur_radius to create the shadow blur
    for (int x = -samples; x <= samples; x++) {
        for (int y = -samples; y <= samples; y++) {
            vec2 offset = vec2(float(x), float(y)) * (blur_radius / float(samples)) / vec2(TEXTURE_PIXEL_SIZE);
            vec2 shadow_uv = UV + (shadow_offset / vec2(TEXTURE_PIXEL_SIZE)) + offset;

            // Sample the texture at the offset position
            vec4 sample_color = texture(TEXTURE, shadow_uv);
            
            // Accumulate shadow colors, modulating by shadow_color for transparency and color effect
            float weight = 1.0 / (1.0 + length(vec2(float(x), float(y))));
            shadow_accum += sample_color * shadow_color * weight;
            total_weight += weight;
        }
    }

    // Normalize the accumulated shadow color
    vec4 blurred_shadow_color = shadow_accum / total_weight;

    // Final color: if there is original texture, use it; otherwise, use the blurred shadow
    if (original_color.a > 0.0) {
        COLOR = original_color;
    } else {
        COLOR = blurred_shadow_color;
    }
}
