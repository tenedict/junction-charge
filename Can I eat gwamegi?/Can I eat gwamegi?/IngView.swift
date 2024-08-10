import SwiftUI
import Lottie

struct IngView: View {
    var body: some View {
        VStack() {
            HStack {
                Text("엄마의 상태에 맞는 음식을 \n고르는 중이에요")
                    .font(.system(size: 22, weight: .heavy))
                    .foregroundStyle(Color(red: 0.29, green: 0.26, blue: 0.23))
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .padding()
            
            Spacer()
            
            LottieView(name: "loading")
                .frame(width: 300, height: 300)
            
            Text("입덧을 해요")
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(Color(red: 0.29, green: 0.26, blue: 0.23))
                .multilineTextAlignment(.center)
            
            Spacer(minLength: 250)
        }
        .background(Color.customWhite)
    }
}

#Preview {
    IngView()
}
