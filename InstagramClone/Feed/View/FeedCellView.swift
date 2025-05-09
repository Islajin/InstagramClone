//
//  FeedCellView.swift
//  InstagramClone
//
//  Created by yeonjin on 5/9/25.
//

import SwiftUI

struct FeedCellView: View {
    var body: some View {
        VStack {
            Image("image_dragon2")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .overlay (alignment: .top){
                    HStack {
                        Image("image_lion4")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(Color(red : 191/255, green: 11/255, blue:100/255), lineWidth: 2)
                            }
                        Text("general.cat")
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
            
            Text("좋아요 25,239개")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Text("general.cat" + " " + "상세 글 정보")
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

#Preview {
    FeedCellView()
}
