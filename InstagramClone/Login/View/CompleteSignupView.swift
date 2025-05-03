//
//  CompleteSignupView.swift
//  InstagramClone
//
//  Created by yeonjin on 5/3/25.
//

import SwiftUI

struct CompleteSignupView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(SignupViewModel.self) var signupViewModel
    
    var body: some View {
        @Bindable var signupViewModel = signupViewModel
        
        ZStack{
            GradientBackgroundView()
            VStack{
                Image("instagramLogo2")
                    .resizable()
                    .scaledToFit()
                    .frame(width:120)
                
                Spacer()
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 172, height: 172)
                    .foregroundStyle(Color.gray)
                    .opacity(0.5)
                    .overlay{
                        Circle()
                            .stroke(Color.gray,lineWidth: 2)
                            .opacity(0.5)
                            .frame(width :185, height: 185)
                    }
                Text("\(signupViewModel.username)님, Instagram에 오신 것을 환영합니다.")
                    .font(.title)
                    .padding(.top, 30)
                    .padding(.horizontal)
                
                Spacer()
                Button{}label: {
                    signupViewModel.createUser()
                    Text("완료")
                        .foregroundStyle(.white)
                        .frame(width: 363, height:42)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius:20))
                    
                }
                Spacer()
                
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                Button{
                    dismiss()
                }label:{
                    Image(systemName: "chevron.left")
                    
                }
                
            }
        }.tint(.black)
    }
}

#Preview {
    CompleteSignupView()
}
