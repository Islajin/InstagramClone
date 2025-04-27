//
//  NewPostView.swift
//  InstagramClone
//
//  Created by yeonjin on 4/28/25.
//

import SwiftUI

struct NewPostView: View {
    
    @State var caption = ""
    
    var body: some View {
        VStack(){
            HStack{
                Button{}
                label:{
                    Image(systemName: "chevron.left")
                        .tint(.black)
                }
               Spacer()
                Text("새 게시물")
                    .font(.title2)
                    .fontWeight(.semibold)
            Spacer()
                
            }.padding(.horizontal
            )
            
            Image("latte")
                .resizable()
                .aspectRatio(1, contentMode:.fit)
                .frame(maxWidth: .infinity)

            TextField("문구를 작성하거나 설문을 추가하세요.", text: $caption)
                .padding()
            
            Spacer()
            
            Button{} label:{
                Text("공유")
                    .frame(width: 363, height: 42)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
            }.padding()
                
            
          
        }
        
    }
}

#Preview {
    NewPostView()
}
