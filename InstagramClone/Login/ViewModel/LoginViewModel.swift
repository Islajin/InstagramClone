//
//  LoginViewModel.swift
//  InstagramClone
//
//  Created by yeonjin on 5/4/25.
//

import Foundation

@Observable
class LoginViewModel {
    var email = ""
    var password = ""
    
    func signin() async {
        
       await AuthManager.shared.signin(email: email, password: password)
        
    }
}
