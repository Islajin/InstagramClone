import SwiftUI
import PhotosUI

@Observable
class NewPostViewModel {
    var caption = ""
    var selectedItem : PhotosPickerItem?
    var postImage: Image?
    
    func convertImage(item: PhotosPickerItem?) async {
        
        //item 을 안전하게 꺼냄 -> data를 컴퓨터가 읽을 수 있는 값으로 변경-> UIImage(UIKit에서 사용하는 이미지 형식)으로 변경->Image(SwiftUI에서 사용하는 이미지 형식)으로 변경
        
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else {return}
        self.postImage = Image(uiImage: uiImage)
        
        
    }
}
