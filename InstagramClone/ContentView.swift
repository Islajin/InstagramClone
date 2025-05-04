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
        if AuthManager.shared.currentAuthUser != nil {
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
