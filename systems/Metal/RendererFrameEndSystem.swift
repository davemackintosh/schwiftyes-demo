import schwiftyes
import Foundation

final class MetalRendererFrameEndSystem: schwiftyes.System {
    override var signature: Signature {
        Signature.from([
            MetalDeviceComponent.self,
            
        ])
    }
    
    override func update(dt _: CFTimeInterval) {
        for entity in entities {
            guard let device = componentManager.getComponent(entity, MetalDeviceComponent.self) else {
                fatalError("no metal device component")
            }

			if device.view.currentDrawable == nil {
				print("no drawable")
				continue
			}

			if device.commandEncoder == nil {
				print("no command encoder")
				continue
			}

			if device.commandBuffer == nil {
				print("no command buffer")
				continue
			}
            
            if let drawable = device.view.currentDrawable, let commandEncoder = device.commandEncoder, let commandBuffer = device.commandBuffer {
				if device.hasCommandEncoder {
					commandEncoder.endEncoding()
					commandBuffer.present(drawable)
					commandBuffer.commit()
				}
			} else {
				print("missing data to print")
			}
        }
    }
}
