import SwiftUI

struct LoginView: View {
    let yellowColor = Color(red: 0.9960784314, green: 0.9764705882, blue: 0.9529411765)
    let redColor = Color(red: 0.9921568627, green: 0.9490196078, blue: 0.9725490196)
    let blueColor = Color(red: 0.9333333, green: 0.968627451, blue: 0.9960784314)
    let greenColor = Color(red: 0.937254902, green: 0.9882352941, blue: 0.9529411765)
    
    var body: some View {
        
        ZStack {
            LinearGradient(stops: [
                Gradient.Stop(color: yellowColor, location: 0.1),
                Gradient.Stop(color: redColor, location: 0.3),
                Gradient.Stop(color: blueColor, location: 0.6),
                Gradient.Stop(color: greenColor, location: 1),
            ], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack{
                Spacer()
                
                Image("instagramLogo")
                    .resizable()
                    .frame(width:57, height: 57)
                    .scaledToFit()
                
                Spacer()
                
                VStack {
                    TextField("이메일 주소", text: .constant(""))
                        .textInputAutocapitalization(.never) //대문자 방지
                        .padding(12)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray, lineWidth: 1.0)
                        }
                        .padding(.horizontal)
                    
                    
                    SecureField("비밀번호", text: .constant(""))
                        .textInputAutocapitalization(.never) //대문자 방지
                        .padding(12)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray, lineWidth: 1.0)
                        }
                        .padding(.horizontal)
                    
                    Button{
                    } label:{
                        Text("로그인")
                            .frame(width: 363, height: 42)
                            .foregroundStyle(.white)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                    }.padding()
                    
                    Text("비밀번호를 잊으셨나요?")
                }
                
                Spacer()
                Button{}label:{
                    Text("새 계정 만들기")
                        .fontWeight(.bold)
                        .frame(width: 363, height: 42)
                        .overlay{
                            RoundedRectangle(cornerRadius : 20)
                                .stroke(.blue, lineWidth: 1.0)
                        }
                        .foregroundStyle(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
            }
        }
        
        
    }
}

#Preview {
    LoginView()
}
