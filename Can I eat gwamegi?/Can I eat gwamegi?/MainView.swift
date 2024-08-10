import SwiftUI

enum ViewCase {
    case hiHaedal
    case select
    case ing
}

struct MainView: View {
    let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
    @State private var viewCase: ViewCase = .hiHaedal
    
    @ViewBuilder
    func viewSelect() -> some View {
        switch(launchedBefore) {
        case false:
            OnboardingView()
        case true:
            switch(viewCase) {
            case .hiHaedal:
                HiHaedalView(viewCase: $viewCase)
            case .select:
                SelectView(viewCase: $viewCase)
            case .ing:
                IngView(viewCase: $viewCase)
            }
        }
    }
    
    var body: some View {
        viewSelect()
    }
}

#Preview {
    MainView()
}
