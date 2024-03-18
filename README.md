# MetalicShowcase
SwiftUI Component for show Wavefront objects with MetalApi.

Object & Camera eurlers and position can be manipulated with a single variable.  
Ready for basic showcase features like spin clockwise with desired speed.

(⌥ + left click) on Component to see all details

# Performance Tests
## By My Own Test Results
### Between MetalicShowcase(With textures) & SceneKit(Without textures)

-> CPU %10-%20 Improvement 👍  
-> Memory %10 Improvement 👍

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

Always use Color RGB for textures!
Name same object files with same name!  


    .
    ├── ...
    ├── object                    # Object directory
    │   ├── cube.obj              # Wavefront Object File (.obj)
    │   ├── cube.mtl              # Material Library File (.mtl)
    │   ├── cube.png              # Texture File (.png)
    └── ...

* [`MetalicShowcase`](https://github.com/Portles/MetalicShowcase/blob/9c79cfbef2dcb7393933d7582e27cf45295c27f0/Sources/MetalicShowcase/MetalicShowcase.swift#L11-L67) 
