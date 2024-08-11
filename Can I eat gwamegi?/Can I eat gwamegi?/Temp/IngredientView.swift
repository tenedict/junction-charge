import SwiftUI

struct IngredientView: View {
    var response: String  // recommandView에서 전달받은 response
    @State private var selectedItem: String? = nil
    @State private var showDetailView = false
    
    // 2*N 그리드 레이아웃 정의
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                
                // 콤마로 구분된 문자열을 배열로 변환
                let items = response.components(separatedBy: ",")
                
                // LazyVGrid를 사용하여 2*N 버튼 배열 생성
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(items, id: \.self) { item in
                        Button(action: {
                            // 버튼 클릭 시 동작
                            selectedItem = item
                            showDetailView = true
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
                
                // NavigationLink를 사용하여 DetailView로 이동
                NavigationLink(
                    destination: IngredientDetailView(response: selectedItem ?? ""),
                    isActive: $showDetailView
                ) {
                    EmptyView()
                }
                .hidden()
            }
            .padding()
        }
    }
}
