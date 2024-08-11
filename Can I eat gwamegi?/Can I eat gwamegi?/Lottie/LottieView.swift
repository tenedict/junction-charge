import SwiftUI
import Lottie

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

#Preview {
    LottieView(name: "loading")
}
