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
    @State var isCommentShowing = false
    //isCommentShowing 이 true 면 댓글창이 보임
   
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

                        NavigationLink {
                            
                            if let user = viewModel.post.user {
                                ProfileView(viewModel: ProfileViewModel(user: user)) }
                            
                            
                        } label: {
                            //label이 현재 보이는 버튼 같은 화면
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
                        }

                        
                        Spacer()
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(.white)
                            .imageScale(.large)
                    }.padding(5)
                }
            
            HStack {
                let isLike = viewModel.post.isLike ?? false
                Button {
                    Task {
                        isLike ?  await viewModel.unlike() :  await viewModel.like()
                    }
                } label: {
                    Image(systemName : isLike ?  "heart.fill" : "heart")
                        .foregroundStyle(isLike ? .red : .primary  ) //.primary는 기본색상임
                }
                
                Button {
                    
                    isCommentShowing = true
                } label:
                { Image(systemName: "bubble.right")}
                    .tint(.black)
                
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
            
            
            Button {isCommentShowing = true }
            label: {
                Text("댓글 \(viewModel.commentCount)개 더보기")
                    .foregroundStyle(.gray)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                } .tint(.black)
            
            Text("3일전")
                .foregroundStyle(.gray)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            
            
        }
        .padding(.bottom)
        .sheet(isPresented: $isCommentShowing, content: {
            CommentView(post: viewModel.post)
                .presentationDragIndicator(.visible)
        })
        .onChange(of :isCommentShowing) {
            oldValue, newValue in
            if newValue == false {
                Task {
                    await viewModel.loadCommentCount()
                }
            }
        }
    }
}
