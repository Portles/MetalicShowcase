//
//  File.swift
//  
//
//  Created by Nizamet Özkan on 18.03.2024.
//

import MetalKit

final class StencilBuilder {
    static func BuildStencil(metalDevice: MTLDevice) -> MTLDepthStencilState {
        
        let depthStencilDescriptor: MTLDepthStencilDescriptor = MTLDepthStencilDescriptor()
        depthStencilDescriptor.depthCompareFunction = .less
        depthStencilDescriptor.isDepthWriteEnabled = true
        
        return metalDevice.makeDepthStencilState(descriptor: depthStencilDescriptor)!
    }
}
