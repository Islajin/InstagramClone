//
//  CommentManager.swift
//  InstagramClone
//
//  Created by yeonjin on 5/12/25.
//

import Foundation
import Firebase

class CommentManager
{
    //댓글을 업로드 하는 함수
    static func uploadComment (comment : Comment, postId: String) async {
        guard let commentData = try? Firestore.Encoder().encode(comment) else {return}
        
        do {
            try await Firestore.firestore()
                .collection("posts")
                .document(postId)
                .collection("post-comment")
                .addDocument(data: commentData)
        } catch {
            print("DEBUG :: Failed to upload comment with error \(error.localizedDescription)")
        }
        
        
    }
    
    
    //업로드 된 댓글을 가져오는 함수 -> postId에 저장된 모든 댓글을 가져오면 됨
    static func loadComment(postId : String) async -> [Comment] {
        do {
            let documents = try await Firestore.firestore()
                .collection("posts")
                .document(postId)
                .collection("post-comment")
                .order(by : "date", descending: true) //가져운 데이터들을 내림차순으로 정리
                .getDocuments()
                .documents
            
            let comments = documents.compactMap {document in
                try? document.data(as: Comment.self)}
            //가져온 documnets들의 데이터를 Comment 형식으로 바꿔줘
            
            return comments
        }catch {
            print ("DEBUG :Failed to load comment with error \(error.localizedDescription)")
            return []
        }
    }
    
    static func loadCommentCount(postId: String) async-> Int {
        do {let documents = try await Firestore.firestore()
            .collection("posts")
            .document(postId)
            .collection("post-comment")
            .getDocuments()
            .documents
            return documents.count
        }catch {
            print("DEBUG : Failed to load comment count with error \(error.localizedDescription)")
            return 0
        }
    }
}

