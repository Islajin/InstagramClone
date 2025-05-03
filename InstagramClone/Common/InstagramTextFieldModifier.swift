//
//  InstagramTextFieldModifier.swift
//  InstagramClone
//
//  Created by yeonjin on 5/3/25.
//

import SwiftUI

struct InstagramTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textInputAutocapitalization(.never) //대문자 방지
            .padding(12)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay{
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: 1.0)
            }
            .padding(.horizontal)
        
    }
}


