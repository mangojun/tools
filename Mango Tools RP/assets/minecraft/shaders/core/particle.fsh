#version 150

uniform sampler2D Sampler0;

in vec2 texCoord0;
in vec4 vertexColor;

out vec4 fragColor;

in float isMarker;
in vec4 tint;

void main() {
    if (isMarker == 1.0) {
        fragColor = tint;
    } else {
        vec4 color = texture(Sampler0, texCoord0) * vertexColor;
        
        if (color.a < 0.1) {
            discard;
        }

        fragColor = color;
    }
}