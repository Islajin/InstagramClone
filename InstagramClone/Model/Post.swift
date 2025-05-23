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
    
    //서버에서 계속 가져오는 건 비효율적이라서 이럻게 변수에 저장해서 사용하는 것이 좋음
    var isLike : Bool?
    var user: User?
    //FeedCellView에서 User의 정보가 필요하기 떄문에 userId를 키 값으로 사용해서 user를 찾은 다음에 User에 해당 하는 값을 저장해주자.
}


