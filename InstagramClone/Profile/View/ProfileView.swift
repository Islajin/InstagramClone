//
//  ProfileView.swift
//  InstagramClone
//
//  Created by yeonjin on 5/4/25.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    @State var viewModel = ProfileViewModel()
 
    
    let columns : [GridItem] = [
        GridItem(.flexible(), spacing:2),
        GridItem(.flexible(), spacing:2),
        GridItem(.flexible(), spacing:2)
        
    ]
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    //viewModel.user?.username ?? ""으로 바로 접근하는게 아닌 바깥으로 빼 놓은 viewModel.username 에 접근해야 ProfileeditingView와 ProfileView가 접근하는게 동일해진다.
                    
                    //밑에 접근하는 것들도 동일한 방식으로 접근
                    Text("\(viewModel.username)")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    HStack{
                        if let profileImage = viewModel.profileImage{
                            profileImage
                                .resizable()
                                .frame(width:75 ,height:75)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                            
                        }else if let imageUrl = viewModel.user?.profileImageUrl{  // 서버에 있는지를 체크해야함
                            let url = URL(string: imageUrl)
                  
                            KFImage(url)
                                .resizable()
                                .frame(width:75 ,height:75)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                        }
                        else {
                            Image(systemName : "person.circle.fill")
                                .resizable()
                                .frame(width:75 ,height:75)
                                .foregroundStyle(Color.gray.opacity(0.5))
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                        }
                        
                        VStack{
                            Text("124")
                                .fontWeight(.semibold)
                            Text("게시물")
                        } .frame(maxWidth: .infinity)
                        
                        VStack{
                            Text("124")
                                .fontWeight(.semibold)
                            Text("팔로워")
                        } .frame(maxWidth: .infinity)
                        
                        
                        VStack{
                            Text("124")
                                .fontWeight(.semibold)
                            Text("팔로잉")
                        } .frame(maxWidth: .infinity)
                        
                    }.padding(.horizontal)
                    
                    Text("\(viewModel.name)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Text("\(viewModel.bio)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    NavigationLink{
                        ProfileEditingView(viewModel: viewModel)
                    }label:{
                        Text("프로필 편집")
                            .bold()
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 35)
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.horizontal)
                            .padding(.top, 10)
                    }
                    Divider()
                        .padding()
                    
                    LazyVGrid(columns: columns, spacing:2) {
                        
                        ForEach(viewModel.posts) {post in
                            let url = URL(string:post.imageURL)
                            KFImage(url)
                                .resizable()
                                .aspectRatio(1, contentMode:.fill )
                        }
                    }
                    // .onAppear()은 async 가 아닌 것들 .task 는 asyvc 인 것들
                    .task {
                        await viewModel.loadUserPosts()
                    }
                    Spacer()
                    
                }
                
            }
        }
    }
}

#Preview {
    ProfileView()
}
