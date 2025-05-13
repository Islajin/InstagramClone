//
//  CommentView.swift
//  InstagramClone
//
//  Created by yeonjin on 5/12/25.
//

import SwiftUI
import Kingfisher

struct CommentView: View {
    @State var commentText = ""
    @State var viewModel: CommentViewModel
    
    init (post: Post){
        self.viewModel = CommentViewModel(post: post)
    }
    var body: some View {
        Text("댓글")
            .font(.headline)
            .fontWeight(.semibold)
            .padding(.bottom, 15)
            .padding(.top, 30)
        
        Divider()
        
        ScrollView {
            LazyVStack(alignment:.leading) {
                ForEach(viewModel.comments) {
                    comment in
                    CommentCellView(comment: comment)
                        .padding(.top)
                        .padding(.horizontal)
                }
                
            }
            
        }
        
        Divider()
        HStack {
            if let imageUrl = AuthManager.shared.currentUser?.profileImageUrl
            {
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
        
            TextField("댓글 추가", text: $commentText, axis: .vertical)
            //댓글 창이 세로로 늘어나게 해라 -> .vertical
            Button {
                Task {await viewModel
                        .uploadComment(commentText: commentText)
                    commentText = "" }
            }
            label : {
                Text ("보내기")
            } .tint(Color.black)
        }.padding()
    }
}

