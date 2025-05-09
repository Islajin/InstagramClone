//
//  FeedCellViewModel.swift
//  InstagramClone
//
//  Created by yeonjin on 5/9/25.
//

import Foundation

@Observable
class FeedCellViewModel {
    
    var post : Post
    
    init(post: Post){
        self.post = post
        
        Task {
            await loadUserData()
        }
    }
    
    //전체 게시글을 가져올때, 화면에 띄워줘야하는 username 이랑 profileImageUrl 때문에 userId를 연동하고 있는 것임
    func loadUserData() async {
        let userId = post.userId
        guard let user = await AuthManager.shared.loadUserData(userId: userId) else {return}
        post.user = user
        
    }
    
}
