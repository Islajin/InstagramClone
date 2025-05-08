//
//  ProfileViewModel.swift
//  InstagramClone
//
//  Created by yeonjin on 5/5/25.
//

import SwiftUI
import Firebase
import PhotosUI
import FirebaseStorage

@Observable
class ProfileViewModel{
    var user : User?
    
    //ProfileEditingView에서 @State 가 아니어서 viewModel.user 로 접근이 안되기때문에 감지되도록 해주기 위해서 변수를 선언한다.
    var name : String
    var username : String
    var bio :String
    var posts : [Post] = []
    
    var selectedItem : PhotosPickerItem?
    var profileImage: Image?
    var uiImage : UIImage?
    
    
    
    init() {
        //init() 안에서 프로퍼티들을 세팅중인데, 한 프로퍼티(user)로 다른 프로퍼티를 세팅하는 걸 금지시켜놓음
        //->이렇게 임시객체에 담아두면,해결됨
        let tempUser = AuthManager.shared.currentUser
        
        self.user = tempUser
        self.name = tempUser?.name ?? ""
        self.username = tempUser?.username ?? ""
        self.bio = tempUser?.bio ?? ""
    }
    
    func convertImage(item: PhotosPickerItem?) async {
        
        //item 을 안전하게 꺼냄 -> data를 컴퓨터가 읽을 수 있는 값으로 변경-> UIImage(UIKit에서 사용하는 이미지 형식)으로 변경->Image(SwiftUI에서 사용하는 이미지 형식)으로 변경
//        
//        guard let item = item else { return }
//        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
//        guard let uiImage = UIImage(data: data) else {return}
//        self.profileImage = Image(uiImage: uiImage)
//        self.uiImage = uiImage
//        
        
        guard let imageSelection = await ImageManager.convertImage(item : item) else {return}
        
        self.profileImage = imageSelection.image
        self.uiImage = imageSelection.uiImage
    }
    
    
    
    func updateUser() async {
        do {
            try await updateUserRemote()
            updateUserLocal()
        }
        catch{}
    }
    
    
    
    //프로필변경에서 name, username, bio 가 수정되었을 때, user을 업데이트 해주는 함수
    func updateUserLocal() {
        //name 이 비어있지 않거나, name이 수정되면 name 변경
        //그리고 swift 는 and를 쉼표로 연결해줄 수 있음
        //not을 나타내는 3가지 방법
        if name != "", name != user?.name {
            user?.name = name}
        
        if username.isEmpty == false, username != user?.username {
            user?.username = username
        }
        
        if !bio.isEmpty, bio != user?.bio {
            user?.bio = bio
        }
    }
    
    //서버에도 추가해주는 코드 사용
    func updateUserRemote() async throws{ // 마지막 if 문의 try 와 await를 상위로 올림
        
        //dictionary 를 초기화
        var editedData : [String : Any] = [:]
        
        if name != "", name != user?.name {
            editedData["name"] = name
        }
        
        if username.isEmpty == false, username != user?.username {
            editedData["username"] = username
        }
        
        if !bio.isEmpty, bio != user?.bio {
            editedData["bio"] = bio
        }
        
        //만약에 let uiImage가 self.ui 이미지에 잘 저장이 된다면
        if let uiImage = self.uiImage {
//            let imageUrl = await uploadImage(uiImage: uiImage)
            
//            guard let imageUrl = await ImageManager.uploadImage(uiImage: uiImage, path :"profiles") else {return}
//            
            guard let imageUrl = await ImageManager.uploadImage(uiImage: uiImage, path :.profile) else {return}
            
            editedData["profileImageUrl"] = imageUrl
            
        }
        //  editedData의 딕셔너리가 비어있지 않으면 파이어베이스에 업데이트시키자
        if !editedData.isEmpty , let userId = user?.id {
            try await Firestore.firestore().collection("users").document(userId).updateData(editedData)
            
        }
    }
    
    //Image를 서버에 저장해주는 함수
    func uploadImage(uiImage : UIImage) async -> String? {
        
        //uiImage를 받아서 jpeg파일을 0.5의 퀄리티로 압축
        guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else { return nil }
        //fileName = 파일 이름을 UUID().uuidString - 파일의 랜덤한 문구를 정해줌
        let fileName =  UUID().uuidString
        
        //이걸 스토리지에 저장하려면 .reference 로 사진이 저장될 위치를 설정- 이미지라는 폴더 내에 파일 이름으로 스토리지에 저장해 달라는 것임, 해당 위치를 reference 변수에 담음
        let reference = Storage.storage().reference (withPath: "/profileimage/\(fileName)")
        
        
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
    
    //posts 에서 userId가 현재 Id 와 같은 것들을 가져옴 - 즉, 내 게시글을 보여줌
    func loadUserPosts() async {
        //whereField 를 사용해서 같은 걸 찾을 수 있음
        //.order by(by: , 오름차순 내림차순 설정이 가능)
        do {
            let documents = try await Firestore.firestore().collection("posts").order(by: "date", descending: true).whereField("userId", isEqualTo: user?.id ?? "").getDocuments().documents
            
            var posts : [Post] = []
            //documents 가 여러개 들어있을 거니까 반복문
            for document in documents {
                //document data를 post타입으로 바꾸겠음!
                let post = try document.data(as: Post.self)
                //그래서 배열안에 저장 할 것 임
                posts.append(post)
                
                self.posts = posts
                //함수 안에서 변형한 posts를 바깥에 있는 self.posts에 넣음
            }
        }catch{
            print("DEBUG: Failed to load user posts with error \(error.localizedDescription)")
        }
        
    }
}
