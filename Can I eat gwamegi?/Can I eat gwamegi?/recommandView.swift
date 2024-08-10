////
////  recommandView.swift
////  Can I eat gwamegi?
////
////  Created by 문재윤 on 8/10/24.
////
//
//import SwiftUI
//
//struct recommandView: View {
//        @StateObject var viewModel = ContentViewModel()
//        @State  var userInput: String = ""
//        
//        var body: some View {
//            VStack {
//                TextField("Enter your question", text: $userInput)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//                
//                Button(action: {
//                    // "안녕하세요" 추가하여 ViewModel의 prompt에 설정
//                    viewModel.prompt = userInput + "임산부에게 이런 증상들이 나타나는데 사과, 딸기, 토마토, 버섯, 곤충, 쌀, 한우, 시금치한우, 토마토, 한라봉, 체리, 양송이포도, 자두, 딸기, 양파, 오미자, 호두사과, 산약(마), 애호박, 딸기, 오이, 한우, 고추, 생강딸기, 포도, 쌀, 감자, 멜론사과, 마, 하수오, 도라지, 한우, 포도, 복숭아, 인삼, 달걀포도, 복숭아, 사과, 마늘,오디, 복분자, 블루베리, 햇순나물, 산채류, 쌀, 한우, 사과, 곶감, 배, 포도, 오이, 복숭아, 오미자, 버섯, 꿀,사과, 미나리, 표고버섯, 오미자, 한우,복숭아, 포도, 자두, 대추, 깻잎, 참외, 묘목,사과, 자두, 복숭아, 꿀, 가지, 마늘, 쌀, 고추,사과, 고추, 자두, 복숭아,고추, 사과, 산채, 천궁,사과, 복숭아, 시금치, 부추,반시, 복숭아, 한재미나리, 딸기, 버섯, 모과, 대추,딸기, 애호박, 수박, 멜론, 감자,참외, 상추, 버섯, 포도, 사과, 꿀, 한우,참외, 꿀, 화훼, 토마토, 딸기,사과, 오미자, 토마토, 풋고추,사과, 고추, 수박, 송이버섯, 표고버섯, 잡곡,고추, 양파, 감자, 쌀, 콩,부지갱이, 산마늘, 미역취, 참고비, 삼나물. 이 중에서 최소 3개 최대 10개를 골라서 ,단위로 나열해줘. 예를 들면 사과,시금치,고추,풋고추,토마토 이런식으로"
//                    viewModel.fetchResponse()
//                }) {
//                    Text("Send")
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(8)
//                }
//                
//                if viewModel.isLoading {
//                    ProgressView()
//                        .padding()
//                } else {
//                    Text(viewModel.response)
//                        .padding()
//                }
//            }
//            .padding()
//            // NavigationLink to the new NextView
//            NavigationLink(destination: ingredientView()) {
//                Text("다음 화면으로")
//                    .padding()
//                    .background(Color.green)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//        }
//}

// 증상에 따른 음식 알려줌
import SwiftUI

struct RecommandView: View {
    var response: String
    @State var userInput: String = ""
    @StateObject var viewModel = ContentViewModel()
    @State private var navigateToNextPage = false
    
    // 선택된 항목을 추적하는 상태 변수
    @State private var selectedItems: [String] = []
    // 텍스트 필드의 가시성을 제어하는 상태 변수
    @State private var isTextFieldVisible = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // 텍스트 필드가 보이는 경우에만 표시
                    if isTextFieldVisible {
                        TextField("질문을 입력하세요", text: $userInput)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                    }
                    
                    Button(action: {
                        viewModel.prompt = userInput + " 임산부에게 이런 증상들이 나타나는데 사과, 딸기, 토마토, 버섯, 곤충, 쌀, 한우, 시금치, 한라봉, 체리, 양송이, 포도, 자두, 양파, 오미자, 호두, 산약(마), 애호박, 오이, 고추, 생강, 감자, 멜론, 하수오, 도라지, 복숭아, 인삼, 달걀, 마늘, 오디, 복분자, 블루베리, 햇순나물, 산채류, 곶감, 배, 꿀, 미나리, 표고버섯, 대추, 깻잎, 참외, 묘목, 가지, 천궁, 부추, 반시, 한재미나리, 모과, 수박, 상추, 화훼, 풋고추, 송이버섯, 잡곡, 콩, 부지갱이, 산마늘, 미역취, 참고비, 삼나물.. 이 중에서 최소 3개 최대 10개를 골라서 ,단위로 나열해줘. 예를 들면 사과,시금치,고추,풋고추,토마토 이런식으로 아무 말도 하지말고 단어와 콤마만 써"
                        viewModel.fetchResponse()
                        navigateToNextPage = true
                        // 텍스트 필드를 숨김
                        isTextFieldVisible = false
                    }) {
                        Text("전송 및 다음 화면으로 이동")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                    } else {
                        Text(viewModel.response)
                            .padding()
                    }
                }
                
                // 콤마로 문자열을 분리하여 배열로 변환
                let items = response.components(separatedBy: ",")
                
                // 각 항목을 버튼으로 표시
                ForEach(items, id: \.self) { item in
                    Button(action: {
                        if selectedItems.contains(item) {
                            // 이미 선택된 항목이면 선택 해제
                            selectedItems.removeAll { $0 == item }
                            userInput = userInput.components(separatedBy: ", ").filter { $0 != item }.joined(separator: ", ")
                        } else {
                            // 선택되지 않은 항목이면 선택
                            selectedItems.append(item)
                            userInput += userInput.isEmpty ? item : ", \(item)"
                        }
                        print("\(item) 선택됨 또는 해제됨")
                    }) {
                        Text(item)
                            .padding()
                            .background(selectedItems.contains(item) ? Color.blue.opacity(0.6) : Color.gray.opacity(0.2)) // 선택된 경우 색상 변경
                            .foregroundColor(.black)
                            .cornerRadius(8)
                    }
                    .padding(.vertical, 4)
                }
                
                // NavigationLink로 IngredientView로 이동
                NavigationLink(destination: IngredientView(response: viewModel.response), isActive: $navigateToNextPage) {
                    EmptyView()
                }
            }
            .padding()
        }
    }
}
