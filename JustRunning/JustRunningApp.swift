//
//  JustRunningApp.swift
//  JustRunning
//
//  Created by 许智尧 on 2023/4/28.
//

import SwiftUI

@main
struct JustRunningApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
           LoginView().environmentObject(UserViewmodel())
            .environment(\.managedObjectContext,
                          dataController.container.viewContext)
        }
    }
}
