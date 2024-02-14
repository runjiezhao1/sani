float M_PI = 3.14159265f;
vec3 squareToDiskConcentric(vec2 xi) {
    // TODO
    float a = 2 * xi.x - 1;
    float b = 2 * xi.y - 1;
    float r = 0;
    float theta = 0;
    if(a > -b){
        if(a > b){
            r = a;
            theta = M_PI / 4 * (b / a);
        }else{
            r = b;
            theta = M_PI / 4 * ( 2 - a / b);
        }
    }else{
        if(a < b){
            r = -a;
            theta = M_PI / 4 * (4 + b / a);
        }else{
            r = -b;
            if(b != 0){
                theta = (M_PI / 4) * (6 - a / b);
            }else{
                theta = 0;
           }
        }
    }
    float x = r * cos(theta);
    float y = r * sin(theta);
    return vec3(x,y,0);
    //return vec3(0.);
}

vec3 squareToHemisphereCosine(vec2 xi) {
    // TODO
    float a = 2 * xi.x - 1;
    float b = 2 * xi.y - 1;
    float r = 0;
    float theta = 0;
    if(a > -b){
        if(a > b){
            r = a;
            theta = M_PI / 4 * (b / a);
        }else{
            r = b;
            theta = M_PI / 4 * ( 2 - a / b);
        }
    }else{
        if(a < b){
            r = -a;
            theta = M_PI / 4 * (4 + b / a);
        }else{
            r = -b;
            if(b != 0){
                theta = (M_PI / 4) * (6 - a / b);
            }else{
                theta = 0;
           }
        }
    }
    float x = r * cos(theta);
    float y = r * sin(theta);
    float z = sqrt(1 - x*x - y*y);
    return vec3(x,y,z);
    //return vec3(0.);
}

float squareToHemisphereCosinePDF(vec3 sample) {
    // TODO
    float value = max(0 , 1 - sample.x * sample.x - sample.y*sample.y);
    return sqrt(value) / M_PI;
    //return 0.;
}

vec3 squareToSphereUniform(vec2 sample) {
    // TODO
    float z = 1 - 2 * sample.x;
    float x = cos(2 * M_PI * sample.y) * sqrt(1 - z * z);
    float y = sin(2 * M_PI * sample.y) * sqrt(1 - z * z);
    return vec3(x,y,z);
    //return vec3(0.);
}

float squareToSphereUniformPDF(vec3 sample) {
    // TODO
    return 1 / 4.f / M_PI;
}
