//
//  EntitiyProperties.swift
//  Metalim
//
//  Created by Nizamet Özkan on 14.03.2024.
//

public struct EntitiyProperties: Equatable {
    public var position: SIMD3<Float> = [0.0, 0.0, 0.0]
    public var eulers: SIMD3<Float> = [0.0, 0.0, 0.0]

    public init(position: SIMD3<Float> = [0.0, 0.0, 0.0], eulers: SIMD3<Float> = [0.0, 0.0, 0.0]) {
        self.position = position
        self.eulers = eulers
    }
}
