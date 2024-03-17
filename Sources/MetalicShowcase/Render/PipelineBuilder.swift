//
//  PipelineBuilder.swift
//  Metalim
//
//  Created by Nizamet Özkan on 23.12.2023.
//

import MetalKit

final class PipelineBuilder {
    static func BuildPipeline(metalDevice: MTLDevice, library: MTLLibrary, vsEntry: String, fsEntry: String, vertexDescriptor: MDLVertexDescriptor) -> MTLRenderPipelineState {

        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        let library = metalDevice.makeDefaultLibrary()
        pipelineDescriptor.vertexFunction = library?.makeFunction(name: vsEntry)
        pipelineDescriptor.fragmentFunction = library?.makeFunction(name: fsEntry)
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        pipelineDescriptor.colorAttachments[0].isBlendingEnabled = true
        pipelineDescriptor.colorAttachments[0].alphaBlendOperation = .add
        pipelineDescriptor.colorAttachments[0].rgbBlendOperation = .add
        pipelineDescriptor.colorAttachments[0].destinationRGBBlendFactor = .oneMinusSourceAlpha
        pipelineDescriptor.colorAttachments[0].destinationAlphaBlendFactor = .oneMinusSourceAlpha
        pipelineDescriptor.colorAttachments[0].sourceRGBBlendFactor = .sourceAlpha
        pipelineDescriptor.colorAttachments[0].sourceAlphaBlendFactor = .sourceAlpha
        pipelineDescriptor.vertexDescriptor = MTKMetalVertexDescriptorFromModelIO(vertexDescriptor)
        pipelineDescriptor.depthAttachmentPixelFormat = .depth32Float

        do {
            return try metalDevice.makeRenderPipelineState(descriptor: pipelineDescriptor)
        } catch {
            fatalError()
        }
    }
}
