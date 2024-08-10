import SwiftUI
import Lottie

//배경색 바꿔주세요

struct IngView: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("엄마의 상태에 맞는 음식을 \n고르는 중이에요")
                    .font(
                        Font.custom("Apple SD Gothic Neo", size: 22)
                            .weight(.heavy)
                    )
                    .foregroundColor(Color(red: 0.29, green: 0.26, blue: 0.23))
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 24)
                    .padding(.top, 36)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()

            LottieView(name: "loading")
                .frame(width: 200, height: 200)
                .frame(maxWidth: .infinity, alignment: .center)
            Spacer()

            // 로티 애니메이션 바로 밑에 텍스트를 배치
            HStack(alignment: .center, spacing: 10) {
                Text("입덧을 해요")
                    .font(
                        Font.custom("Apple SD Gothic Neo", size: 17)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color(red: 1, green: 0.99, blue: 0.99))
            .cornerRadius(25)

            Spacer() // 하단 여백 확보를 위한 Spacer
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

struct LottieView: UIViewRepresentable {
    var name: String

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> some UIView {
        let view = UIView()

        let animationView = LottieAnimationView(name: name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<LottieView>) {
        // Update the view if needed
    }
}

struct IngView_Previews: PreviewProvider {
    static var previews: some View {
        IngView()
    }
}
