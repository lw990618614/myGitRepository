varying highp vec2 textureCoordinate;
varying highp vec2 textureCoordinate2;
uniform sampler2D inputImageTexture1;
uniform sampler2D inputImageTexture2;

void main()
{
    lowp vec3 iColor = texture2D(inputImageTexture1, textureCoordinate).rgb;
    lowp vec3 meanColor = texture2D(inputImageTexture2, textureCoordinate2).rgb;
    highp vec3 diffColor = (iColor - meanColor) * 7.07;
    diffColor = min(diffColor * diffColor, 1.0);
    gl_FragColor = vec4(diffColor, 1.0);
}
