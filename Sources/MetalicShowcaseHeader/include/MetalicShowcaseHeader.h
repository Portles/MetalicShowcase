//
//  Shaders.h
//
//
//  Created by Nizamet Özkan on 16.03.2024.
//

#ifndef Header_h
#define Header_h

#include <simd/simd.h>

struct Vertex {
    vector_float3 position;
    vector_float3 color;
};

struct CameraParameters {
    matrix_float4x4 view;
    matrix_float4x4 projection;
    vector_float3 position;
};

#endif /* Shaders_h */
