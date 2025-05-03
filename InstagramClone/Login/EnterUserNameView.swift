//
//  EnterUserNameView.swift
//  InstagramClone
//
//  Created by yeonjin on 5/3/25.
//

import SwiftUI

struct EnterUserNameView: View {
 
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            GradientBackgroundView()
            
            VStack(){
                Text("사용자 이름 만들기")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading) // 이렇게 하나만 왼쪽정렬 시키고 싶으면 frame을 꽉차게 주고 왼쪽정렬 시켜주면 된다.
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                    
                    
                Text("사용자 이름을 직접 추가하거나 추천 이름을 사용하세요. 언제든지 변경할 수 있습니다.")
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                TextField("이메일", text: .constant(""))
                    .modifier(InstagramTextFieldModifier())
                
                NavigationLink{
                    CompleteSignupView()
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
    EnterUserNameView()
}
