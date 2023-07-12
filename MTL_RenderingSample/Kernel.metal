#include <metal_stdlib>
using namespace metal;

struct ShaderIO
{
    float4 position [[ position ]];
    float2 texCoords;
};

vertex ShaderIO vertexShader(constant float4 *positions [[ buffer(0) ]],
                             constant float2 *texCoords [[ buffer(1) ]],
                                      uint    vid       [[ vertex_id ]])
{
    ShaderIO out;
    out.position = positions[vid];
    out.texCoords = texCoords[vid];
    return out;
}

constant float3 grayWeight = float3(0.298912, 0.586611, 0.114478);

fragment float4 fragmentShader(ShaderIO       in      [[ stage_in ]],
                               texture2d<float> texture [[ texture(0) ]])
{
    constexpr sampler colorSampler;
    float4 color = texture.sample(colorSampler, in.texCoords);
    float  gray  = dot(color.rgb, grayWeight);
    return float4(gray, gray, gray, 1.0);
}
