import SwiftUI
import schwiftyes

struct ContentView: View {
    var body: some View {
        VStack {
            MetalView()
                .ignoresSafeArea(.all)
        }
    }
}
