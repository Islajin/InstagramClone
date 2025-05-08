//
//  ContentView.swift
//  InstagramClone
//
//  Created by yeonjin on 4/28/25.
//

import SwiftUI
import FirebaseAuth
struct ContentView: View {
    

    @State var signupViewModel = SignupViewModel()
    
    var body: some View {
        //currentUser 은 State 나 Observable 이런게 세팅이 안되어 있기 때문에 바로바로 SwiftUI가 알 수 없다.
        //때문에 signupViewModel에서 정의한 UserSession 을 가져오면 뷰에서 감지가 가능하다.
        //currentAuteUser은 감지가 되어서 화면이 바뀌지만, Current User 가 nil 이어서 아직 그 유저에 대한 정보를 가져올 수 없음
        //currentAuthUser 말고 currentUser로 MaintabView()를 판단하자
        if AuthManager.shared.currentUser != nil {
            MainTabView()
        }
        else {
            LoginView()
                .environment(signupViewModel)
        }
       
    }
}

#Preview {
    ContentView()
}
