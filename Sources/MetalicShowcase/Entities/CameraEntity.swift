//
//  CameraEntity.swift
//  Metalim
//
//  Created by Nizamet Özkan on 11.03.2024.
//

import simd

final class CameraEntity: EntityProtocol {
    var properties: EntitiyProperties

    var forwards: vector_float3?
    var right: vector_float3?
    var up: vector_float3?
    var view: matrix_float4x4?

    init(properties: EntitiyProperties = EntitiyProperties(position: [-6.0, 6.0, 4.0], eulers: [0.0, 110.0, -45.0])) {
        self.properties = properties
    }

    func setProperties(properties: EntitiyProperties) {
        self.properties = properties
        update()
    }

    func stafe(rightAmount: Float, upAmount: Float) {
        properties.position = properties.position + rightAmount * right! + upAmount * up!

        let distance: Float = simd.length(properties.position)

        moveForwards(amount: distance - 10.0)
    }

    func moveForwards(amount: Float) {
        properties.position = properties.position + amount * forwards!
    }

    func update() {
        forwards = simd.normalize([0,0,0] - properties.position)

        let globalUp: vector_float3 = [0.0, 0.0, 1.0]

        right = simd.normalize(simd.cross(globalUp, forwards!))

        up = simd.normalize(simd.cross(forwards!, right!))

        view = MatrixCalculation.createLook(eye: properties.position, target: [0,0,0] + forwards!, up: up!)
    }
}
