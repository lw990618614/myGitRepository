precision mediump float;
varying highp vec2 textureCoordinate;
varying highp vec4 textureShift_1;
varying highp vec4 textureShift_2;
varying highp vec4 textureShift_3;
varying highp vec4 textureShift_4;

uniform sampler2D inputImageTexture1;
uniform sampler2D inputImageTexture2;
uniform sampler2D inputImageTexture3;
uniform sampler2D lookUpGray;
uniform sampler2D lookUp;
uniform sampler2D lookUpOrigin;
uniform sampler2D lookUpSkin;
uniform sampler2D lookUpCustom;
uniform lowp float blurAlpha;
uniform highp float sharpen;
uniform lowp float whiten;

const float levelRangeInv = 1.02657;
const float levelBlack = 0.0258820;
const float alpha = 0.7;

void main()
{
    lowp vec4 iColor = texture2D(inputImageTexture1, textureCoordinate);
    lowp vec4 meanColor = texture2D(inputImageTexture2, textureCoordinate);
    lowp vec4 varColor = texture2D(inputImageTexture3, textureCoordinate);
    
    lowp float theta = 0.1;
    mediump float p = clamp((min(iColor.r, meanColor.r - 0.1) - 0.2) * 4.0, 0.0, 1.0);
    mediump float meanVar = (varColor.r + varColor.g + varColor.b) / 3.0;
    mediump float kMin;
    lowp vec3 resultColor;
    kMin = (1.0 - meanVar / (meanVar + theta)) * p * blurAlpha;
    resultColor = mix(iColor.rgb, meanColor.rgb, kMin);
    
    mediump float sum = 0.25*iColor.g;
    sum += 0.125 *texture2D(inputImageTexture1,textureShift_1.xy).g;
    sum += 0.125 *texture2D(inputImageTexture1,textureShift_1.zw).g;
    sum += 0.125 *texture2D(inputImageTexture1,textureShift_2.xy).g;
    sum += 0.125 *texture2D(inputImageTexture1,textureShift_2.zw).g;
    sum += 0.0625*texture2D(inputImageTexture1,textureShift_3.xy).g;
    sum += 0.0625*texture2D(inputImageTexture1,textureShift_3.zw).g;
    sum += 0.0625*texture2D(inputImageTexture1,textureShift_4.xy).g;
    sum += 0.0625*texture2D(inputImageTexture1,textureShift_4.zw).g;
    
    float hPass = iColor.g-sum+0.5;
    float flag = step(0.5, hPass);
    highp vec3 color = mix(max(vec3(0.0), (2.0*hPass + resultColor - 1.0)), min(vec3(1.0), (resultColor + 2.0*hPass - 1.0)), flag);
    vec3 colorEPM = mix(resultColor.rgb, color.rgb, sharpen);
    
    // whiten
    color = clamp((colorEPM - vec3(levelBlack)) * levelRangeInv, 0.0, 1.0);
    lowp vec3 texel = vec3(texture2D(lookUpGray, vec2(color.r, 0.5)).r, texture2D(lookUpGray, vec2(color.g, 0.5)).g, texture2D(lookUpGray, vec2(color.b, 0.5)).b);
    texel = mix(color, texel, 0.5);
    texel = mix(colorEPM, texel, alpha);
    
    texel = clamp(texel, 0., 1.);
    float blueColor = texel.b * 15.0;
    vec2 quad1;
    quad1.y = floor(floor(blueColor) * 0.25);
    quad1.x = floor(blueColor) - (quad1.y * 4.0);
    vec2 quad2;
    quad2.y = floor(ceil(blueColor) * 0.25);
    quad2.x = ceil(blueColor) - (quad2.y * 4.0);
    vec2 texPos2 = texel.rg * 0.234375 + 0.0078125;
    vec2 texPos1 = quad1 * 0.25 + texPos2;
    texPos2 = quad2 * 0.25 + texPos2;
    vec3 newColor1Origin = texture2D(lookUpOrigin, texPos1).rgb;
    vec3 newColor2Origin = texture2D(lookUpOrigin, texPos2).rgb;
    vec3 colorOrigin = mix(newColor1Origin, newColor2Origin, fract(blueColor));
    texel = mix(colorOrigin, color, alpha);
    
    texel = clamp(texel, 0., 1.);
    blueColor = texel.b * 15.0;
    quad1.y = floor(floor(blueColor) * 0.25);
    quad1.x = floor(blueColor) - (quad1.y * 4.0);
    quad2.y = floor(ceil(blueColor) * 0.25);
    quad2.x = ceil(blueColor) - (quad2.y * 4.0);
    texPos2 = texel.rg * 0.234375 + 0.0078125;
    texPos1 = quad1 * 0.25 + texPos2;
    texPos2 = quad2 * 0.25 + texPos2;
    vec3 newColor1 = texture2D(lookUpSkin, texPos1).rgb;
    vec3 newColor2 = texture2D(lookUpSkin, texPos2).rgb;
    color = mix(newColor1.rgb, newColor2.rgb, fract(blueColor));
    
    color = clamp(color, 0., 1.);
    highp float blueColor_custom = color.b * 63.0;
    highp vec2 quad1_custom;
    quad1_custom.y = floor(floor(blueColor_custom) / 8.0);
    quad1_custom.x = floor(blueColor_custom) - (quad1_custom.y * 8.0);
    highp vec2 quad2_custom;
    quad2_custom.y = floor(ceil(blueColor_custom) /8.0);
    quad2_custom.x = ceil(blueColor_custom) - (quad2_custom.y * 8.0);
    highp vec2 texPos1_custom;
    texPos1_custom.x = (quad1_custom.x * 1.0/8.0) + 0.5/512.0 + ((1.0/8.0 - 1.0/512.0) * color.r);
    texPos1_custom.y = (quad1_custom.y * 1.0/8.0) + 0.5/512.0 + ((1.0/8.0 - 1.0/512.0) * color.g);
    highp vec2 texPos2_custom;
    texPos2_custom.x = (quad2_custom.x * 1.0/8.0) + 0.5/512.0 + ((1.0/8.0 - 1.0/512.0) * color.r);
    texPos2_custom.y = (quad2_custom.y * 1.0/8.0) + 0.5/512.0 + ((1.0/8.0 - 1.0/512.0) * color.g);
    newColor1 = texture2D(lookUpCustom, texPos1_custom).rgb;
    newColor2 = texture2D(lookUpCustom, texPos2_custom).rgb;
    lowp vec3 color_custom = mix(newColor1, newColor2, fract(blueColor_custom));
    color = mix(colorEPM, color_custom, whiten);
    
    gl_FragColor = vec4(color, 1.0);
}
