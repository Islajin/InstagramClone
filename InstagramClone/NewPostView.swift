//
//  NewPostView.swift
//  InstagramClone
//
//  Created by yeonjin on 4/28/25.
//

import SwiftUI
import PhotosUI

struct NewPostView: View {
    
    @State var caption = ""
    @Binding var tabIndex: Int
    @State var selectedItem : PhotosPickerItem?
    @State var postImage: Image?
    
    func convertImage(item: PhotosPickerItem?) async {
        
        //item 을 안전하게 꺼냄 -> data를 컴퓨터가 읽을 수 있는 값으로 변경-> UIImage(UIKit에서 사용하는 이미지 형식)으로 변경->Image(SwiftUI에서 사용하는 이미지 형식)으로 변경
        
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else {return}
        self.postImage = Image(uiImage: uiImage)
        
        
    }
    
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
            
            PhotosPicker (selection: $selectedItem ){
                
                if let image = self.postImage {
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
                
                
            }.onChange (of: selectedItem) {oldValue, newValue in
                Task{
                  await convertImage(item: newValue)
                }
                
            }

            TextField("문구를 작성하거나 설문을 추가하세요.", text: $caption)
                .padding()
            
            Spacer()
            
            Button{} label:{
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
