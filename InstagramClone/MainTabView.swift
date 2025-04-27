import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView{
            Text("feed")
                .tabItem {
                    Image(systemName: "house")
                }
            Text("Search")
                .tabItem{
                    Image(systemName: "magnifyingglass")
                }
           NewPostView()
                .tabItem{
                    Image(systemName: "plus.square")
                }
            Text("Reels")
                .tabItem{
                    Image(systemName: "movieclapper")
                }
            Text("Profile")
                .tabItem{
                    Image(systemName: "person.circle.fill")
                }
            
        }
        
    }
}

#Preview {
    MainTabView()
}
