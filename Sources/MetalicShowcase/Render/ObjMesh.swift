//
//  ObjMesh.swift
//  Metalim
//
//  Created by Nizamet Özkan on 8.12.2023.
//

import MetalKit

final class ObjMesh {
    let modelIOMesh: MDLMesh
    let metalMesh: MTKMesh
    private let vertexDescriptor: MTLVertexDescriptor = MTLVertexDescriptor()
    private var offset: Int = 0

    init(device: MTLDevice, allocator: MTKMeshBufferAllocator, filename: String) {

        guard let meshUrl: URL = Bundle.main.url(forResource: filename, withExtension: "obj") else {
            fatalError()
        }

        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].offset = offset
        vertexDescriptor.attributes[0].bufferIndex = 0
        offset += MemoryLayout<SIMD3<Float>>.stride

        vertexDescriptor.attributes[1].format = .float2
        vertexDescriptor.attributes[1].offset = offset
        vertexDescriptor.attributes[1].bufferIndex = 0
        offset += MemoryLayout<SIMD2<Float>>.stride

        vertexDescriptor.layouts[0].stride = offset

        let meshDescriptor: MDLVertexDescriptor = MTKModelIOVertexDescriptorFromMetal(vertexDescriptor)
        (meshDescriptor.attributes[0] as! MDLVertexAttribute).name = MDLVertexAttributePosition
        (meshDescriptor.attributes[1] as! MDLVertexAttribute).name = MDLVertexAttributeTextureCoordinate

        let asset: MDLAsset = MDLAsset(url: meshUrl, vertexDescriptor: meshDescriptor, bufferAllocator: allocator)

        self.modelIOMesh = asset.childObjects(of: MDLMesh.self).first as! MDLMesh
        do {
            metalMesh = try MTKMesh(mesh: self.modelIOMesh, device: device)
        } catch {
            fatalError()
        }
    }
}
