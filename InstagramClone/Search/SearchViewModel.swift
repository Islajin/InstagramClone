//
//  SearchViewModel.swift
//  InstagramClone
//
//  Created by yeonjin on 5/10/25.
//

import SwiftUI

@Observable
class SearchViewModel {
    var users: [User] = []
    
    init() {
        Task{
            //실행시에 loadAllUserData 가 실행됨
            await loadAllUserData()
        }
    }
    
    //AuthManager에서 모든 유저 정보를 가진 함수를 users에 저장하는 함수
    func loadAllUserData() async {
        self.users = await AuthManager.shared.loadAllUserData() ?? []
    }
    
}

