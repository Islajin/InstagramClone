//
//  FeedCellView.swift
//  InstagramClone
//
//  Created by yeonjin on 5/9/25.
//

import SwiftUI
import Kingfisher

struct FeedCellView: View {
//    let post: Post
    
    // 지금 FeedCellViewModel 이 하는 일이 모델을 읽기만 하기 때문에 그냥
    // let post: Post 이렇게 작성해도 됨
    
    @State var viewModel: FeedCellViewModel
    
   
    init(post: Post ){
        self.viewModel = FeedCellViewModel(post: post)
        //넘겨받는 건 post 고, ViewModel은 내부에서 직접 만듬
    }
    var body: some View {
        VStack {
           
            KFImage(URL(string: viewModel.post.imageURL))
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .overlay (alignment: .top){
                    
                    HStack {
//                        Image("image_lion4")
                        KFImage(URL(string: viewModel.post.user?.profileImageUrl ?? ""))
                            .resizable()
                            .frame(width: 35, height: 35)
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(Color(red : 191/255, green: 11/255, blue:100/255), lineWidth: 2)
                            }
                        //userid로 가져온 user 안에 있는 것에 접근은 이렇게 하면 됨
                        Text("\(viewModel.post.user?.username ?? "" )")
                            .foregroundStyle(.white)
                            .bold()
                        Spacer()
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(.white)
                            .imageScale(.large)
                    }.padding(5)
                }
            
            HStack {
                Image(systemName: "heart")
                Image(systemName: "bubble.right")
                Image(systemName: "paperplane")
                Spacer()
                Image(systemName: "bookmark")
                
            }.imageScale(.large)
                .padding(.horizontal)
            
            Text("좋아요 \(viewModel.post.like)개 ")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Text("\(viewModel.post.user?.username ?? "" )" + " " + viewModel.post.caption)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Text("댓글 25개 더보기")
                .foregroundStyle(.gray)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Text("3일전")
                .foregroundStyle(.gray)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            
            
        }
        .padding(.bottom)
    }
}
