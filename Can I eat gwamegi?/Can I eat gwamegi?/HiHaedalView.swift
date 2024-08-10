import SwiftUI

struct HiHaedalView: View {
    @EnvironmentObject private var dateManager: DateManager
    @EnvironmentObject private var viewModel: ContentViewModel
    
    @Binding var viewCase: ViewCase
    
    @State private var showSelectView = false
    @State private var foods: [String] = []
    
    var body: some View {
        ZStack {
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
                    .padding(.bottom, 180)
                
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
            
            VStack {
                Rectangle()
                    .foregroundStyle(Color.clear)
                    .frame(height: 80)
                
                if foods.count >= 1 {
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
//                        .offset(x:-95, y:)
                }
                
                Spacer()
                
                if foods.count >= 2 {
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
                    //                    .offset(x:-95, y: )
                }
                
                Spacer()
                
                if foods.count == 3 {
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
                    //                    .offset(x:-95, y: riceOffset - 190)
                }
                
                Rectangle()
                    .foregroundStyle(Color.clear)
                    .frame(height: 80)
            }
        }
        .background(Color.customWhite)
        .onAppear(perform: {
            foods = viewModel.response.components(separatedBy: ", ")
        })
    }
}
