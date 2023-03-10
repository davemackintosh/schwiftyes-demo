import Foundation
import schwiftyes

final class MetalRendererFrameStartSystem: schwiftyes.System {
	override var signature: Signature {
		Signature.from([
			MetalDeviceComponent.self,
		])
	}

	override func update(dt _: CFTimeInterval) {
		var device: MetalDeviceComponent
		do {
			device = try componentManager.getResolvedComponent(entities: entities, component: MetalDeviceComponent.self)
		} catch {
			print("didn't find a metal device to begin a frame from. exiting")
			return
		}

		if let rdp = device.view.currentRenderPassDescriptor {
			guard let commandBuffer = device.commandQueue.makeCommandBuffer() else {
				print("failed to create command buffer")
				return
			}

			device.commandBuffer = commandBuffer
			device.commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: rdp)!
			device.hasCommandEncoder = true
		}
	}
}
