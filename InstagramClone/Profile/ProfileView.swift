//
//  ProfileView.swift
//  InstagramClone
//
//  Created by yeonjin on 5/4/25.
//

import SwiftUI

struct ProfileView: View {
    
    let columns : [GridItem] = [
        GridItem(.flexible(), spacing:2),
        GridItem(.flexible(), spacing:2),
        GridItem(.flexible(), spacing:2)
        
    ]
    var body: some View {
        ScrollView {
            VStack {
                Text("general.cat")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                HStack{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width:75, height: 75)
                        .opacity(0.6)
                        .frame(maxWidth: .infinity)
                    
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
                
                Text("여기는 이름을 쓰는 공간")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Text("여기는 소개글을 쓰는 공간")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Button{}label:{
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
                    ForEach(0..<10){ _ in
                        Image("image_dog")
                            .resizable()
                            .scaledToFit()
                        Image("image_dog")
                            .resizable()
                            .scaledToFit()
                        Image("image_dog")
                            .resizable()
                            .scaledToFit()
                    }
                }
                
                Spacer()
                
            }
            
        }
    }
}

#Preview {
    ProfileView()
}
