//
//  NewPostView.swift
//  InstagramClone
//
//  Created by yeonjin on 4/28/25.
//

import SwiftUI
import PhotosUI

struct NewPostView: View {
    
    @State var viewModel = NewPostViewModel()
    @Binding var tabIndex: Int
    
    
    var body: some View {
        VStack(){
            HStack{
                Button{
                    tabIndex = 0
                }
                label:{
                    Image(systemName: "chevron.left")
                        .tint(.black)
                }
               Spacer()
                Text("새 게시물")
                    .font(.title2)
                    .fontWeight(.semibold)
            Spacer()
                
            }.padding(.horizontal
            )
            
            PhotosPicker (selection: $viewModel.selectedItem ){
                
                if let image = self.viewModel.postImage {
                    // self.postImage 가 nil 이 아니면, photosPicker로 사진을 장착한 후
                    image
                        .resizable()
                        .aspectRatio(1, contentMode:.fill)
                        .frame(maxWidth: .infinity, maxHeight: 400)
                        .clipped()
                    
                } else {
                    //장착 전
                    Image(systemName: "photo.on.rectangle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding()
                        .tint(.black)
                    
                    
                    
                }
                
                
            }.onChange (of: viewModel.selectedItem) {oldValue, newValue in
                Task{
                    await viewModel.convertImage(item: newValue)
                }
                
            }

            TextField("문구를 작성하거나 설문을 추가하세요.", text: $viewModel.caption)
                .padding()
            
            Spacer()
            
            Button{
                Task{
                    await viewModel.uploadPost()
                }
                
            } label:{
                Text("공유")
                    .frame(width: 363, height: 42)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
            }.padding()
            

            
          
        }
        
    }
}

#Preview {
    NewPostView(tabIndex : .constant(0))
}
