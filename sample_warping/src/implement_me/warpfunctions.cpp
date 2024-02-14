#define _USE_MATH_DEFINES
#include "warpfunctions.h"
#include <math.h>
#include "utils.h"
#include <iostream>

glm::vec3 WarpFunctions::squareToDiskUniform(const glm::vec2 &sample)
{
    //TODO
    float r = std::sqrt(sample.x);
    float theta = 2 * M_PI * sample.y;
    float x = r * std::cos(theta);
    float y = r * std::sin(theta);
    float z  = 0;
    return glm::vec3(x,y,z);
    //throw std::runtime_error("You haven't yet implemented uniform disk warping!");
}

glm::vec3 WarpFunctions::squareToDiskConcentric(const glm::vec2 &sample)
{
    //TODO
    float a = 2 * sample.x - 1;
    float b = 2 * sample.y - 1;
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
//            theta = (M_PI / 4) * (6 - a / b);
            if(b != 0){
                theta = (M_PI / 4) * (6 - a / b);
            }else{
                theta = 0;
           }
        }
    }
    float x = r * std::cos(theta);
    float y = r * std::sin(theta);
    return glm::vec3(x,y,0);
    //throw std::runtime_error("You haven't yet implemented concentric disk warping!");
}

float WarpFunctions::squareToDiskPDF(const glm::vec3 &sample)
{
    //TODO
    return 1 / M_PI;
}

glm::vec3 WarpFunctions::squareToSphereUniform(const glm::vec2 &sample)
{
    //TODO
    float z = 1 - 2 * sample.x;
    float x = std::cos(2 * M_PI * sample.y) * std::sqrt(1 - z * z);
    float y = std::sin(2 * M_PI * sample.y) * std::sqrt(1 - z * z);
    return glm::vec3(x,y,z);
    //throw std::runtime_error("You haven't yet implemented uniform sphere warping!");
}

float WarpFunctions::squareToSphereUniformPDF(const glm::vec3 &sample)
{
    //TODO

    return 1 / 4.f / M_PI;
}

glm::vec3 WarpFunctions::squareToSphereCapUniform(const glm::vec2 &sample, float thetaMin)
{
    //TODO
    //throw std::runtime_error("You haven't yet implemented sphere cap warping!");
    //To replace cap uniform
    float z = 1 - 2 * sample.x;
    float x = std::cos(2 * M_PI * sample.y) * std::sqrt(1 - z * z);
    float y = std::sin(2 * M_PI * sample.y) * std::sqrt(1 - z * z);
    return glm::vec3(x,y,z);
}

float WarpFunctions::squareToSphereCapUniformPDF(const glm::vec3 &sample, float thetaMin)
{
    //TODO
    return 0;
}

glm::vec3 WarpFunctions::squareToHemisphereUniform(const glm::vec2 &sample)
{
    //TODO
    float x = std::cos(2 * M_PI * sample.y) * std::sqrt(1 - sample.x*sample.x);
    float y = std::sin(2 * M_PI * sample.y) * std::sqrt(1 - sample.x*sample.x);
    float z = sample.x;
    return glm::vec3(x,y,z);
    throw std::runtime_error("You haven't yet implemented uniform hemisphere warping!");
}

float WarpFunctions::squareToHemisphereUniformPDF(const glm::vec3 &sample)
{
    //TODO
    return 1 / 2.f / M_PI;
}

glm::vec3 WarpFunctions::squareToHemisphereCosine(const glm::vec2 &sample)
{
    //TODO
    float a = 2 * sample.x - 1;
    float b = 2 * sample.y - 1;
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
//            theta = (M_PI / 4) * (6 - a / b);
            if(b != 0){
                theta = (M_PI / 4) * (6 - a / b);
            }else{
                theta = 0;
           }
        }
    }
    float x = r * std::cos(theta);
    float y = r * std::sin(theta);
    if(1 - x*x - y*y < 0 )return glm::vec3(0);
    float z = std::sqrt(1 - x*x - y*y);
    return glm::vec3(x,y,z);
    //throw std::runtime_error("You haven't yet implemented cosine-weighted hemisphere warping!");
}

float WarpFunctions::squareToHemisphereCosinePDF(const glm::vec3 &sample)
{
    //TODO
    return sample.z / M_PI;
}
