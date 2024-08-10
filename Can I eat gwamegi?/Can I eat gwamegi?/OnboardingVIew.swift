import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    private let totalPages = 3
    
    var body: some View {
        TabView(selection: $currentPage) {
            VStack {
                Spacer()
                Text("변화하는 몸 상태를\n체크해요")
                    .font(
                        Font.custom("Apple SD Gothic Neo", size: 22)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.29, green: 0.26, blue: 0.23))
                Spacer()
                
                // 다음 버튼
                Button(action: {
                    if currentPage < totalPages - 1 {
                        currentPage += 1
                    }
                }) {
                    HStack(alignment: .center, spacing: 10) {
                        Spacer()
                        Text("다음")
                            .font(Font.custom("Apple SD Gothic Neo", size: 18))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.horizontal, 140)
                    .padding(.vertical, 11)
                    .frame(width: 353, height: 55, alignment: .center)
                    .background(Color(red: 0.29, green: 0.26, blue: 0.23))
                    .cornerRadius(32)
                }
                .padding(.bottom, 30) // 버튼과 페이지 하단 사이의 간격
            }
            .padding()
            .background(Color.white)
            .tag(0)
            
            VStack {
                Spacer()
                Text("오늘의 상태에 따라\n특산물 추천을 받아요")
                    .font(
                        Font.custom("Apple SD Gothic Neo", size: 22)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.29, green: 0.26, blue: 0.23))
                Spacer()
                
                // 다음 버튼
                Button(action: {
                    if currentPage < totalPages - 1 {
                        currentPage += 1
                    }
                }) {
                    HStack(alignment: .center, spacing: 10) {
                        Spacer()
                        Text("다음")
                            .font(Font.custom("Apple SD Gothic Neo", size: 18))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.horizontal, 140)
                    .padding(.vertical, 11)
                    .frame(width: 353, height: 55, alignment: .center)
                    .background(Color(red: 0.29, green: 0.26, blue: 0.23))
                    .cornerRadius(32)
                }
                .padding(.bottom, 30) // 버튼과 페이지 하단 사이의 간격
            }
            .padding()
            .background(Color.white)
            .tag(1)
            
            VStack {
                Spacer()
                Text("신선한 특산물을 챙겨먹고\n수달을 통해 변화를 관찰해요")
                    .font(
                        Font.custom("Apple SD Gothic Neo", size: 22)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.29, green: 0.26, blue: 0.23))
                Spacer()
                
                // 마지막 버튼
                Button(action: {
                    // 액션을 추가하여 온보딩 완료 후 이동할 페이지를 설정할 수 있습니다.
                }) {
                    HStack(alignment: .center, spacing: 10) {
                        Spacer()
                        Text("다음")
                            .font(Font.custom("Apple SD Gothic Neo", size: 18))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.horizontal, 140)
                    .padding(.vertical, 11)
                    .frame(width: 353, height: 55, alignment: .center)
                    .background(Color(red: 0.29, green: 0.26, blue: 0.23))
                    .cornerRadius(32)
                }
                .padding(.bottom, 30) // 버튼과 페이지 하단 사이의 간격
            }
            .padding()
            .background(Color.white)
            .tag(2)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
