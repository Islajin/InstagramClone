//
//  FeedViewModel.swift
//  InstagramClone
//
//  Created by yeonjin on 5/9/25.
//

import Foundation
import Firebase

@Observable
class FeedViewModel {
    
    var posts: [Post] = []
    
    //FeedView에서 feedviewModel이 생성될 때 함수가 싱행되도록 하려면 초기화
    init() {
        Task {
            await loadAllPosts()
            
        }
    }
    
    //모든 사람이 올린 게시글을 볼 수 있도록 하는 함수
    func loadAllPosts() async {
        guard let posts = await PostManager.loadAllPosts() else {return}
        self.posts = posts
        
//            do {
//                let documents = try await Firestore.firestore().collection("posts").order(by: "date", descending: true).getDocuments().documents
//        
//                // 방법 1
//                var posts : [Post] = []
//                //documents 가 여러개 들어있을 거니까 반복문
//                for document in documents {
//                    //document data를 post타입으로 바꾸겠음!
//                    let post = try document.data(as: Post.self)
//                    //그래서 배열안에 저장 할 것 임
//                    posts.append(post)
//                }
//                
//                    self.posts = posts
//                    //함수 안에서 변형한 posts를 바깥에 있는 self.posts에 넣음
//
//                
//////                방법 2 map은 반복문을 해서 리턴까지 해줌
////                self.posts = try documents.map({document in
////                    return try document.data(as: Post.self)})
//                
////                //방법 3 compactMap-> nil이 있으면 패스하고 다음 것 사용함
////                self.posts = try documents.compactMap({document in
////                    return try document.data(as: Post.self)})
//                
//            }catch{
//                print("DEBUG: Failed to load all posts with error \(error.localizedDescription)")
//            }
        
        
    }
}
