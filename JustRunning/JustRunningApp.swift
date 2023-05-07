//
//  JustRunningApp.swift
//  JustRunning
//
//  Created by 许智尧 on 2023/4/28.
//

import SwiftUI

@main
struct JustRunningApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
           LoginView().environmentObject(UserViewmodel())
        }
    }
}
