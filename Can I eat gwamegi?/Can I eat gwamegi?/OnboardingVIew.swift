import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .gray
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                VStack {
                    Spacer()
                    
                    Image("onboarding1")
                        .resizable()
                        .frame(width: 393, height: 399)
                    
                    Spacer()
                    
                    Text("Check the changes \nin your body condition\n")
                        .font(.system(size: 22, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color(red: 0.29, green: 0.26, blue: 0.23))
                    
                    Spacer()
                }
                .padding()
                .tag(0)
                
                VStack {
                    Spacer()
                    
                    Image("onboarding2")
                        .resizable()
                        .frame(width: 393, height: 399)
                    
                    Spacer()
                    
                    Text("Receive local product recommendations \nbased on your condition")
                        .font(.system(size: 22, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color(red: 0.29, green: 0.26, blue: 0.23))
                    
                    Spacer()
                }
                .padding()
                .tag(1)
                
                VStack {
                    Spacer()
                    
                    Image("onboarding3")
                        .resizable()
                        .frame(width: 393, height: 399)
                    
                    Spacer()
                    
                    Text("Enjoy fresh local specialties\nand monitor changes\nthrough sea-otter")
                        .font(.system(size: 22, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color(red: 0.29, green: 0.26, blue: 0.23))
                    
                    Spacer()
                }
                .padding()
                .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .background(Color.customWhite)
            
            Button(action: {
                currentPage += 1
            }, label: {
                Image("largeButton")
                    .resizable()
                    .frame(width: 353, height: 55)
                    .overlay {
                        Text(currentPage == 2 ? "Start" : "Next")
                            .font(.custom("Pretendard-SemiBold", size: 18))
                            .foregroundStyle(Color.white)
                    }
            })
        }
    }
}

#Preview {
    OnboardingView()
}
