import schwiftyes
import Foundation
import MetalKit

final class VerticesRendererSystem: schwiftyes.System {
    override var signature: Signature {
        Signature.from([
            MetalDeviceComponent.self,
			MetalShaderLibraryComponent.self,
            VerticesRenderableComponent.self,
        ])
    }

    override func update(dt _: CFTimeInterval) {
        guard let deviceEntity = entities.first(where: { entity in
			componentManager.getComponent(entity, MetalDeviceComponent.self) != nil
        }) else {
			print("no device entity registered to draw to")
			return
        }

        guard let device = componentManager.getComponent(deviceEntity, MetalDeviceComponent.self) else {
			print("no device component registered to device entity to draw to. somehow")
			return
        }

        guard let shaderEntity = entities.first(where: { entity in
			componentManager.getComponent(entity, MetalShaderLibraryComponent.self) != nil
        }) else {
			print("no shader entity registered to draw to")
			return
        }

        guard let shader = componentManager.getComponent(shaderEntity, MetalShaderLibraryComponent.self) else {
			print("no shader component registered to shader entity to draw to. somehow")
			return
        }

		let renderables = entities.compactMap({ entity in
			componentManager.getComponent(entity, VerticesRenderableComponent.self)
		})

		for component in renderables {
			if let commandEncoder = device.commandEncoder {
				commandEncoder.setRenderPipelineState(shader.renderPipelineState)
				commandEncoder.setVertexBuffer(component.vertexBuffer, offset: 0, index: 0)
				commandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3)
			}
        }
    }
}

