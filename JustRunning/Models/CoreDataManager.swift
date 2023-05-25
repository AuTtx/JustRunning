//
//  DataController.swift
//  JustRunning
//
//  Created by 许智尧 on 2023/5/8.
//

import Foundation
import CoreData


class CoreDataManager{
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init(){
        container = NSPersistentContainer(name: "UserContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading Core Data. \(error)")
            }
        }
        context = container.viewContext
        
    }
    
    func save(){
        do{
            try context.save()
        }catch let error{
            print("Error saving Core Data.\(error.localizedDescription)")
        }
    }
}
