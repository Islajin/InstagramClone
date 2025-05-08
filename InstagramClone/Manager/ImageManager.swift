//
//  ImageManager.swift
//  InstagramClone
//
//  Created by yeonjin on 5/8/25.
//


import SwiftUI
import PhotosUI
import FirebaseStorage

//리턴 타입이 두개인데, 하나처럼 쓰려면 모델을 만들어서 묶어서 전달하면 됨
struct ImageSelection {
    
    let image : Image
    let uiImage : UIImage
}


enum ImagePath{
    case post
    case profile
    
}
class ImageManager {
    static func convertImage(item: PhotosPickerItem?) async -> ImageSelection? {

        //item 을 안전하게 꺼냄 -> data를 컴퓨터가 읽을 수 있는 값으로 변경-> UIImage(UIKit에서 사용하는 이미지 형식)으로 변경->Image(SwiftUI에서 사용하는 이미지 형식)으로 변경
        
        guard let item = item else { return nil }
        guard let data = try? await item.loadTransferable(type: Data.self) else {return nil}
        guard let uiImage = UIImage(data: data) else {return nil}
        let image = Image(uiImage: uiImage)
        
        //profile에서만 사진 선택하는 게 아니고, 게시글에 올리는 사진도 해당 함수를 가져다 쓸 것이기 때문에 profileImage 에서 image로 이름을 변경
        let imageSelection = ImageSelection(image: image, uiImage: uiImage )
        
        return imageSelection
        
    }
    
    static func uploadImage(uiImage : UIImage, path : ImagePath) async -> String? {
        
        //NewPostViewModel이랑 PostViewModel에서 똑같이 uploadImage를 사용하는데, 파이어베이스로 넘기는 path 가 다르기 때문에 인자로 넣어주면 됨
        
        //uiImage를 받아서 jpeg파일을 0.5의 퀄리티로 압축
        guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else { return nil }
        //fileName = 파일 이름을 UUID().uuidString - 파일의 랜덤한 문구를 정해줌
        let fileName =  UUID().uuidString
        
        //이걸 스토리지에 저장하려면 .reference 로 사진이 저장될 위치를 설정- 이미지라는 폴더 내에 파일 이름으로 스토리지에 저장해 달라는 것임, 해당 위치를 reference 변수에 담음
        
        var imagePath : String = ""
//        if path == ImagePath.post {
//            
//            imagePath = "Images"
//        } else {
//         //path == ImagePath.profile
//            imagePath = "profiles"
//        }
        
        switch path {
        case.post : imagePath = "Images"
        case.profile : imagePath = "profiles"
        }
       
        let reference = Storage.storage().reference(withPath: "/\(imagePath)/\(fileName)")
        
        
        do{ //putDataAsync 와 downloadURL 모두 Async 로 Task 가 필요한데, 그냥 상위로 넘김
            //reference에 우리가 압축한 이미지 데이터를 넣어줌, metaData는 이미지 정보를 가짐
            let metaData = try await reference.putDataAsync(imageData)
            print("metaData: ", metaData)
            
            //이미지가 올라간 거를 게시글에 저장할껀데, 데이터는 이 이미지 스토리지에 저장하고, 이미지가 올라간 url만 이 게시글에 저장해 놓도록 할꺼임
            let url = try await reference.downloadURL()
            
            return url.absoluteString
        }
        catch {
            print("\(error.localizedDescription)")
            return nil
        }

    }
    
    
}



