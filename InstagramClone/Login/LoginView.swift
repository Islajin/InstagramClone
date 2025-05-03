import SwiftUI

struct LoginView: View {
    
    var body: some View {
        
        ZStack {
            GradientBackgroundView()
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
