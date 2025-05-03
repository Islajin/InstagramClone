//
//  SignUpBackgroundView.swift
//  InstagramClone
//
//  Created by yeonjin on 5/3/25.
//

//ViewBuilder로 리팩토링

import SwiftUI

struct SignUpBackgroundView<Content: View>: View {
    @Environment(\.dismiss) var dismiss
    let content: Content
        
    //인자가 init에 컨텐츠로 들어옴
    init(@ViewBuilder content: () ->Content){
        self.content = content()
    }
    
    var body: some View {
        
        ZStack{
            GradientBackgroundView()
            content
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


