//
//  User.swift
//  InstagramClone
//
//  Created by yeonjin on 5/3/25.
//

import Foundation
import FirebaseAuth

struct User: Codable{
    
    let id : String
    let email: String
    var username: String
    var name: String
    var bio: String?
    var profileImageUrl: String?
    
    var isFollowing : Bool?
    
    //다른 사람 프로필 들어갔을 때는 팔로우 버튼이 뜨도록 할껀데, 그렇게 하려면 현재 로그인된 유저인지 아닌지를 먼저 판단해야 함 -> 어차피 인자를 받지 않고, 내부에 있는 값으로 비교할 것이라서 computed property를 만들어 주면 된다.
    
    var isCurrentUser : Bool {
//        guard let currentUserId = Auth.auth().currentUser?.uid else {return false} 밑에랑 가져오는게 동일함
        guard let currentUserId = AuthManager.shared.currentUser?.id else {return false}
//        if id == currentUserId {
//            return true
//        }
//        else {
//            return false
//        }
   
        return id == currentUserId //id 비교했는데 똑같으면 true 아니면 false
    }
}
