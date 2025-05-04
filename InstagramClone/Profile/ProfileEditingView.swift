//
//  ProfileEditingView.swift
//  InstagramClone
//
//  Created by yeonjin on 5/4/25.
//

import SwiftUI

struct ProfileEditingView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Image("profile_cat")
                    .resizable()
                    .frame(width:75 ,height:75)
                    .clipShape(Circle())
                    .padding(.bottom, 10)
            
            Button{}label:{
                Text("사진 또는 아바타 수정")
                    .font(.title3)
            }
            
            VStack(alignment: .leading, spacing:5){
                Text("이름")
                    .foregroundStyle(.gray)
                    .fontWeight(.bold)
                    
                TextField("이름", text: .constant("고양이 대장군"))
                    .font(.title2)
                
                Divider()
            }.padding(.horizontal)
                .padding(.top,10)
            
            VStack(alignment: .leading, spacing:5){
                Text("사용자 이름")
                    .foregroundStyle(.gray)
                    .fontWeight(.bold)
                    
                TextField("사용자 이름", text: .constant("general.cat"))
                    .font(.title2)
                
                Divider()
            }.padding(.horizontal)
                .padding(.top,10)

            
            VStack(alignment: .leading, spacing:5){
                Text("소개")
                    .foregroundStyle(.gray)
                    .fontWeight(.bold)
                    
                TextField("소개", text: .constant("세계를 정복한다."))
                    .font(.title2)
                
                Divider()
            }.padding(.horizontal)
                .padding(.top,10)
       
            Spacer()
  
        }
        .navigationTitle("프로필 편집")
        .navigationBarTitleDisplayMode(.inline) 
        .navigationBarBackButtonHidden()
        .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        dismiss()
                    }label:{
                        Image(systemName: "arrow.backward")
                            .tint(.black)
                        
                    }
                    
                }
            }
    }
}

#Preview {
    ProfileEditingView()
}
