const float FOVY = 19.5f * PI / 180.0;


Ray rayCast() {
    vec2 offset = vec2(rng(), rng());
    vec2 ndc = (vec2(gl_FragCoord.xy) + offset) / vec2(u_ScreenDims);
    ndc = ndc * 2.f - vec2(1.f);

    float aspect = u_ScreenDims.x / u_ScreenDims.y;
    vec3 ref = u_Eye + u_Forward;
    vec3 V = u_Up * tan(FOVY * 0.5);
    vec3 H = u_Right * tan(FOVY * 0.5) * aspect;
    vec3 p = ref + H * ndc.x + V * ndc.y;

    return Ray(u_Eye, normalize(p - u_Eye));
}


// TODO: Implement naive integration
vec3 Li_Naive(Ray ray) {
    vec3 accumulated = vec3(1,1,1);
    for(int i = 0; i < MAX_DEPTH; i++){
        vec3 wo = ray.direction * (-1);
        vec3 wi = vec3(0.);
        float pdf = 0;
        Intersection inter = sceneIntersect(ray);
        vec3 nor = inter.nor;
        vec2 seed = vec2(rng(),rng());
        vec3 f = Sample_f(inter,wo,seed,wi,pdf,inter.material.type);
        accumulated *= f * abs(dot(nor,wi)) / pdf;
        ray = SpawnRay(ray.direction * inter.t + ray.origin,wi);
        if(pdf < 0.000001){
            return vec3(0,0,0);
        }
        if(inter.material.type < 0){
            return vec3(0,0,0);
        }
        if(inter.t > INFINITY){
            return vec3(0,0,0);
        }
        if(length(inter.Le) > 0 ){
            accumulated = inter.Le * accumulated;
            break;
        }
    }
    return accumulated;

//    vec3 accumulated = vec3(1,1,1);
//    vec3 wo = ray.direction * (-1);
//    vec3 wi = vec3(0.);
//    float pdf = 0;
//    Intersection inter = sceneIntersect(ray);
//    vec3 nor = inter.nor;
//    vec2 seed = vec2(rng(),rng());
//    vec3 f = Sample_f(inter,wo,seed,wi,pdf,inter.material.type);
//    if(dot(inter.Le, inter.Le) > 0) {
//        return vec3(1.);
//    }
//    if(pdf < 0.000001){
//        return vec3(0,0,0);
//    }
//    if(inter.material.type < 0){
//        return vec3(0,0,0);
//    }
//    if(inter.t > INFINITY){
//        return vec3(0,0,0);
//    }
//    return wi;
}


void main()
{
    seed = uvec2(u_Iterations, u_Iterations + 1) * uvec2(gl_FragCoord.xy);

    Ray ray = rayCast();

    // TODO: Implement Li_Naive
    vec3 thisIterationColor = Li_Naive(ray);

    // TODO: Set out_Col to the weighted sum of thisIterationColor
    // and all previous iterations' color values.
    // Refer to pathtracer.defines.glsl for what variables you may use
    // to acquire the needed values.

    vec3 texturecolor = texture(u_AccumImg,fs_UV).rgb;
    vec3 newColor = mix(texturecolor,thisIterationColor,1.f / u_Iterations);
    out_Col = vec4(newColor,1.f);

//    thisIterationColor.x = (thisIterationColor.x + 1) / 2.f;
//    thisIterationColor.y = (thisIterationColor.y + 1) / 2.f;
//    thisIterationColor.z = (thisIterationColor.z + 1) / 2.f;
//    out_Col = vec4(thisIterationColor,1.f);
}
