import Foundation
import Combine

class ContentViewModel: ObservableObject {
    @Published var prompt: String = ""
    @Published var response: String = ""
    @Published var isLoading: Bool = false
    
    private var apiService = APIService.shared
    private var cancellables = Set<AnyCancellable>()
    
    func fetchResponse() {
        isLoading = true
        
        apiService.fetchResponse(prompt: prompt)
            .receive(on: DispatchQueue.main) // 메인 스레드에서 UI 업데이트
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.response = "Error: \(error.localizedDescription)"
                }
                self.isLoading = false
            }, receiveValue: { result in
                self.response = result
            })
            .store(in: &cancellables)
    }
}



import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
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
