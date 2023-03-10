import MetalKit
import schwiftyes
import SwiftUI

struct MetalView: UIViewRepresentable {
    // MARK: Internal

	init() {
		self.gameManager = GameManager()
	}

    func makeUIView(context _: Context) -> MTKView {
        return gameManager.view!
    }

    func updateUIView(_: MTKView, context _: Context) {}

    // MARK: Private
    
	private var gameManager: GameManager
}
