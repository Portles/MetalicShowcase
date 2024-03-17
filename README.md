# MetalicShowcase
SwiftUI Component for show Waveform objects with MetalApi.

Object & Camera eurlers and position can be manipulated by a signle variable.
Ready for basic showcase features like spining clockwise with desired speed.

(⌥ + left click) on Component to see all details

# Example
```swift
MetalicShowcase(name: "cube")
    .rotationDirection(.clockwise, speed: 1.0)
    .objectProperties(cubeProperties)
    .cameraProperties(cameraProperties)
```

## Installation

### For Xcode Projects

File > Swift Packages > Add Package Dependency: https://github.com/Portles/MetalicShowcase

## Usage
    .
    ├── ...
    ├── object                    # Object directory (alternatively `obj`)
    │   ├── cube.obj              # Waveform Object File (.obj)
    │   ├── cube.mtl              # Material Library File (.mtl)
    │   ├── cube.png              # Texture File (.png)
    └── ...

* [`MetalicShowcase`](https://github.com/Portles/MetalicShowcase/blob/9c79cfbef2dcb7393933d7582e27cf45295c27f0/Sources/MetalicShowcase/MetalicShowcase.swift#L11-L67) 
