//
//  PostManager.swift
//  InstagramClone
//
//  Created by yeonjin on 5/10/25.
//

import Foundation
import FirebaseFirestore

class PostManager {
    //모든 사람이 올린 게시글을 볼 수 있도록 하는 함수
    static func loadAllPosts() async -> [Post]? {
        
        do {
            let documents = try await Firestore.firestore().collection("posts").order(by: "date", descending: true).getDocuments().documents
            let posts = try documents.compactMap({document in
                return try document.data(as: Post.self)})
            return posts
        }catch{
            print("DEBUG: Failed to load all posts with error \(error.localizedDescription)")
            return nil
        }
        
        
    }
    
    
    //posts 에서 userId가 현재 Id 와 같은 것들을 가져옴 - 즉, 내 게시글을 보여줌
    static func loadUserPosts(userId: String) async -> [Post]? {
        //whereField 를 사용해서 같은 걸 찾을 수 있음
        //.order by(by: , 오름차순 내림차순 설정이 가능)
        do {
            let documents = try await Firestore.firestore().collection("posts").order(by: "date", descending: true).whereField("userId", isEqualTo: userId ).getDocuments().documents
            
            var posts : [Post] = []
            //documents 가 여러개 들어있을 거니까 반복문
            for document in documents {
                //document data를 post타입으로 바꾸겠음!
                let post = try document.data(as: Post.self)
                //그래서 배열안에 저장 할 것 임
                posts.append(post)
            }
            
            return posts
            //함수 안에서 변형한 posts를 바깥에 있는 self.posts에 넣음
            
        }catch{
            print("DEBUG: Failed to load user posts with error \(error.localizedDescription)")
            return nil
        }
        
    }
}

extension PostManager {
    //Post와 User 데이터 베이스에 다 접근해야함
    static func like(post : Post) async {
        guard let userId =  AuthManager.shared.currentUser?.id else {return}
        
        //해당 컬렉션에 접근할 수 있도록 해서 나중에 쓰기 편하게 변수를 따로 빼둔것임
        let postsCollection = Firestore.firestore().collection("posts")
        let usersCollection = Firestore.firestore().collection("users")
        
        async let _ = usersCollection.document(userId).collection("user-like").document(post.id).setData([:])
        
        async let _ =
        postsCollection.document(post.id).collection("post-like").document(userId).setData([:])
        async let _ =
        postsCollection.document(post.id).updateData(["like": post.like + 1])
        
        
    }
    
    static func unlike(post: Post) async {
        
        guard let userId =  AuthManager.shared.currentUser?.id else {return}
        
        //해당 컬렉션에 접근할 수 있도록 해서 나중에 쓰기 편하게 변수를 따로 빼둔것임
        let postsCollection = Firestore.firestore().collection("posts")
        let usersCollection = Firestore.firestore().collection("users")
        
        async let _ = usersCollection.document(userId).collection("user-like").document(post.id).delete()
        
        async let _ =
        postsCollection.document(post.id).collection("post-like").document(userId).delete()
        async let _ =
        postsCollection.document(post.id).updateData(["like": post.like - 1])
        
        
    }
    
    static func checkLike(post: Post) async -> Bool{
        
        //like 는 어떤 컬렉션에 접근해서 살펴봐도 됨 유저 컬렉션에 접근해서
        guard let userId =  AuthManager.shared.currentUser?.id else {return false}
        
        do {
            let isLike = try await Firestore.firestore()
                .collection("users")
                .document(userId)
                .collection("user-like")
                .document(post.id)
                .getDocument()
                .exists
            
            return isLike
            
        }catch{
            print("DEBUG : Failed to check like with error \(error.localizedDescription)")
            return false
        }
    }
    
}

