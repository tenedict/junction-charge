

// 음식에 따른 영양성분 알려줌
import SwiftUI

struct IngredientView: View {
    var response: String  // recommandView에서 전달받은 response
    @StateObject var viewModel = ContentViewModel()
    @State private var showDetailView = false
    
    // 2*N 그리드 레이아웃 정의
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            
            // 콤마로 구분된 문자열을 배열로 변환
            let items = response.components(separatedBy: ",")
            
            // LazyVGrid를 사용하여 2*N 버튼 배열 생성
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(items, id: \.self) { item in
                    Button(action: {
                        // 버튼 클릭 시 동작
                        let prompt = "\(item)에서 많이든 영양성분 중 임산부에게 도움되는 영양성분을 이름과 일일섭취량 기준 수치로 표현해줘. 수치는 1부터 10까지 정수 중에서 보여줘 예를 들면 단백질.7, 철분.3, 비타민A.5,(도움되는 이유) 이게 형식이야. 그리고 위의 영양소들이 도움되는 이유를 알려줘. 형식은 내가 알려준데로만 대답해."
                        viewModel.prompt = prompt
                        viewModel.fetchResponse()
                    }) {
                        Text(item)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.black)
                            .cornerRadius(8)
                    }
                }
            }
            .padding()
            
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            } else {
                NavigationLink(destination: DetailView(response: viewModel.response), isActive: $showDetailView) {
                    EmptyView()
                }
                .hidden()
            }
        }
        .onChange(of: viewModel.response) { newValue in
            if !newValue.isEmpty {
                showDetailView = true
            }
        }
        .padding()
    }
}
