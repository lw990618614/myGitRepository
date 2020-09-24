attribute vec3 attPosition;
attribute vec2 attUV;

uniform float texelWidthOffset;
uniform float texelHeightOffset;
varying vec2 textureCoordinate;
varying vec4 textureShift_1;
varying vec4 textureShift_2;
varying vec4 textureShift_3;
varying vec4 textureShift_4;

void main(void)
{
    gl_Position = vec4(attPosition, 1.0);
    textureCoordinate = attUV;
    
    vec2 singleStepOffset = vec2(texelWidthOffset, texelHeightOffset);
    textureCoordinate = attUV;
    textureShift_1 = vec4(attUV - singleStepOffset, attUV + singleStepOffset);
    textureShift_2 = vec4(attUV - 2.0 * singleStepOffset, attUV + 2.0 * singleStepOffset);
    textureShift_3 = vec4(attUV - 3.0 * singleStepOffset, attUV + 3.0 * singleStepOffset);
    textureShift_4 = vec4(attUV - 4.0 * singleStepOffset, attUV + 4.0 * singleStepOffset);
}
