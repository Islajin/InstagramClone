//
//  ProfileEditingView.swift
//  InstagramClone
//
//  Created by yeonjin on 5/4/25.
//

import SwiftUI
import PhotosUI
import Kingfisher


struct ProfileEditingView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var viewModel : ProfileViewModel
    
    var body: some View {
        VStack{
            PhotosPicker(selection: $viewModel.selectedItem) {
                
                VStack{
                    
                    if let profileImage = viewModel.profileImage{
                        profileImage
                            .resizable()
                            .frame(width:75 ,height:75)
                            .clipShape(Circle())
                            .padding(.bottom, 10)
                        
                    }else if let imageUrl = viewModel.user?.profileImageUrl{  // 서버에 있는지를 체크해야함
                        let url = URL(string: imageUrl)
                        //Kingfisher import 하면 자동으로 캐싱됨
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
                    
                    Text("사진 또는 아바타 수정")
                        .foregroundStyle(.blue)
                }
            }
            .onChange (of: viewModel.selectedItem) {oldValue, newValue in
                Task{
                    await viewModel.convertImage(item: newValue)
                }
                
            }// selectedItem이 변한 걸 감지해서 그때 onchange 됨
            
            VStack(alignment: .leading, spacing:5){
                Text("이름")
                    .foregroundStyle(.gray)
                    .fontWeight(.bold)
                
                TextField("이름", text: $viewModel.name )
                    .font(.title2)
                
                Divider()
            }.padding(.horizontal)
                .padding(.top,10)
            
            VStack(alignment: .leading, spacing:5){
                Text("사용자 이름")
                    .foregroundStyle(.gray)
                    .fontWeight(.bold)
                
                TextField("사용자 이름", text: $viewModel.username)
                    .font(.title2)
                
                Divider()
            }.padding(.horizontal)
                .padding(.top,10)
            
            
            VStack(alignment: .leading, spacing:5){
                Text("소개")
                    .foregroundStyle(.gray)
                    .fontWeight(.bold)
                
                TextField("소개", text: $viewModel.bio)
                    .font(.title2)
                
                Divider()
            }.padding(.horizontal)
                .padding(.top,10)
            
            Spacer()
            
        }
        .navigationTitle("프로필 편집")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                Button{
                    Task {
                        await viewModel.updateUser()
                        dismiss()
                        //Task 안에 dismiss 를 써줘야 정보가 업데이트 되어야 뒤로가짐
                    }
                    
                }label:{
                    Image(systemName: "arrow.backward")
                        .tint(.black)
                    
                }
                
            }
        }
    }
}

#Preview {
    ProfileEditingView(viewModel : ProfileViewModel() )
}
