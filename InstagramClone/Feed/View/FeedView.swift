//
//  FeedView.swift
//  InstagramClone
//
//  Created by yeonjin on 5/9/25.
//

import SwiftUI

struct FeedView: View {
    
    @State var viewModel = FeedViewModel()
    
    var body : some View {
        
        NavigationStack{
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
                        Image(systemName: "paperplane")
                            .imageScale(.large)
                        
                    }
                    .padding(.horizontal)
                    
                    LazyVStack {
                        ForEach(viewModel.posts) {post in
                            let _ = print(post)
                            //반복문 내에세 프린트를 실행하고 싶으면 이렇게 쓰면 됨
                            FeedCellView(post: post)
                            //FeedCellView에 반복으로 모든 post 값 넘겨주기
                        }
                    }
                    
                    Spacer()
                }
            }
            //스크롤 뷰를 당겨서 업데이트 된 포스트를 보고 싶을 때
            .refreshable {
                await viewModel.loadAllPosts( )
            }
            
            //이건 바로바로 업데이트가 됨
            .task{
                await viewModel.loadAllPosts( )
            }
        }
    }
}

#Preview {
    FeedView()
}
