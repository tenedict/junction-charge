import SwiftUI

struct HiHaedalView: View {
    @EnvironmentObject private var dateManager: DateManager
    @EnvironmentObject private var viewModel: ContentViewModel
    
    @Binding var viewCase: ViewCase
    
    @State private var showSelectView = false
    @State private var foods: [String] = []
    @State private var showFood1Detail = false
    @State private var showFood2Detail = false
    @State private var showFood3Detail = false
    @State private var food1Scale = false
    @State private var food2Scale = false
    @State private var food3Scale = false
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Hi Haedal,")
                        .font(.system(size: 22, weight: .heavy))
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(Color(red: 0.29, green: 0.26, blue: 0.23))
                    
                    Text("This is just the \nbeginning of something big.")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(Color(red: 0.29, green: 0.26, blue: 0.23))
                }
                
                Spacer()
                
                Image("miniBackground")
                    .resizable()
                    .frame(width: 61, height: 31)
                    .overlay {
                        Text("D-\(dateManager.calculatePregnancyDay())")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color(red: 0.52, green: 0.46, blue: 0.42))
                    }
            }
            
            Spacer()
            
            VStack {
                Text("What should I eat?")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .padding(16)
                    .background(Color(red: 0.69, green: 0.64, blue: 0.61))
                    .cornerRadius(26)
                
                Image("Ellipse 10")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .background(Color(red: 0.69, green: 0.64, blue: 0.61))
                    .clipShape(Circle())
                    .offset(x: 30)
                
                Image("Ellipse 11")
                    .resizable()
                    .frame(width: 6, height: 6)
                    .background(Color(red: 0.69, green: 0.64, blue: 0.61))
                    .clipShape(Circle())
                    .offset(x: 20)
            }
            
            Image("character")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 117, height: 163)
                .padding()
            
            HStack {
                if foods.count >= 1 {
                    Button(action: {
                        showFood1Detail = true
                    }, label: {
                        Image(foods[0])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .padding(0)
                            .background(Color(red: 0.97, green: 0.91, blue: 0.85))
                            .cornerRadius(83)
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .inset(by: 0.17)
                                    .stroke(Color(red: 0.83, green: 0.75, blue: 0.77), lineWidth: 0.33)
                            )
                            .scaleEffect(food1Scale ? 1 : 0.9)
                            .onAppear {
                                withAnimation(.spring().repeatForever()) {
                                    food1Scale.toggle()
                                }
                            }
                    })
                }
                
                if foods.count >= 2 {
                    Button(action: {
                        showFood2Detail = true
                    }, label: {
                        Image(foods[1])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .padding(0)
                            .background(Color(red: 0.97, green: 0.91, blue: 0.85))
                            .cornerRadius(83)
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .inset(by: 0.17)
                                    .stroke(Color(red: 0.83, green: 0.75, blue: 0.77), lineWidth: 0.33)
                            )
                            .scaleEffect(food2Scale ? 1 : 0.9)
                            .onAppear {
                                withAnimation(.spring().repeatForever()) {
                                    food2Scale.toggle()
                                }
                            }
                    })
                }
                
                if foods.count == 3 {
                    Button(action: {
                        showFood3Detail = true
                    }, label: {
                        Image(foods[2])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .padding(0)
                            .background(Color(red: 0.97, green: 0.91, blue: 0.85))
                            .cornerRadius(83)
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .inset(by: 0.17)
                                    .stroke(Color(red: 0.83, green: 0.75, blue: 0.77), lineWidth: 0.33)
                            )
                            .scaleEffect(food3Scale ? 1 : 0.9)
                            .onAppear {
                                withAnimation(.spring().repeatForever()) {
                                    food3Scale.toggle()
                                }
                            }
                    })
                }
            }
            
            Spacer()
            
            Button(action: {
                viewCase = .select
            }, label: {
                Image("largeButton2")
                    .resizable()
                    .frame(width: 353, height: 55)
                    .overlay {
                        Text("Select Symptoms")
                            .font(.custom("Pretendard-SemiBold", size: 18))
                            .foregroundStyle(Color.white)
                    }
            })
        }
        .padding([.top, .horizontal])
        .background(Color.customWhite)
        .onAppear(perform: {
            if viewModel.response != "" {
                foods = viewModel.response.components(separatedBy: ", ")
            }
        })
        .sheet(isPresented: $showFood1Detail, content: {
            IngredientDetailView(response: foods[0])
        })
        .sheet(isPresented: $showFood2Detail, content: {
            IngredientDetailView(response: foods[1])
        })
        .sheet(isPresented: $showFood3Detail, content: {
            IngredientDetailView(response: foods[2])
        })
    }
}
