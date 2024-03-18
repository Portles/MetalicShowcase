//
//  Material.swift
//  Metalim
//
//  Created by Nizamet Özkan on 9.12.2023.
//

import MetalKit

final class Material {
    let texture: MTLTexture
    let sampler: MTLSamplerState
    private let samplerDescriptor: MTLSamplerDescriptor = MTLSamplerDescriptor()

    init(device: MTLDevice, allocator: MTKTextureLoader, filename: String) {

        let options: [MTKTextureLoader.Option: Any] = [
            .SRGB: false,
            .generateMipmaps: true
        ]

        guard let materialURL: URL = Bundle.main.url(forResource: filename, withExtension: "png") else {
            fatalError()
        }

        do {
            texture = try allocator.newTexture(URL: materialURL, options: options)
        } catch {
            fatalError("Couldn't load mesh")
        }

        samplerDescriptor.sAddressMode = .repeat
        samplerDescriptor.tAddressMode = .repeat
        samplerDescriptor.magFilter = .linear
        samplerDescriptor.minFilter = .nearest
        samplerDescriptor.mipFilter = .linear
        samplerDescriptor.maxAnisotropy = 8

        sampler = device.makeSamplerState(descriptor: samplerDescriptor)!
    }
}
