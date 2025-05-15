//
//  RegistryOldView.swift
//  ZEREK-ios
//
//  Created by bakebrlk on 07.03.2025.
//

import SwiftUI

struct RegistryOldView: View {
    @EnvironmentObject private var viewModel: RegistryViewModel
    @EnvironmentObject var navigation: Navigation

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 1)
                .frame(maxWidth: .infinity, maxHeight: 64)
                .foregroundColor(Color(red: 125/255, green: 128/255, blue: 218/255))
                .ignoresSafeArea()
            Spacer()
            
            Text("How Old Are you?")
                .font(.system(size: 24, weight: .medium))
                .padding(.bottom)
            
            Button(action: {
                viewModel.info.oldYear = "10-15"
            }, label: {
                Text("10-15")
                    .shadow(color: .black.opacity(0.7), radius: 5, x: 3, y: 3)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .frame(maxWidth: UIScreen.main.bounds.width/3.5)
                    .foregroundColor(viewModel.info.oldYear == "10-15" ? .white : .black)
                    .background(viewModel.info.oldYear == "10-15" ? Color(red: 120/255, green: 111/255, blue: 1).opacity(0.7) : .clear)
                    .cornerRadius(20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(red: 120/255, green: 111/255, blue: 1),lineWidth: 3)
                    }
                   
            })
           
            Button(action: {
                viewModel.info.oldYear = "15-25"
            }, label: {
                Text("15-25")
                    .shadow(color: .black.opacity(0.7), radius: 5, x: 3, y: 3)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .frame(maxWidth: UIScreen.main.bounds.width/3.5)
                    .foregroundColor(viewModel.info.oldYear == "15-25" ? .white : .black)
                    .background(viewModel.info.oldYear == "15-25" ? Color(red: 120/255, green: 111/255, blue: 1).opacity(0.7) : .clear)
                    .cornerRadius(20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(red: 120/255, green: 111/255, blue: 1),lineWidth: 3)
                    }
                    .padding(.top)
            })
                  
            Button(action: {
                viewModel.info.oldYear = "25-30"
            }, label: {
                Text("25-30")
                    .shadow(color: .black.opacity(0.7), radius: 5, x: 3, y: 3)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .frame(maxWidth: UIScreen.main.bounds.width/3.5)
                    .foregroundColor(viewModel.info.oldYear == "25-30" ? .white : .black)
                    .background(viewModel.info.oldYear == "25-30" ? Color(red: 120/255, green: 111/255, blue: 1).opacity(0.7) : .clear)
                    .cornerRadius(20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(red: 120/255, green: 111/255, blue: 1),lineWidth: 3)
                    }
                    .padding(.top)
            })
            
            Button(action: {
                viewModel.info.oldYear = "30+"
            }, label: {
                Text("30+")
                    .shadow(color: .black.opacity(0.7), radius: 5, x: 3, y: 3)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .frame(maxWidth: UIScreen.main.bounds.width/3.5)
                    .foregroundColor(viewModel.info.oldYear == "30+" ? .white : .black)
                    .background(viewModel.info.oldYear == "30+" ? Color(red: 120/255, green: 111/255, blue: 1).opacity(0.7) : .clear)
                    .cornerRadius(20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(red: 120/255, green: 111/255, blue: 1),lineWidth: 3)
                    }
                    .padding(.top)
            })
            
            Button(action: {
                navigation.navigate(to: .selectElevel)
            }, label: {
                Text("Next")
                    .padding()
                    .frame(maxWidth: UIScreen.main.bounds.width/2.5)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
                    .background(Color(red: 91/255, green: 123/255, blue: 254/255))
                    .cornerRadius(12)
                    .padding()
                    .padding(.top)
            })
            
            Spacer()
            
            HStack {
                Spacer()
                Image("2")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.77)
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    RegistryOldView()
}
