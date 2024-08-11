import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject private var dateManager: DateManager
    
    @State private var currentPage = 0
    @State private var selectedDate = Date()
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .gray
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                VStack(spacing: 9) {
                    HStack {
                        Text("Explore local products beneficial for pregnant women.")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(Color(red: 0.29, green: 0.26, blue: 0.23))
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("This service is brought to you by Gyeongsanbuk-do local products.")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(Color(red: 0.65, green: 0.58, blue: 0.52))
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 45)
                        .frame(width: 269, height: 147)
                        .foregroundStyle(Color.white)
                        .padding()
                        .overlay {
                            Image("gyeongbuk")
                                .resizable()
                                .frame(width: 208, height: 134)
                        }
                    
                    Image("character")
                        .resizable()
                        .frame(width: 203, height: 269)
                        .padding()
                    
                    Spacer()
                }
                .padding()
                .tag(0)
                
                VStack(spacing: 9) {
                    HStack {
                        Text("Provide your expected due date.")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(Color(red: 0.12, green: 0.11, blue: 0.11))
                        
                        Spacer()
                    }
                    
                    DatePicker(selection: $selectedDate, displayedComponents: .date) {
                        Image("dateSelectButton")
                            .resizable()
                            .frame(width: 353, height: 52)
                    }
                    .datePickerStyle(.graphical)
                    .tint(.customOrange)
                    .labelsHidden()
                    
                    Spacer()
                }
                .padding()
                .tag(1)
                
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
                .tag(2)
                
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
                .tag(3)
                
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
                .tag(4)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            
            Button(action: {
                if currentPage == 4 {
                    dateManager.childBirthDate = selectedDate
                    UserDefaults.standard.set(true, forKey: "launchedBefore")
                } else {
                    currentPage += 1
                }
            }, label: {
                Image("largeButton")
                    .resizable()
                    .frame(width: 353, height: 55)
                    .overlay {
                        Text(currentPage == 4 ? "Let's go" : "Next")
                            .font(.custom("Pretendard-SemiBold", size: 18))
                            .foregroundStyle(Color.white)
                    }
            })
        }
        .background(Color.customWhite)
    }
}

#Preview {
    OnboardingView()
}
