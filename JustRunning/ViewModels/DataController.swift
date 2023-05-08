//
//  DataController.swift
//  JustRunning
//
//  Created by 许智尧 on 2023/5/8.
//

import Foundation
import CoreData

class DataController: ObservableObject{
     let container = NSPersistentContainer(name: "User")
    static var count = 1
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load data in DataController \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved successfully. WUHU!!!")
        } catch {
            // Handle errors in our database
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func signUpAccountInCoreData(username: String, password: String, context: NSManagedObjectContext){
        var user = User(context: context)
        user.id = UUID()
        user.username = username
        user.password = password
        user.name = "用户\(DataController.count)"
        user.gender = ""
        user.phoneNumber = ""
        user.portrait = ""
        user.email = "1231212321@email.com"
        user.location = "whu"
        user.validable = false
        DataController.count += 1
        
        save(context: context)
        
        print("保存user.username" + user.username!)
        print("保存user.password" + user.password!)
    }
    
    func editUserInfoInCoreData(user: User, name: String, gender: String, phoneNumber: String, potrait: String, email: String, location: String, context: NSManagedObjectContext){
        user.name = name
        user.gender = gender
        user.phoneNumber = phoneNumber
        user.portrait = potrait
        user.email = email
        user.location = location
        
        save(context: context)
    }
    
}
