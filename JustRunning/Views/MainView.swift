//
//  MainView.swift
//  JustRunning
//
//  Created by 许智尧 on 2023/5/3.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem{
                    Image(systemName: "house")
                    Text("主页")
            }
            RunningView()
                .tabItem{
                    Image(systemName: "figure.run")
                    Text("跑步")
            }
            ProfileView()
                .tabItem{
                    Image(systemName: "person")
                    Text("我的")
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
