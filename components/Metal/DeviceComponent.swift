import MetalKit
import schwiftyes

final class MetalDeviceComponent: schwiftyes.Component {
	// MARK: Lifecycle

	override init() {
		self.device = MTLCreateSystemDefaultDevice()!
		self.commandQueue = device.makeCommandQueue()!
		self.commandBuffer = commandQueue.makeCommandBuffer()
		self.view = MTKView()

		view.device = device
		view.clearColor = MTLClearColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
	}

	deinit {
		print("MetalDeviceComonent.deinit()")
	}

	// MARK: Public

	public let device: MTLDevice!
	public let view: MTKView
	public let commandQueue: MTLCommandQueue
	public var commandBuffer: MTLCommandBuffer!
	public var commandEncoder: MTLRenderCommandEncoder!
	public var hasCommandEncoder = false
}
