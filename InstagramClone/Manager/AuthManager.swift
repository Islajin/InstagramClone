//
//  AuthManager.swift
//  InstagramClone
//
//  Created by yeonjin on 5/3/25.
//

import Foundation
import FirebaseAuth
import Firebase

@Observable
class AuthManager {
    
    static let shared = AuthManager()
    
    
    //User를 감지하는 변수이고 Observable 안에 있기 때문에 감지할 수 있음
    //문제는 앱을 실행할 때마다 nil로 초기화 된다.
    var currentUserSession: FirebaseAuth.User?
    
    init() {
        currentUserSession = Auth.auth().currentUser
    }
    
    func createUser(email: String, password: String, name: String, username: String) async {
        //상위로 async 전달
        
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            currentUserSession = result.user
            guard let userId = currentUserSession?.uid else{return}
            
            Task{
                await uploadUserData(userId: userId, email: email, username: username, name: name)
            }
        }catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
        
    }
    func uploadUserData(userId: String, email: String, username: String, name: String) async
    {
        let user = User(id: userId, email: email, username: username, name: name)
        
        do {
            let encodedUser = try Firestore.Encoder().encode(user)
            
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        }catch {
            
            
        }
    }
    
    func signout() {
        do {
            try Auth.auth().signOut()
            currentUserSession = nil //signout했을 때 nil로 바꿔준다.
            
        }catch{
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
}
