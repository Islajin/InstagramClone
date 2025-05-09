//
//  FeedView.swift
//  InstagramClone
//
//  Created by yeonjin on 5/9/25.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        ScrollView {
            VStack{
                HStack {
                    
                    Image("instagramLogo2")
                        .resizable()
                        .scaledToFit( )
                        .frame(width:110)
                    
                    Spacer()
                    
                    Image(systemName : "heart")
                        .imageScale(.large)
                    Image(systemName : "papaerplane")
                        .imageScale(.large)
                    
                }
                .padding(.horizontal)
                
                
                FeedCellView()
                FeedCellView()
                
                Spacer()
            }
        }
      
    }
}

#Preview {
    FeedView()
}
