import SwiftUI

struct EnterinformationView: View {
    @State private var selectedMonth: Int = 1
    
    var body: some View {
        TabView {
            VStack(alignment: .leading) {
                HStack {
                    Text("어서오세요!")
                        .font(
                            Font.custom("Apple SD Gothic Neo", size: 22)
                                .weight(.heavy)
                        )
                        .foregroundColor(Color(red: 0.12, green: 0.11, blue: 0.11))
                    Spacer()
                }
                Text("본 서비스는 경상북도 특산물과 함께합니다")
                    .font(
                        Font.custom("Apple SD Gothic Neo", size: 17)
                            .weight(.semibold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.13, green: 0.11, blue: 0.1))
                    .padding(.top, 8)
                Spacer()
            }
            .padding()
            .tabItem {
                Text("첫 번째 페이지")
            }

            VStack(alignment: .leading) {
                HStack {
                    Text("개월수를 알려주세요")
                        .font(
                            Font.custom("Apple SD Gothic Neo", size: 22)
                                .weight(.heavy)
                        )
                        .foregroundColor(Color(red: 0.12, green: 0.11, blue: 0.11))
                    Spacer()
                }

                // 애플 기본 스타일의 선택 버튼
                Menu {
                    // 개월 수 선택지
                    ForEach(1..<11) { month in
                        Button("\(month)개월") {
                            selectedMonth = month
                        }
                    }
                } label: {
                    HStack(alignment: .center, spacing: 8) {
                        Text("선택 버튼")
                            .font(Font.custom("Apple SD Gothic Neo", size: 18))
                            .foregroundColor(.black)
                        Spacer()
                        Text("\(selectedMonth)개월")
                            .font(Font.custom("Apple SD Gothic Neo", size: 18))
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .frame(height: 52)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                }

                Spacer()
            }
            .padding()
            .tabItem {
                Text("두 번째 페이지")
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
}

struct EnterinformationView_Previews: PreviewProvider {
    static var previews: some View {
        EnterinformationView()
    }
}
