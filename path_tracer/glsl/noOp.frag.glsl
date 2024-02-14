#version 330 core

uniform sampler2D u_Texture;
uniform vec2 u_ScreenDims;
uniform int u_Iterations;

in vec3 fs_Pos;
in vec2 fs_UV;

out vec4 out_Col;
void main()
{
    vec4 color = texture(u_Texture, fs_UV);
    // TODO: Apply the Reinhard operator and gamma correction
    // before outputting color.
    color.x = color.x / (1 + color.x);
    color.y = color.y / (1 + color.y);
    color.z = color.z / (1 + color.z);
    float gamma = 2.2f;
    color.x = pow(color.x,1.0f / gamma);
    color.y = pow(color.y,1.0f / gamma);
    color.z = pow(color.z,1.0f / gamma);
    out_Col = vec4(color.rgb, 1.);
}
