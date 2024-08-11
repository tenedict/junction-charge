import SwiftUI

struct SelectView: View {
    @EnvironmentObject private var dateManager: DateManager
    @EnvironmentObject private var viewModel: ContentViewModel
    @Binding var viewCase: ViewCase
    
    @State private var items: [String] = []
    @State private var selectedItem = ""
    @State private var customSymptom: String = "" // 텍스트 필드에 입력된 사용자 정의 증상
    
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
                            Text("There are no symptoms!")
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
                                
                                // "기타" 항목 추가
                                Button(action: {
                                    selectedItem = "etc"
                                }, label: {
                                    ZStack {
                                        Image("symptomNotSelected")
                                            .resizable()
                                            .frame(width: 170.5, height: 89)
                                        
                                        Text("etc")
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(Color(red: 0.29, green: 0.26, blue: 0.23))
                                    }
                                })
                            }
                            .padding()
                        }
                    }
                    
                    // "기타"가 선택되었을 때 텍스트 필드 표시
                    if selectedItem == "etc" {
                        TextField("Type your symptom", text: $customSymptom)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, 16)
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
            }
            
            Button(action: {
                let finalSelection = selectedItem == "기타" ? customSymptom : selectedItem
                viewModel.symptom = finalSelection
                viewModel.prompt = finalSelection + " 임산부에게 이런 증상이 나타나는데 apple, bean, cherry, egg, grape, beef, melon, mushroom, orange, plum, potato, rice, schisandra, strawberry, spinach, tomato 중에서 이 증상에 좋은 3개를 골라서 ,단위로 나열해줘. 예를 들면 apple,spinach,tomato 이런식으로 아무 말도 하지말고 단어와 콤마만 써. 영어로 답해줘."
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
        .padding([.leading, .trailing])
        .background(Color.customWhite)
        .onAppear {
            print("\(dateManager.calculatePregnancyDay())")
            viewModel.prompt = "\(dateManager.calculatePregnancyWeek())주차에 임산부에게 생길 수 있는 여러 가지 나쁜 증상들을 ,단위로 설명 없이 영어로 나열해줘. 예를 들면 입덧, 붓기, 탈모, 체중증가 이런 식으로 적어줘. 아무말도 하지 말고 영어와 콤마만 활용해."
            viewModel.fetchResponse()
        }
        .onChange(of: viewModel.response) { newValue in
            items = newValue.components(separatedBy: ",")
        }
    }
}
