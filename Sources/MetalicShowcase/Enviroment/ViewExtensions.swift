//
//  ViewExtensions.swift
//  Metalim
//
//  Created by Nizamet Özkan on 13.03.2024.
//

import SwiftUI

public extension View {
    func rotationDirection(_ direction: RotationDirection, speed: Float) -> some View {
        self.environment(\EnvironmentValues.direction, direction).environment(\EnvironmentValues.speed, speed)
    }

    func objectProperties(_ properties: EntitiyProperties) -> some View {
        self.environment(\EnvironmentValues.objectProperties, properties)
    }

    func cameraProperties(_ properties: EntitiyProperties) -> some View {
        self.environment(\EnvironmentValues.cameraProperties, properties)
    }
}
