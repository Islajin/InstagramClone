import SwiftUI

//Encodable 을 써주면 밖으로 내보낼 수 있음
//Encodable 이랑 Decodable 합친 것 = Codable
struct Post : Codable {
    let id : String
    let caption: String
    var like: Int
    var imageURL: String
    let date: Date
}

