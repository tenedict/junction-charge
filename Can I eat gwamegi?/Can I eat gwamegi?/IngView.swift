import SwiftUI
import Lottie

struct IngView: View {
    var body: some View {
        VStack() {
            HStack {
                Text("Choosing food that\nmatches your condition.")
                    .font(.system(size: 22, weight: .heavy))
                    .foregroundStyle(Color(red: 0.29, green: 0.26, blue: 0.23))
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .padding()
            
            Spacer()
            
            LottieView(name: "loading")
                .frame(width: 300, height: 300)
            
            Text("I have morning sickness.")
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
