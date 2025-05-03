//
//  SignUpBackgroundView.swift
//  InstagramClone
//
//  Created by yeonjin on 5/3/25.
//

import SwiftUI

struct SignUpBackgroundView<Content: View>: View {
    @Environment(\.dismiss) var dismiss
    let content: Content
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


