//
//  ObjectEntity.swift
//  Metalim
//
//  Created by Nizamet Özkan on 11.03.2024.
//

import simd

final class ObjectEntity: EntityProtocol {
    var properties: EntitiyProperties

    var model: matrix_float4x4?

    init(properties: EntitiyProperties = EntitiyProperties(position: [0.0, 0.0, 0.0], eulers: [0.0, 0.0, 0.0])) {
        self.properties = properties
    }

    func setProperties(properties: EntitiyProperties) {
        self.properties = properties
        update()
    }

    func update() {
        model = MatrixCalculation.create(eulers: properties.eulers)
        model = MatrixCalculation.create(translation: properties.position) * model!
    }
}
