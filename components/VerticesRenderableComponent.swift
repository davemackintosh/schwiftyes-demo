import MetalKit
import schwiftyes
import simd

final class VerticesRenderableComponent: schwiftyes.Component {
	// MARK: Lifecycle

	init(vertices: [SIMD4<Float>], device: MTLDevice) {
		self.vertexData = vertices

		self.vertexBuffer = device.makeBuffer(
			bytes: &self.vertexData,
			length: MemoryLayout<SIMD4<Float>>.stride * vertices.count,
			options: .storageModeShared
		)!
	}

	// MARK: Public

	public var vertexData: [SIMD4<Float>]
	public let vertexBuffer: MTLBuffer!
}
