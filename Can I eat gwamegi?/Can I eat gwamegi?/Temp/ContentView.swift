import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var viewModel: ContentViewModel
    
    var body: some View {
        VStack {
            TextField("Enter your question", text: $viewModel.prompt, onCommit: viewModel.fetchResponse)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            if viewModel.isLoading {
                ProgressView()
            } else {
                Text(viewModel.response)
                    .padding()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
