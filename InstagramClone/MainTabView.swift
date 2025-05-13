import SwiftUI
import FirebaseAuth

struct MainTabView: View {
    
    @State var tabIndex = 0
    
    var body: some View {
        TabView(selection: $tabIndex){
//            Text("feed")
            FeedView()
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(0)
           SearchView()
                .tabItem{
                    Image(systemName: "magnifyingglass")
                }.tag(1)
            NewPostView(tabIndex : $tabIndex)
                .tabItem{
                    Image(systemName: "plus.square")
                }.tag(2)
            
            VStack {
                Text("Reels")
                Button{
                    AuthManager.shared.signout()
                }label:{
                    Text("Logout")
                }
            }
                .tabItem{
                    Image(systemName: "movieclapper")
                }.tag(3)
            
            ProfileView()
                .tabItem{
                    Image(systemName: "person.circle.fill")
                }.tag(4)
            
        }.tint(Color.black)
        
    }
}

#Preview {
    MainTabView()
}
