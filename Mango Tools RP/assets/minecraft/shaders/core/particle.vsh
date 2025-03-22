#version 150

in vec3 Position;
in vec2 UV0;
in vec4 Color;
in ivec2 UV2;

uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;

out vec2 texCoord0;
out vec4 vertexColor;

out float isMarker;
out vec4 tint;

vec2[] corners = vec2[](
    vec2(0, 1),
    vec2(0, 0),
    vec2(1, 0),
    vec2(1, 1)
);

void main() {
    tint = Color;
    
    if (Color.r == 1.0 && Color.g == 0.0) {
        isMarker =  1.0;
        
        gl_Position = vec4(0.01 * corners[gl_VertexID % 4] - 1.0, 0.0, 1.0);
        texCoord0 = vec2(0);
        vertexColor = vec4(0);
    } else {
        isMarker = 0.0;

        gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
        texCoord0 = UV0;
        vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
    }
}