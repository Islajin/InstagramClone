//
//  ContentView.swift
//  InstagramClone
//
//  Created by yeonjin on 4/28/25.
//

import SwiftUI

struct ContentView: View {
    
    
    @State var isLogin = false
    @State var signupViewModel = SignupViewModel()
    
    var body: some View {
        if isLogin == true {
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
