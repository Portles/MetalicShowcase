//
//  EnviromentalExtensions.swift
//  Metalim
//
//  Created by Nizamet Özkan on 12.03.2024.
//

import SwiftUI

extension EnvironmentValues {
    var direction: RotationDirection {
        get { self[DirectionKey.self] }
        set { self[DirectionKey.self] = newValue }
    }

    var speed: Float {
        get { self[SpeedKey.self] }
        set { self[SpeedKey.self] = newValue }
    }

    var objectProperties: EntitiyProperties {
        get { self[ObjectPropertiesKey.self] }
        set { self[ObjectPropertiesKey.self] = newValue }
    }

    var cameraProperties: EntitiyProperties {
        get { self[CameraPropertiesKey.self] }
        set { self[CameraPropertiesKey.self] = newValue }
    }
}

struct DirectionKey: EnvironmentKey {
    static var defaultValue: RotationDirection = RotationDirection.none
}

struct SpeedKey: EnvironmentKey {
    static var defaultValue: Float = 0.0
}

struct ObjectPropertiesKey: EnvironmentKey {
    static var defaultValue: EntitiyProperties = EntitiyProperties(position: [0.0, 0.0, 0.0], eulers: [0.0, 0.0, 0.0])
}

struct CameraPropertiesKey: EnvironmentKey {
    static var defaultValue: EntitiyProperties = EntitiyProperties(position: [-6.0, 6.0, 4.0], eulers: [0.0, 110.0, -45.0])
}
