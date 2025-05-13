//
//  Comment.swift
//  InstagramClone
//
//  Created by yeonjin on 5/12/25.
//

import Foundation

struct Comment : Codable, Identifiable{
    let id : String
    let commentText : String
    
    let postId : String
    let postUserId : String
    
    let commentUserId : String
    var commentUser : User?
    
    let date: Date
}
