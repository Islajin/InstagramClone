import SwiftUI

//Encodable 을 써주면 밖으로 내보낼 수 있음
//Encodable 이랑 Decodable 합친 것 = Codable
//Identifiable -> id 가 있으니까 각각을 식별할 수 있어, 즉 ProfileView 반복문에서 사용이 가능해
struct Post : Codable , Identifiable{
    let id : String
    let userId: String //User 에 있는 userId가 post에도 뜨게끔 설정
    let caption: String
    var like: Int
    var imageURL: String
    let date: Date
}

