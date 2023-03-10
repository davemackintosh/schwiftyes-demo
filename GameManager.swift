import MetalKit
import schwiftyes

final class GameManager: NSObject, MTKViewDelegate {
	// MARK: Lifecycle

	override init() {
		ecs = schwiftyes.ECS()

		super.init()
		print("GAME MANAGER INIT")

		ecs.registerComponent(MetalDeviceComponent.self)
		ecs.registerComponent(MetalShaderLibraryComponent.self)
		ecs.registerComponent(VerticesRenderableComponent.self)

		// Frame start must come before any renderable systems.
		ecs.registerSystem(MetalRendererFrameStartSystem.self)
		ecs.registerSystem(VerticesRendererSystem.self)
		// Frame end must come after any renderable systems.
		ecs.registerSystem(MetalRendererFrameEndSystem.self)

		// We need to set up the device for most other components
		// to work.
		let metalDeviceEntity = ecs.createEntity()
		var device = MetalDeviceComponent()
		view = device.view
		ecs.addComponent(&device, metalDeviceEntity)

		if let view = view {
			view.delegate = self
		}

		let shaderEntity = ecs.createEntity()
		var shaders = MetalShaderLibraryComponent(
			name: "default",
			code: defaultShader,
			device: device.device,
			view: device.view
		)
		ecs.addComponent(&shaders, shaderEntity)

		let triangleEntity = ecs.createEntity()
		var triangle = VerticesRenderableComponent(
			vertices: [
				SIMD4<Float>(arrayLiteral: -1.0, -1.0, 0.0, 1.0),
				SIMD4<Float>(arrayLiteral: 1.0, -1.0, 0.0, 1.0),
				SIMD4<Float>(arrayLiteral: 0.0, 1.0, 0.0, 1.0)
			],
			device: device.device
		)
		ecs.addComponent(&triangle, triangleEntity)

//		registerSystems()
	}

	// MARK: Public

	public var view: MTKView?
	public private(set) var isRunning = false

	// MARK: Internal

	func registerComponents() {
		print("REGISTERING COMPONENTS")
	}

	func registerSystems() {
		print("REGISTERING GAME SYSTEMS")
	}

	func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}

	func draw(in view: MTKView) {
		ecs.update(dt: Double(1 / Float(view.preferredFramesPerSecond)))
	}

	// MARK: Private

	private var ecs: schwiftyes.ECS
}
