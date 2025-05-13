//
//  CommentCellView.swift
//  InstagramClone
//
//  Created by yeonjin on 5/12/25.
//

import SwiftUI
import Kingfisher

struct CommentCellView: View {
    
    let comment : Comment
    var body: some View {
        HStack
        {
            if let imageUrl =
                comment.commentUser?.profileImageUrl {
                KFImage(URL(string :imageUrl))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height:35)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                
            }
            
            VStack(alignment: .leading ){
                HStack{
                    Text(comment.commentUser?.username ?? "")
                    Text(comment.date.description) //relativeTimeString 에러
                    .foregroundStyle(.gray)
                }
                Text(comment.commentText)
            }
        }
        
    }
}

