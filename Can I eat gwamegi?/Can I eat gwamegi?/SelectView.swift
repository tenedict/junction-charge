import SwiftUI

struct SelectView: View {
    @EnvironmentObject private var dateManager: DateManager
    @EnvironmentObject private var viewModel: ContentViewModel
    @Binding var viewCase: ViewCase
    
    @State private var items: [String] = []
    @State private var selectedItem = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Please select \nyour current condition")
                .font(.system(size: 22, weight: .heavy))
                .foregroundStyle(Color(red: 0.29, green: 0.26, blue: 0.23))
                .padding([.leading, .top], 16)
            
            ScrollView {
                Section {
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(width: 200, height: 200)
                    } else {
                        if items.isEmpty {
                            Text("There no symptoms!")
                        } else {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                                ForEach(items, id: \.self) { item in
                                    Button(action: {
                                        if item == selectedItem {
                                            selectedItem = ""
                                        } else {
                                            selectedItem = item
                                        }
                                        print("\(item) 선택됨 또는 해제됨")
                                    }, label: {
                                        ZStack {
                                            Image(item == selectedItem ? "symptomSelected" : "symptomNotSelected")
                                                .resizable()
                                                .frame(width: 170.5, height: 89)
                                            
                                            Text("\(item)")
                                                .font(.system(size: 16, weight: .medium))
                                                .foregroundColor(Color(red: 0.29, green: 0.26, blue: 0.23))
                                        }
                                    })
                                }
                            }
                            .padding()
                        }
                    }
                } header: {
                    HStack {
                        Text("Symptoms you may experience in week \(dateManager.calculatePregnancyWeek())")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(Color(red: 0.29, green: 0.26, blue: 0.23))
                            .padding(.leading, 16)
                        
                        Spacer()
                    }
                }
                .padding(.bottom)
                
//                Section {
//                    VStack(spacing: 16) {
//                        ForEach(0..<3) { row in
//                            HStack(spacing: 16) {
//                                ForEach(0..<2) { column in
//                                    ZStack {
//                                        Image("symptomNotSelected")
//                                            .resizable()
//                                            .frame(width: 170.5, height: 89)
//
//                                        Text("Item \(row * 2 + column + 1)")
//                                            .font(.system(size: 16, weight: .medium))
//                                            .foregroundStyle(Color(red: 0.29, green: 0.26, blue: 0.23))
//                                    }
//                                }
//                            }
//                        }
//                    }
//                    .padding(.horizontal, 16)
//                    .padding(.bottom)
//                    .frame(maxWidth: .infinity, alignment: .center)
//                } header: {
//                    HStack {
//                        Text("Other symptoms")
//                            .font(.system(size: 16, weight: .semibold))
//                            .foregroundStyle(Color(red: 0.49, green: 0.42, blue: 0.37))
//                            .padding(.leading, 16)
//
//                        Spacer()
//                    }
//                }
                
                Button(action: {
                    viewModel.prompt = selectedItem + " 임산부에게 이런 증상이 나타나는데 apple, bean, cherry, egg, grape, beef, melon, mushroom, orange, plum, potato, rice, schisandra, strawberry, spinach, tomato.. 이 중에서 이 증상에 좋은 3개를 골라서 ,단위로 나열해줘. 예를 들면 apple,spinach,tomato 이런식으로 아무 말도 하지말고 단어와 콤마만 써. 영어로 답해줘."
                    viewModel.fetchResponse()
                    
                    viewCase = .ing
                }, label: {
                    Image("largeButton2")
                        .resizable()
                        .frame(width: 353, height: 55)
                        .overlay {
                            Text("Continue")
                                .font(.custom("Pretendard-SemiBold", size: 18))
                                .foregroundStyle(Color.white)
                        }
                })
            }
            
        }
        .padding([.leading, .trailing])
        .background(Color.customWhite)
        .onAppear(perform: {
            print("\(dateManager.calculatePregnancyDay())")
            viewModel.prompt = "\(dateManager.calculatePregnancyWeek())주차에 임산부에게 생길 수 있는 여러가지 나쁜 증상들을 ,단위로 설명없이 영어로 나열해줘. 예를 들면 입덧, 붓기, 탈모, 체중증가 이런식으로적어줘. 아무말도 하지말고 영어와 콤마만 활용해."
            viewModel.fetchResponse()
            items = viewModel.response.components(separatedBy: ",")
        })
    }
}
