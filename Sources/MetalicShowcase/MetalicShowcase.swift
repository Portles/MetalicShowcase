//
//  MetallicView.swift
//  Metalim
//
//  Created by Nizamet Özkan on 9.03.2024.
//

import SwiftUI
import MetalKit

/**
     This component use metal framework and returns to some View.

     This component gets one value and return the some View.
     Name value named files must stored in project files.

     - parameter name: File's name.
     - returns: some View.

     # Notes: #
     1. First Parameter must be **String** type
     2. Must return in a body.
     3. Name parameter need to be same as the name of [name].ojb [name].mtl and [name].png file

     # Example #
    ```
     MetalicShowcase(name: "cube")
         .rotationDirection(.clockwise, speed: 1.0)
         .objectProperties(cubeProperties)
         .cameraProperties(cameraProperties)
     ```
    */
public struct MetalicShowcase: View {
    @StateObject var metalScene: MetalScene = MetalScene()

    var name: String
    @Environment(\.direction) var direction
    @Environment(\.speed) var speed
    @Environment(\.objectProperties) var objectProperties
    @Environment(\.cameraProperties) var cameraProperties

    public init(name: String) {
        self.name = name
    }

    public var body: some View {
        if direction == .none {
            MetallicView(name: name, metalScene: metalScene)
                .onChange(of: objectProperties, perform: { value in
                    metalScene.objectProperties = value
                })
                .onChange(of: cameraProperties, perform: { value in
                    metalScene.cameraProperties = value
                })
                .onAppear {
                    metalScene.objectProperties = objectProperties
                    metalScene.cameraProperties = cameraProperties
                }
        } else {
            MetallicView(name: name, metalScene: metalScene)
                .onAppear {
                    metalScene.direction = direction
                    metalScene.speed = speed
                }
        }
    }
}

public enum RotationDirection: CaseIterable {
    case none, clockwise, counterClockwise
}

#if os(iOS)

public struct MetallicView: UIViewRepresentable {
    let name: String

    var metalScene: MetalScene

    public func makeCoordinator() -> Renderer {
        Renderer(self, name: name, scene: metalScene)
    }

    public func makeUIView(context: UIViewRepresentableContext<Self>) -> MTKView {

        let mtkView = MTKView()
        mtkView.delegate = context.coordinator
        mtkView.preferredFramesPerSecond = 120
        mtkView.enableSetNeedsDisplay = true

        if let metalDevice = MTLCreateSystemDefaultDevice() {
            mtkView.device = metalDevice
        }

        mtkView.layer.isOpaque = false
        mtkView.framebufferOnly = false
        mtkView.drawableSize = mtkView.frame.size
        mtkView.isPaused = false
        mtkView.depthStencilPixelFormat = .depth32Float

        return mtkView
    }

    public func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<Self>) {

    }
}

#elseif os(macOS)

struct MetallicView: NSViewRepresentable {
    let name: String

    var metalScene: MetalScene

    func makeCoordinator() -> Renderer {
        Renderer(self, name: name, scene: metalScene)
    }

    func makeNSView(context: NSViewRepresentableContext<Self>) -> MTKView {

        let mtkView = MTKView()
        mtkView.delegate = context.coordinator
        mtkView.preferredFramesPerSecond = 120
        mtkView.enableSetNeedsDisplay = true

        if let metalDevice = MTLCreateSystemDefaultDevice() {
            mtkView.device = metalDevice
        }

        mtkView.layer!.isOpaque = false
        mtkView.framebufferOnly = false
        mtkView.drawableSize = mtkView.frame.size
        mtkView.isPaused = false
        mtkView.depthStencilPixelFormat = .depth32Float

        return mtkView
    }

    func updateNSView(_ nsView: NSViewType, context: NSViewRepresentableContext<Self>) {

    }
}

#endif
