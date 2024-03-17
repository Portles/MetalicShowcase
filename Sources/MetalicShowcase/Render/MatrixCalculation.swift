//
//  MatrixCalculation.swift
//  Transformations
//
//  Created by Nizamet Özkan on 9.12.2023.
//

import simd

final class MatrixCalculation {
    static func create() -> float4x4 {
        float4x4 (
            [1, 0, 0, 0],
            [0, 1, 0, 0],
            [0, 0, 1, 0],
            [0, 0, 0, 1]
        )
    }
    
    static func create(translation: simd_float3) -> float4x4 {
        float4x4 (
            [1,                 0,              0,              0],
            [0,                 1,              0,              0],
            [0,                 0,              1,              0],
            [translation[0],    translation[1], translation[2], 1]
        )
    }
    
    static func create(eulers: simd_float3) -> float4x4 {
        let gamma: Float = eulers[0] * .pi / 180.0
        let beta: Float = eulers[1] * .pi / 180.0
        let alpha: Float = eulers[2] * .pi / 180.0
        return createByZ(theta: alpha) * createByY(theta: beta) * createByX(theta: gamma)
    }
    
    static func createLook(eye: simd_float3, target: simd_float3, up: simd_float3) -> float4x4 {
        let forwards: simd_float3 = simd.normalize(target - eye)
        let right: simd_float3 = simd.normalize(simd.cross(up, forwards))
        let up2: simd_float3 = simd.normalize(simd.cross(forwards, right))
        
        
        return float4x4(
            [            right[0],             up2[0],             forwards[0],       0],
            [            right[1],             up2[1],             forwards[1],       0],
            [            right[2],             up2[2],             forwards[2],       0],
            [-simd.dot(right,eye), -simd.dot(up2,eye), -simd.dot(forwards,eye),       1]
        )
        
    }
    
    static func createPerspective(fovy: Float, aspect: Float, near: Float, far: Float) -> float4x4 {
        
        let A: Float = aspect * 1 / tan(fovy * .pi / 360.0)
        let B: Float = 1 / tan(fovy * .pi / 360.0)
        let C: Float = far / (far - near)
        let D: Float = 1
        let E: Float = -near * far / (far - near)
        
        return float4x4(
            [A, 0, 0, 0],
            [0, B, 0, 0],
            [0, 0, C, D],
            [0, 0, E, 0]
        )
    }
    
    static private func createByX(theta: Float) -> float4x4 {
        float4x4(
            [1,           0,          0, 0],
            [0,  cos(theta), sin(theta), 0],
            [0, -sin(theta), cos(theta), 0],
            [0,           0,          0, 1]
        )
    }
    
    static private func createByY(theta: Float) -> float4x4 {
        float4x4(
            [cos(theta), 0, -sin(theta), 0],
            [         0, 1,           0, 0],
            [sin(theta), 0,  cos(theta), 0],
            [         0, 0,           0, 1]
        )
    }
    
    static private func createByZ(theta: Float) -> float4x4 {
        float4x4(
            [ cos(theta), sin(theta), 0, 0],
            [-sin(theta), cos(theta), 0, 0],
            [          0,          0, 1, 0],
            [          0,          0, 0, 1]
        )
    }
}
