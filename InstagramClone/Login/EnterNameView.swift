//
//  EnterNameView.swift
//  InstagramClone
//
//  Created by yeonjin on 5/3/25.
//

import SwiftUI

struct EnterNameView: View {
   
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            GradientBackgroundView()
            
            VStack(){
                Text("이름 입력")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading) // 이렇게 하나만 왼쪽정렬 시키고 싶으면 frame을 꽉차게 주고 왼쪽정렬 시켜주면 된다.
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                    
                    
                
                TextField("성명", text: .constant(""))
                    .modifier(InstagramTextFieldModifier())
                
                NavigationLink{
                    EnterUserNameView()
                }label:{
                    Text("다음")
                }.padding(12)
                    .frame(width: 363, height: 42)
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal)
                
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
                        .tint(.black)
                }
                
            }
        }
        
    }
}

#Preview {
    EnterNameView()
}
