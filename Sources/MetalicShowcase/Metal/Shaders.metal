//
//  Shaders.metal
//  Metalim
//
//  Created by Nizamet Özkan on 6.12.2023.
//

#include <metal_stdlib>
#include "../../MetalicShowcaseHeader/include/MetalicShowcaseHeader.h"
using namespace metal;

#include <simd/simd.h>

struct VertexIn {
    float4 position [[ attribute(0) ]];
    float2 texCoord [[ attribute(1) ]];
};

struct Fragment {
    float4 position [[position]];
    float3 cameraPosition;
    float2 texCoord;
    float3 fragmentPosition;
};

vertex Fragment vertexShader(const VertexIn vertex_in [[ stage_in ]], constant matrix_float4x4 &model [[ buffer(1) ]], constant CameraParameters &camera [[ buffer(2) ]])
{
    Fragment output;
    output.position = camera.projection * camera.view * model * vertex_in.position;
    output.texCoord = vertex_in.texCoord;
    output.cameraPosition = float3(model * float4(camera.position, 1.0));
    output.fragmentPosition = float3(model * vertex_in.position);

    return output;
}

fragment float4 fragmentShader(Fragment input [[stage_in]], texture2d<float> objectTexture [[texture(0)]], sampler samplerObject [[sampler(0)]])
{
    float3 baseColor = float3(objectTexture.sample(samplerObject, input.texCoord));
    float alpha = objectTexture.sample(samplerObject, input.texCoord).a;

    float3 color = 1.0 * baseColor;

    return float4(color, alpha);
}
