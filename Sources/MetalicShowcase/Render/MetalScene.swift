//
//  MetalScene.swift
//  Metalim
//
//  Created by Nizamet Özkan on 11.03.2024.
//

import Foundation

final class MetalScene: ObservableObject {
    @Published var camera: CameraEntity = CameraEntity()
    @Published var object: ObjectEntity = ObjectEntity()

    @Published var direction: RotationDirection = .none
    @Published var speed: Float = 0.0

    @Published var objectProperties: EntitiyProperties = EntitiyProperties(position: [0.0, 0.0, 0.0], eulers: [0.0, 0.0, 0.0])
    @Published var cameraProperties: EntitiyProperties = EntitiyProperties(position: [-6.0, 6.0, 4.0], eulers: [0.0, 0.0, 0.0])

    private let maxDegree: Float = 360

    init() {
        let newCamera: CameraEntity = CameraEntity()
        newCamera.setProperties(properties: cameraProperties)
        camera = newCamera

        let newObject: ObjectEntity = ObjectEntity()
        newObject.setProperties(properties: objectProperties)
        object = newObject
    }

    func updateView() {
        camera.setProperties(properties: cameraProperties)

        if direction == .clockwise {
            objectProperties.eulers.z += speed
            if objectProperties.eulers.z > maxDegree {
                objectProperties.eulers.z -= maxDegree
            }
        } else if direction == .counterClockwise {
            objectProperties.eulers.z -= speed
            if objectProperties.eulers.z < -maxDegree {
                objectProperties.eulers.z += maxDegree
            }
        }

        object.setProperties(properties: objectProperties)
    }
    
    func notifyViewChange() {
        self.objectWillChange.send()
    }

    func moveCamera(offset: CGSize) {
        let rightAmount: Float = Float(offset.width) / 1000
        let upAmount: Float = Float(offset.height) / 1000

        camera.stafe(rightAmount: rightAmount, upAmount: upAmount)
    }
}
