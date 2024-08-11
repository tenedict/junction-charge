import SwiftUI

struct IngredientDetailView: View {
    @EnvironmentObject private var viewModel: ContentViewModel
    
    var response: String
    
    @State private var showNutritionInfo = false
    @State private var nutritionData: [(name: String, value: Int)] = []
    @State private var explanation: String = ""
    @State private var recipes: [String] = []
    @State private var region: String = "" // 지역 정보를 위한 상태 변수 추가
    @State private var isFetchingNutritionInfo = false
    @State private var isFetchingExplanation = false
    @State private var isFetchingRecipes = false
    @State private var isFetchingRegion = false // 지역 정보 요청 상태 변수 추가
    @State private var showFullExplanation = false // 전체보기 버튼을 클릭하면 보여질 상태 변수
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(alignment: .leading) {
                Text("\(response) from \(region)")
                    .font(.system(size: 22, weight: .bold))
                    .padding(.vertical)
                
                if viewModel.isLoading {
                    LottieView(name: "loading")
                        .frame(width: 300, height: 300)
                } else {
                    if showNutritionInfo {
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                Text("Why was it recommanded?")
                                    .font(.system(size: 18, weight: .bold))
                                    .padding(.top)
                                    .padding(.leading,8)
                                
                                if explanation.count > 140 { // 설명이 너무 길면 전체보기 버튼을 표시
                                    Text(explanation.prefix(130) + "...")
                                        .foregroundStyle(Color.black)
                                        .padding(.horizontal)
                                    
                                    Button(action: {
                                        showFullExplanation = true
                                    }) {
                                        HStack {
                                            Spacer()
                                            
                                            Text("more")
                                                .padding(.horizontal, 20)
                                                .foregroundStyle(Color.black)
                                        }
                                    }
                                } else {
                                    Text(explanation)
                                        .foregroundStyle(Color.black)
                                }
                            }
                            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.black, lineWidth: 2))
                            .padding(.bottom)
                            
                            // 영양 성분 정보
                            Text("Nutritional Ingredients")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(Color.black)
                                .padding(.top)
                            
                            ForEach(nutritionData, id: \.name) { item in
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.system(size: 13))
                                        .foregroundStyle(Color.black)
                                        .padding(.top,10)
                                    
                                    ProgressBar(value: Double(item.value), maxValue: 10)
                                        .frame(height: 20)
                                }
                            }
                            
                            // 레시피 정보
                            Text("Recipes")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(Color.black)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(recipes, id: \.self) { recipe in
                                        Text(recipe)
                                            .padding()
                                            .background(Color.white) // 네모칸 배경색
                                            .cornerRadius(5)
                                            .shadow(radius: 2)
                                    }
                                }
                                .padding(.bottom)
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.customWhite) // 배경색을 customPeach로 설정
        .onAppear {
            // 첫 번째 프롬프트 요청: 영양 성분 정보
            viewModel.prompt = "\(response)에서 많이 든 영양 성분 중 임산부에게 도움되는 영양 성분을 이름과 일일 섭취량 기준 수치로 표현해줘. 수치는 1부터 10까지 정수 중에서 보여줘. 예시 형식: 단백질.7, 철분.3, 비타민A.5. 그리고 대답은 영어로"
            isFetchingNutritionInfo = true
            viewModel.fetchResponse()
        }
        .onChange(of: viewModel.response) { newValue in
            if isFetchingNutritionInfo {
                parseNutritionInfo(from: newValue)
                // 두 번째 프롬프트 요청: 설명
                viewModel.prompt = "\(response)가 아까의 증상과 관련해서 임산부에게 좋은 이유를 정확하게 설명해줘. 길이는 300자 내외로 설명해줘. 대답은 영어로"
                isFetchingNutritionInfo = false
                isFetchingExplanation = true
                viewModel.fetchResponse()
            } else if isFetchingExplanation {
                explanation = newValue
                isFetchingExplanation = false
                // 세 번째 프롬프트 요청: 레시피 제목
                viewModel.prompt = "추천받은 \(response)의 레시피 5가지를 나열해줘. 단, 5개를 알려줘 . 그리고 단어만 콤마로 나열해. 숫자 쓰지말고 콤마만 사용해서 5가지 나타내. 대답은 영어로. 꼭 콤마로 구분해서 적어줘"
                isFetchingRecipes = true
                viewModel.fetchResponse()
            } else if isFetchingRecipes {
                parseRecipes(from: newValue)
                isFetchingRecipes = false
                // 네 번째 프롬프트 요청: 지역 정보
                viewModel.prompt = "추천받은 \(response)의 대한민국 경북지역의 군과 시 중 \(response)가 가장 많이 생산되는 지역을 한 단어로 말해줘. 대답은 영어로. No int in your answer."
                isFetchingRegion = true
                viewModel.fetchResponse()
            } else if isFetchingRegion {
                region = newValue
                isFetchingRegion = false
                showNutritionInfo = true
            }
        }
        .sheet(isPresented: $showFullExplanation) {
            VStack {
                Text("Why recommand?")
                    .font(.headline)
                    .padding()
                
                ScrollView {
                    Text(explanation)
                        .padding()
                }
                
                Button("close") {
                    showFullExplanation = false
                }
                .padding()
            }
            .background(Color.customPeach) // 모달 배경색을 customPeach로 설정
        }
    }
    
    private func parseNutritionInfo(from response: String) {
        let components = response.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        nutritionData = components.compactMap { item in
            let parts = item.split(separator: ".")
            guard parts.count == 2,
                  let name = parts.first?.trimmingCharacters(in: .whitespaces),
                  let value = Int(parts.last?.trimmingCharacters(in: .whitespaces) ?? "") else {
                return nil
            }
            return (name: name, value: value)
        }
    }
    
    private func parseRecipes(from response: String) {
        let components = response.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        recipes = components
    }
}

struct ProgressBar: View {
    var value: Double
    var maxValue: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 10)
                    .foregroundColor(Color.gray.opacity(0.3))
                    .cornerRadius(5)
                
                Rectangle()
                    .frame(width: CGFloat(value / maxValue) * geometry.size.width, height: 10)
                    .foregroundColor(value > maxValue * 0.75 ? Color.green : (value > maxValue * 0.5 ? Color.yellow : Color.red))
                    .cornerRadius(5)
            }
        }
    }
}
