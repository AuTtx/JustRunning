//
//  DataController.swift
//  JustRunning
//
//  Created by 许智尧 on 2023/5/8.
//

import Foundation
import CoreData

class DataController: ObservableObject{
    static let container = NSPersistentContainer(name: "User")
    
    init() {
        DataController.container.loadPersistentStores { description, error in
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
        user.name = ""
        user.gender = ""
        user.phoneNumber = ""
        user.portrait = ""
        user.email = ""
        user.location = ""
        user.validable = false
        
        save(context: context)
        print("user.username" + user.username!)
        print("user.password" + user.password!)
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
