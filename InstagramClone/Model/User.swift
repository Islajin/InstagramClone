//
//  User.swift
//  InstagramClone
//
//  Created by yeonjin on 5/3/25.
//

import Foundation

struct User: Codable{
    
    let id : String
    let email: String
    var username: String
    var name: String
    var bio: String?
    var profileImageUrl: String?
}
