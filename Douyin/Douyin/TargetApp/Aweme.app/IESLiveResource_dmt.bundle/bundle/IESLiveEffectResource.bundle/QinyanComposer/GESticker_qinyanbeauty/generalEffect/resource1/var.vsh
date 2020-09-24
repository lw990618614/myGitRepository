attribute vec3 attPosition;
attribute vec2 attUV;

varying vec2 textureCoordinate;
varying vec2 textureCoordinate2;

void main(void)
{
    gl_Position = vec4(attPosition, 1.0);
    textureCoordinate = attUV;
    textureCoordinate2 = attUV;
}
