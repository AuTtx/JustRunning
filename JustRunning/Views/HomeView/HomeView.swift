//
//  CardsScreen.swift
//  JustRunning
//
//  Created by 许智尧 on 2023/5/11.
//
import SwiftUI
import Foundation

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(#colorLiteral(red: 0.9646216035, green: 0.9647607207, blue: 0.9998810887, alpha: 1)).edgesIgnoringSafeArea(.all)
                ScrollView{
                    CardList()
                    AnalysisView()
                }
                .navigationTitle(Text("跑步记录"))
            }
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
