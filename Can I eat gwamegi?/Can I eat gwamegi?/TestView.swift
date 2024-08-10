import SwiftUI

struct TestView: View {
    @State private var showSelectView = false
    @State private var riceOffset: CGFloat = -60
    @State private var eggOffset: CGFloat = 60
    @State private var grapsOffset: CGFloat = 60 // Graps 이미지의 초기 오프셋
    @State private var animateRice = false
    @State private var animateEgg = false
    @State private var animateGraps = false
    
    var body: some View {
        VStack {
            // 상단에 배치할 BuoyantlyView
            BuoyantlyView()
                .padding(.top, 20) // 상단 여백 추가, 필요에 따라 조절 가능
            
            Spacer()
            // 말풍선과 작은 이미지 추가
            VStack {
                
                HStack(alignment: .center, spacing: 10) {
                    
                    Text("Which of these would I like to eat?")
                        .font(
                            Font.custom("Apple SD Gothic Neo", size: 16)
                                .weight(.bold)
                            
                        )
                        .foregroundColor(.white)
                }
                .padding(16)
                .background(Color(red: 0.69, green: 0.64, blue: 0.61))
                .cornerRadius(26)
                
                
                // 작은 원형 이미지 추가
                Image("Ellipse 10")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .background(Color(red: 0.69, green: 0.64, blue: 0.61))
                    .clipShape(Circle())
                
                // 더 작은 원형 이미지 추가
                Image("Ellipse 11")
                    .resizable()
                    .frame(width: 6, height: 6)
                    .background(Color(red: 0.69, green: 0.64, blue: 0.61))
                    .clipShape(Circle())
            }
            
            // 이미지를 겹치는 ZStack
            ZStack {
                // Haedal 이미지
                Image("Haedal") // 프로젝트에 추가한 Haedal 이미지 파일 이름을 사용
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                
                Spacer()
                
                // Rice 이미지
                Image("rice") // 프로젝트에 추가한 Rice 이미지 파일 이름을 사용
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100) // Rice 이미지 크기 조절
                    .padding(0) // Padding으로 이미지의 외부 여백 조절
                    .background(Color(red: 0.97, green: 0.91, blue: 0.85))
                    .cornerRadius(83)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .inset(by: 0.17)
                            .stroke(Color(red: 0.83, green: 0.75, blue: 0.77), lineWidth: 0.33)
                    )
                    .offset(x:-95, y: riceOffset - 190) // 애니메이션 위치 조정: y 값 감소
                    .onAppear {
                        startRiceAnimation()
                    }
                
                // Egg 이미지
                Image("egg") // 프로젝트에 추가한 Egg 이미지 파일 이름을 사용
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 87, height: 87) // Egg 이미지 크기 조절
                    .padding(0) // Padding으로 이미지의 외부 여백 조절
                    .background(Color(red: 0.97, green: 0.91, blue: 0.85))
                    .cornerRadius(50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .inset(by: 0.17)
                            .stroke(Color(red: 0.83, green: 0.75, blue: 0.77), lineWidth: 0.33)
                    )
                    .offset(x: 130, y: eggOffset - 75) // 애니메이션 위치
                    .onAppear {
                        startEggAnimation()
                    }
                
                // Graps 이미지
                Image("graps") // 프로젝트에 추가한 Graps 이미지 파일 이름을 사용
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100) // Graps 이미지 크기 조절
                    .padding(0) // Padding으로 이미지의 외부 여백 조절
                    .background(Color(red: 0.97, green: 0.91, blue: 0.85))
                    .cornerRadius(50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .inset(by: 0.17)
                            .stroke(Color(red: 0.83, green: 0.75, blue: 0.77), lineWidth: 0.33)
                    )
                    .offset(x: -90, y: grapsOffset - -100) // 애니메이션 위치
                    .onAppear {
                        startGrapsAnimation()
                    }
            }
            
            Spacer()
            
            // 하단에 배치할 버튼
            Button(action: {
                showSelectView = true
            }) {
                HStack {
                    Spacer()
                    Text("Select symptoms") // 버튼에 표시할 텍스트
                        .font(
                            Font.custom("Apple SD Gothic Neo", size: 18)
                                .weight(.bold)
                        )
                        .foregroundColor(.white)
                        .padding(.horizontal, 0)
                        .padding(.vertical, 11)
                        .frame(width: 353, height: 55, alignment: .center)
                        .background(Color(red: 0.99, green: 0.58, blue: 0.34))
                        .cornerRadius(32)
                    Spacer()
                }
            }
            .padding(.bottom, 20) // 버튼과 하단 사이에 공간 추가
        }
    }
    
    private func startRiceAnimation() {
        withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
            riceOffset = -80 // 애니메이션 이동 범위 설정
        }
    }
    
    private func startEggAnimation() {
        withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
            eggOffset = 80 // 애니메이션 이동 범위 설정
        }
    }
    
    private func startGrapsAnimation() {
        withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
            grapsOffset = 80 // 애니메이션 이동 범위 설정
        }
    }
}

struct BuoyantlyView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Text("Swelling")
                .font(
                    Font.custom("Apple SD Gothic Neo", size: 22)
                        .weight(.heavy)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.29, green: 0.26, blue: 0.23))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color(red: 0.99, green: 0.97, blue: 0.95))
        .cornerRadius(25)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
