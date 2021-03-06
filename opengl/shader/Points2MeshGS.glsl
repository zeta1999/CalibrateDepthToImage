#version 450 

layout( triangles ) in;
//layout( points, max_vertices = 1) out;
layout( triangle_strip, max_vertices = 3) out;

uniform mat4 model_matrix;
uniform mat4 view_matrix;
uniform mat4 projection_matrix;

float thresh = 1;

void main() {
    mat4 mvp_matrix = projection_matrix*view_matrix*model_matrix;
	vec3 p0 = gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_in[1].gl_Position.xyz;
	vec3 p2 = gl_in[2].gl_Position.xyz;
	if (p0.z == 0 || p1.z == 0 || p2.z == 0)
		return;

	if (distance(p0.z, p1.z) > thresh || distance(p0.z, p2.z) > thresh || distance(p1.z, p2.z) > thresh)
		return;
    gl_Position = mvp_matrix*vec4(p0, 1.0);
	EmitVertex();
    gl_Position = mvp_matrix*vec4(p1, 1.0);
	EmitVertex();
    gl_Position = mvp_matrix*vec4(p2, 1.0);
	EmitVertex();
    EndPrimitive();

}
