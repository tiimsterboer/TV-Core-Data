//
//  CoreDataHandler.swift
//  TV Core Data
//
//  Created by Tim Beemsterboer on 2/13/18.
//  Copyright © 2018 Tim Beemsterboer. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {

    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
    class func saveObject(id: Int32, name:String, type: String, language: String, summary: String, genres: Array<Any>) -> Bool {
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "TVShow", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(id, forKey: "id")
        manageObject.setValue(name, forKey: "name")
        manageObject.setValue(type, forKey: "type")
        manageObject.setValue(language, forKey: "language")
        manageObject.setValue(summary, forKey: "summary")
        manageObject.setValue(genres, forKey: "genres")
        
        do {
            try context.save()
            return true
        } catch {
            return false
        }
        
    }
    class func fetchObject() -> [TVShow]? {
        let context = getContext()
        var tvshows:[TVShow]? = nil
        do {
            tvshows = try context.fetch(TVShow.fetchRequest())
            return tvshows
        } catch {
            return tvshows
        }
    }
}
