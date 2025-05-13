//
//  SearchView.swift
//  InstagramClone
//
//  Created by yeonjin on 5/10/25.
//

import SwiftUI
import Kingfisher

struct SearchView: View {
    @State var viewModel = SearchViewModel()
    //검색할때의 text 변수
    @State var serachText = ""
    
    //사용자가 입력하지 않으면 전체를 return 하고,
    var fileteredUsers : [User] {
        if serachText.isEmpty {
            return viewModel.users
        }else {
           return viewModel.users.filter {user in
               return user.username.lowercased().contains(serachText.lowercased())
               //lowercased 써주는 이유 - 대소문자 구분없이 검색되도록
            }
           
        }
    }
    
    var body: some View {
        NavigationStack{
            //방법 1
            //        List{
            //            ForEach(fileteredUsers) {user in
            //                Text(user.username)
            //            }}
            
            //방법2
            List(fileteredUsers) {user in
                NavigationLink{
                    ProfileView(viewModel: ProfileViewModel(user: user))
                } label:{
                    HStack {
                        if let imageUrl = user.profileImageUrl {
                            KFImage(URL(string: imageUrl))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 53, height: 53)
                                .clipShape(Circle())
                        }else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width:53, height: 53)
                                .opacity(0.5)
                            
                        }
                        
                        VStack(alignment:.leading){
                            Text(user.username)
                            Text(user.bio ?? "")
                                .foregroundStyle(.gray)
                        }
                    }
                    
                }.listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            //검색기능 추가할때 이렇게
            .searchable(text:$serachText, prompt : "검색")
        }
    }
}

