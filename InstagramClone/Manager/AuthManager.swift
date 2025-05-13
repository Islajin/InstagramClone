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
    
    //어디에서든 접근하던 로그인한 유저를 알 수 있어야 하기 때문에 싱글톤 사용
    static let shared = AuthManager()
    
    
    //User를 감지하는 변수이고 Observable 안에 있기 때문에 감지할 수 있음
    //문제는 앱을 실행할 때마다 nil로 초기화 된다. //Auth는 password랑 email만 관리함
    var currentAuthUser: FirebaseAuth.User?
    
    //CurrentUser 가 nil 이어서 아직
    var currentUser : User?
    
    init() {
        currentAuthUser = Auth.auth().currentUser
        Task {
            await loadCurrentUserData()
        }
    }
    
    func createUser(email: String, password: String, name: String, username: String) async {
        //상위로 async 전달
        
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            currentAuthUser = result.user
            guard let userId = currentAuthUser?.uid else{return}
            
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
        self.currentUser = user
        //회원 가입할때도 currentUser를 장착해줌
        do {
            let encodedUser = try Firestore.Encoder().encode(user)
            
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        }catch {
            
            
        }
    }
    
    func signin(email:String, password: String) async {
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            currentAuthUser = result.user
            await loadCurrentUserData() //로그인하면서 데이터를 가져오기
        }
        
        catch{}
        
    }
    
    func loadCurrentUserData() async {
        //현재의 user의 uid를 userId에 저장함
        guard let userId = self.currentAuthUser?.uid else {return}
        
        //저장소의 users collection에서 userId를 기반으로 키로 설정해서 저장했는데, 그 유저 아이디로 해당 유저만 가져올 수 있도록 불러옴
        //getDocument(as:User.self) -> 내가 스위프트에 만들어놓은 User타입 useriId 를 가져와달라고 쓰는 것임
        do {
            self.currentUser =
            try await Firestore.firestore().collection("users").document(userId).getDocument(as: User.self)
        }
        catch{
            print("DEBUG: Failed to load user data with error \(error.localizedDescription)")
        }
    }
    
    
    func loadUserData(userId: String) async -> User? {
        //전달받은 userId로 찾아야 함
        do {
            
            let user = try await Firestore.firestore().collection("users").document(userId).getDocument(as: User.self)
            return user
        }
        catch{
            print("DEBUG: Failed to load user data with error \(error.localizedDescription)")
            return nil
        }
    }
     
    func loadAllUserData() async -> [User]? {
        do{
            let documents = try await Firestore.firestore().collection("users").getDocuments().documents
            
            let users = try documents.compactMap {document in
                return try document.data(as : User.self)}
            
            return users
        }catch {
            print("DEBUG Failed to load all user data with error \(error.localizedDescription)")
            return nil
        }
    }
    
    func signout() {
        do {
            try Auth.auth().signOut()
            currentAuthUser = nil
            currentUser = nil
            //signout했을 때 nil로 바꿔준다.
            
        }catch{
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
}


extension AuthManager {
    func follow(userId: String?) async {
        guard let currentUserId =  currentUser?.id else {return}
        guard let userId else {return} //  변수명과 비인딩할 변수명이 같으면 이렇게 사용해도 됨
        
        do{
            async let _ = try await Firestore.firestore().collection("following").document(currentUserId).collection("user-follower").document(userId).setData([:])
            
            //async let 을 써주면 동시에 실행하겠다라는 의미 setData([:])는 빈배열을 넣어준 것을 뜻함
            
            async let _ = try await
            Firestore.firestore().collection("follower").document(userId).collection("user-follower").document(currentUserId).setData([:])

            
        }catch {
            print("DEBUG: Failed to save follow data with error \(error.localizedDescription)")
        }
        
    }
    
    func unfollow(userId: String?) async {
        
        guard let currentUserId =  currentUser?.id else {return}
        guard let userId else {return}
        do{
            try await Firestore.firestore().collection("following").document(currentUserId).collection("user-follower").document(userId).delete()

            //async let 을 써주면 동시에 실행하겠다라는 의미 setData([:])는 빈배열을 넣어준 것을 뜻함
            
           try await
            Firestore.firestore().collection("follower").document(userId).collection("user-follower").document(currentUserId).delete()
            
            
        }catch {
            print("DEBUG: Failed to delete follow data with error \(error.localizedDescription)")
        }
        
        
    }
    
    func checkFollow(userId: String?) async -> Bool {
        guard let currentUserId = currentUser?.id else {return false}
        guard let userId else {return false}
        
        do {
            let isFollowing = try await Firestore.firestore()
                .collection("following")
                .document(currentUserId)
                .collection("user-following")
                .document(userId)
                .getDocument().exists
            return isFollowing
        }
        
        catch {
            print("DEBUG :; Failed to check follow data with error \(error.localizedDescription) ")
            return false
        }
    
    }
    
}
