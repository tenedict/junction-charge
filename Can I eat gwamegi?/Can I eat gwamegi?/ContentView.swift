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
    @State private var userInput: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter your question", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                // "안녕하세요" 추가하여 ViewModel의 prompt에 설정
                viewModel.prompt = userInput + "이 음식이 임산부에게 안좋은 성분이 있는지 성분을 나열해줘. 말많이 하지말고. 그리고 그 안좋은 성분을 중화해주는 음식을 나열해줘"
                viewModel.fetchResponse()
            }) {
                Text("Send")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            } else {
                Text(viewModel.response)
                    .padding()
            }
        }
        .padding()
    }
}
