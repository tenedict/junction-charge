//
//   symptomsView.swift
//  Can I eat gwamegi?
//
//  Created by 문재윤 on 8/10/24.
//

import SwiftUI

// 주차 로 증상 알려줌

struct SymptomsView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var selectedNumber: Int?
    @State private var isActive = false // NavigationLink 활성화 여부를 관리하는 상태 변수
    
    var body: some View {
        NavigationStack {
            VStack {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 10) {
                    ForEach(1..<41) { number in
                        Button(action: {
                            selectedNumber = number
                        }) {
                            Text("\(number)")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(selectedNumber == number ? Color.blue : Color.gray.opacity(0.2))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding()

                Button(action: {
                    if let number = selectedNumber {
                        viewModel.prompt = "\(number)주차에 임산부에게 생길 수 있는 여러가지 나쁜 증상들을 ,단위로 설명없이 나열해줘. 예를 들면 입덧, 붓기,탈모,체중증가 이런식으로적어줘. 아무말도 하지말고 한글과 콤마만 활용해"
                        viewModel.fetchResponse()
                    }
                }) {
                    Text("Send")
                        .padding()
                        .background(selectedNumber != nil ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(selectedNumber == nil)
                
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else {
                    Text(viewModel.response)
                        .padding()
                        .onAppear {
                            // 로딩이 끝나면 자동으로 다음 뷰로 전환
                            if !viewModel.response.isEmpty {
                                isActive = true
                            }
                        }
                }

                // viewModel의 response 값만 다음 뷰로 전달
                NavigationLink(destination: RecommandView(response: viewModel.response), isActive: $isActive) {
                    EmptyView() // 화면에 보이지 않게 빈 뷰를 사용
                }
            }
            .padding()
        }
    }
}
