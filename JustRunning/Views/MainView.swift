//
//  MainView.swift
//  JustRunning
//
//  Created by 许智尧 on 2023/5/3.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var vmRunning: ViewModel
    @EnvironmentObject var cm: CountdownModel
    var body: some View {
        TabView{
            HomeView()
                .tabItem{
                    Image(systemName: "house")
                    Text("主页")
            }
            RunningView()
                .environmentObject(vmRunning).environmentObject(cm)
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
//
//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
