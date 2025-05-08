import SwiftUI
import PhotosUI
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift


@Observable
class NewPostViewModel {
    var caption = ""
    var selectedItem : PhotosPickerItem?
    var postImage: Image?
    var uiImage : UIImage?
    
    
    func convertImage(item: PhotosPickerItem?) async {
        
        //item 을 안전하게 꺼냄 -> data를 컴퓨터가 읽을 수 있는 값으로 변경-> UIImage(UIKit에서 사용하는 이미지 형식)으로 변경->Image(SwiftUI에서 사용하는 이미지 형식)으로 변경
//        
//        guard let item = item else { return }
//        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
//        guard let uiImage = UIImage(data: data) else {return}
//        self.postImage = Image(uiImage: uiImage)
//        self.uiImage = uiImage
        
        guard let imageSelection = await ImageManager.convertImage(item: item) else { return }
        self.postImage = imageSelection.image
        self.uiImage = imageSelection.uiImage
    }
    
    
    
    //게시글 업로드 함수 (게시글 : 글 + 사진)
    func uploadPost() async {
        guard let uiImage else {return}
        
//        guard let imageUrl = await uploadImage(uiImage: uiImage) else {return} -> 리팩토링해서 밑에 있는 코드로 변경
//        guard let imageUrl = await ImageManager.uploadImage(uiImage : uiImage, path : "images") else { return }
//        위의 코드에서 path 를 enum 타입으로 받을 때 변경된 코드
        
        guard let imageUrl = await ImageManager.uploadImage(uiImage : uiImage, path : .post) else { return }
        
        //유저 아이디를 가져와서 사용자가 글이랑 사진을 저장할때마다 firebase에 게시글이 업로드 됨
        guard let userId = AuthManager.shared.currentAuthUser?.uid else {return}
        
        // postReference = 포스트에 저장할 위치 정보를 가짐
        let postReference = Firestore.firestore().collection("posts").document()
        
        let post = Post(id: postReference.documentID, userId: userId, caption: caption, like: 0, imageURL: imageUrl, date: Date())
        
        do{
            //swift에서 쓴 것을 firebase로 내보내야하니까 인코딩을 씀
            let encodedData =  try Firestore.Encoder().encode(post)
            try await postReference.setData(encodedData)
        }
        catch
        {print("\(error.localizedDescription)")}
        
        
        
    }
    
    
    //사진 업로드 함수
    //사진 업로드 시에 UI 이미지가 필요하고, 우리가 사진을 올린 주소를 리턴 값으로 받을 것임(옵셔널 String? )
    //여기도 Task로 감싸지 않고, 상위로 넘김
    func uploadImage(uiImage : UIImage) async -> String? {
        
        //uiImage를 받아서 jpeg파일을 0.5의 퀄리티로 압축
        guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else { return nil }
        //fileName = 파일 이름을 UUID().uuidString - 파일의 랜덤한 문구를 정해줌
        let fileName =  UUID().uuidString
        
        //이걸 스토리지에 저장하려면 .reference 로 사진이 저장될 위치를 설정- 이미지라는 폴더 내에 파일 이름으로 스토리지에 저장해 달라는 것임, 해당 위치를 reference 변수에 담음
        let reference = Storage.storage().reference (withPath: "/images/\(fileName)")
        
        
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
    
    func clearData() {
        caption = ""
        selectedItem = nil
        postImage = nil
        uiImage = nil
    }
    
    
}
