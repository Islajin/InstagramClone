//
//  FeedViewModel.swift
//  InstagramClone
//
//  Created by yeonjin on 5/9/25.
//

import Foundation

@Observable
class FeedViewModel {
    
    var posts: [Post] = []
    
    //모든 사람이 올린 게시글을 볼 수 있도록 하는 함수
    func loadAllPosts() async {
        
    }
}

////posts 에서 userId가 현재 Id 와 같은 것들을 가져옴 - 즉, 내 게시글을 보여줌
//func loadUserPosts() async {
//    //whereField 를 사용해서 같은 걸 찾을 수 있음
//    //.order by(by: , 오름차순 내림차순 설정이 가능)
//    do {
//        let documents = try await Firestore.firestore().collection("posts").order(by: "date", descending: true).whereField("userId", isEqualTo: user?.id ?? "").getDocuments().documents
//        
//        var posts : [Post] = []
//        //documents 가 여러개 들어있을 거니까 반복문
//        for document in documents {
//            //document data를 post타입으로 바꾸겠음!
//            let post = try document.data(as: Post.self)
//            //그래서 배열안에 저장 할 것 임
//            posts.append(post)
//            
//            self.posts = posts
//            //함수 안에서 변형한 posts를 바깥에 있는 self.posts에 넣음
//        }
//    }catch{
//        print("DEBUG: Failed to load user posts with error \(error.localizedDescription)")
//    }
//    
//}
//}
