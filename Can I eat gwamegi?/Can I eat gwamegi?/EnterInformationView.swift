import SwiftUI

struct EnterInformationView: View {
    @EnvironmentObject private var dateManager: DateManager
    
    @State private var currentPage: Int = 0
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                VStack(spacing: 9) {
                    HStack {
                        Text("임산부에게 좋은 특산물을 확인하세요")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(Color(red: 0.29, green: 0.26, blue: 0.23))
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("본 서비스는 경상북도 특산물과 함께합니다")
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
                        Text("출산 예정일을 선택해주세요")
                            .font(.system(size: 22, weight: .heavy))
                            .foregroundColor(Color(red: 0.12, green: 0.11, blue: 0.11))
                        
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
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .background(Color.customWhite)
            
            Button(action: {
                if currentPage == 1 {
                    dateManager.childBirthDate = selectedDate
                } else {
                    currentPage += 1
                }
            }, label: {
                Image("largeButton")
                    .resizable()
                    .frame(width: 353, height: 55)
                    .overlay {
                        Text("다음")
                            .font(.custom("Pretendard-SemiBold", size: 18))
                            .foregroundStyle(Color.white)
                    }
            })
        }
    }
}

#Preview {
    EnterInformationView()
}
