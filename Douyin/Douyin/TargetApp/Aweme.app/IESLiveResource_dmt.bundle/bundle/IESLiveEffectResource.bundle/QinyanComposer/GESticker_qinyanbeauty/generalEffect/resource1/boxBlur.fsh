uniform sampler2D inputImageTexture1;
varying highp vec2 textureCoordinate;
varying highp vec4 textureShift_1;
varying highp vec4 textureShift_2;
varying highp vec4 textureShift_3;
varying highp vec4 textureShift_4;

void main()
{
    mediump vec3 sum = texture2D(inputImageTexture1, textureCoordinate).rgb;
    sum += texture2D(inputImageTexture1, textureShift_1.xy).rgb;
    sum += texture2D(inputImageTexture1, textureShift_1.zw).rgb;
    sum += texture2D(inputImageTexture1, textureShift_2.xy).rgb;
    sum += texture2D(inputImageTexture1, textureShift_2.zw).rgb;
    sum += texture2D(inputImageTexture1, textureShift_3.xy).rgb;
    sum += texture2D(inputImageTexture1, textureShift_3.zw).rgb;
    sum += texture2D(inputImageTexture1, textureShift_4.xy).rgb;
    sum += texture2D(inputImageTexture1, textureShift_4.zw).rgb;
    
    gl_FragColor = vec4(sum * 0.1111, 1.0);
}
