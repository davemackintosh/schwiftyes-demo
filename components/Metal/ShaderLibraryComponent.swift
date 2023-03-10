import MetalKit
import schwiftyes

final class MetalShaderLibraryComponent: schwiftyes.Component {
	// MARK: Lifecycle

	// TODO: Add constants buffers and other required info.

	init(name: String, code: String, device: MTLDevice, view: MTKView) {
		guard let library = try? device.makeLibrary(source: code, options: nil) else {
			fatalError("failed to create library from code")
		}
		self.name = name
		self.code = code
		self.library = library
		self.pipelineDescriptor = MTLRenderPipelineDescriptor()
		pipelineDescriptor.colorAttachments[0].pixelFormat = view.colorPixelFormat
		pipelineDescriptor.vertexFunction = library.makeFunction(name: "vertex_main")!
		pipelineDescriptor.fragmentFunction = library.makeFunction(name: "fragment_main")!

		do {
			renderPipelineState = try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
		} catch {
			fatalError("Error while creating render pipeline state: \(error)")
		}
	}

	// MARK: Public

	public var name: String
	public var library: MTLLibrary
	public let pipelineDescriptor: MTLRenderPipelineDescriptor
	public let renderPipelineState: MTLRenderPipelineState

	// MARK: Private

	private var code: String
}
