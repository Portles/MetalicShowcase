//
//  Renderer.swift
//  Metalim
//
//  Created by Nizamet Özkan on 10.03.2024.
//

import MetalKit
import MetalicShowcaseHeader

final public class Renderer: NSObject {
    private var parent: MetallicView
    private var metalDevice: MTLDevice!
    private var metalCommandQueue: MTLCommandQueue!
    
    private let meshAllocator: MTKMeshBufferAllocator
    private let materialLoader: MTKTextureLoader
    
    private let pipelineState: MTLRenderPipelineState
    private let depthStencilState: MTLDepthStencilState
    
    private var scene: MetalScene
    private var objectMesh: ObjMesh
    private let material: Material
    
    private var cameraData: CameraParameters = CameraParameters()
    
    init(_ parent: MetallicView, name: String, scene: MetalScene) {
        
        self.parent = parent
        if let metalDevice: MTLDevice = MTLCreateSystemDefaultDevice() {
            self.metalDevice = metalDevice
        }
        self.metalCommandQueue = metalDevice.makeCommandQueue()
        
        self.meshAllocator = MTKMeshBufferAllocator(device: metalDevice)
        self.materialLoader = MTKTextureLoader(device: metalDevice)
        
        self.objectMesh = ObjMesh(device: metalDevice, allocator: meshAllocator, filename: name)
        self.material = Material(device: metalDevice, allocator: materialLoader, filename: name)
        
        let library: MTLLibrary = try! metalDevice.makeDefaultLibrary(bundle: Bundle.module)
        
        pipelineState = PipelineBuilder.BuildPipeline(metalDevice: metalDevice, library: library, vsEntry: "vertexShader", fsEntry: "fragmentShader", vertexDescriptor: objectMesh.metalMesh.vertexDescriptor)
        
        depthStencilState = StencilBuilder.BuildStencil(metalDevice: metalDevice)
        
        self.scene = scene
        
        super.init()
    }
}

// MARK: - MTKViewDelegate Extensions
extension Renderer: MTKViewDelegate {
    
    public func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    public func draw(in view: MTKView) {
        
        scene.updateView()
        
        guard let drawable: CAMetalDrawable = view.currentDrawable else {
            return
        }
        
        guard let commandBuffer: MTLCommandBuffer = metalCommandQueue.makeCommandBuffer() else {
            return
        }
        
        guard let renderPassDescriptor: MTLRenderPassDescriptor = view.currentRenderPassDescriptor else {
            return
        }
        
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(0, 0.0, 0.0, 0.0)
        renderPassDescriptor.colorAttachments[0].loadAction = .clear
        renderPassDescriptor.colorAttachments[0].storeAction = .store
        
        guard let renderEncoder: MTLRenderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) else {
            return
        }
        renderEncoder.setRenderPipelineState(pipelineState)
        renderEncoder.setDepthStencilState(depthStencilState)
        
        drawCamera(renderEncoder)
        
        drawObject(renderEncoder)
        
        renderEncoder.endEncoding()
        
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}

// MARK: - Draw Extensions
private extension Renderer {
    private func drawCamera(_ renderEncoder: MTLRenderCommandEncoder) {
        cameraData.view = MatrixCalculation.createLook(eye: scene.camera.properties.position, target: scene.camera.properties.position + scene.camera.forwards!, up: scene.camera.up!)
        cameraData.projection = MatrixCalculation.createPerspective(fovy: 45, aspect: 800/600, near: 0.1, far: 20)
        renderEncoder.setVertexBytes(&cameraData, length: MemoryLayout<CameraParameters>.stride, index: 2)
    }
    
    private func drawObject(_ renderEncoder: MTLRenderCommandEncoder) {
        renderEncoder.setVertexBuffer(objectMesh.metalMesh.vertexBuffers[0].buffer, offset: 0, index: 0)
        renderEncoder.setFragmentTexture(material.texture, index: 0)
        renderEncoder.setFragmentSamplerState(material.sampler, index: 0)
        
        var modelMatrix: matrix_float4x4 = MatrixCalculation.create(eulers: scene.object.properties.eulers)
        modelMatrix = MatrixCalculation.create(translation: scene.object.properties.position) * modelMatrix;
        renderEncoder.setVertexBytes(&modelMatrix, length: MemoryLayout<matrix_float4x4>.stride, index: 1)
        
        for submesh in objectMesh.metalMesh.submeshes {
            renderEncoder.drawIndexedPrimitives(type: .triangle, indexCount: submesh.indexCount, indexType: submesh.indexType, indexBuffer: submesh.indexBuffer.buffer, indexBufferOffset: submesh.indexBuffer.offset)
        }
    }
}
