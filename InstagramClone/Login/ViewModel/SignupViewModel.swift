//
//  SignupViewModel.swift
//  InstagramClone
//
//  Created by yeonjin on 5/3/25.
//

import Foundation
import FirebaseAuth

@Observable
class SignupViewModel {
    
    var email = ""
    var password = ""
    var name = ""
    var username = ""
 
    func createUser() async {
        await AuthManager.shared.createUser(email: email, password: password, name: name, username: username)
        
        email = ""
        password = ""
        name = ""
        username = ""  
    }
}
