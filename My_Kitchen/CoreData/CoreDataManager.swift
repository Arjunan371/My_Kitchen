//
//  CoreDataManager.swift
//  My_Kitchen
//
//  Created by Arjunan on 30/11/24.
//

import Foundation
import CoreData

class CoreDataManager {
    let container: NSPersistentContainer
    static let shared = CoreDataManager()
    
    init() {
        container = NSPersistentContainer(name: "MyKitchen")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("loadPersistentStores Error", error)
            }
        }
    }
}
