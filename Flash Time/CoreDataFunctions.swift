//
//  CoreDataFunctions.swift
//  Flash Time
//
//  Created by Christopher Whidden on 8/14/15.
//  Copyright (c) 2015 SelfEdge Software. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    func fetchAllOfEntity(entity: String) -> [AnyObject]? {
        let request = NSFetchRequest(entityName: entity)
        return self.executeFetchRequest(request, error: nil)
    }
    
    func fetchCardsDueInGroup(group: Group) -> [AnyObject]? {
        let request = NSFetchRequest(entityName: "Card")
        let predicate = NSPredicate(format: "group == %@ && dueDate < %@", argumentArray: [group, NSDate()])
        request.predicate = predicate
        let sortByDueDate = NSSortDescriptor(key: "dueDate", ascending: true)
        request.sortDescriptors = [sortByDueDate]
        return self.executeFetchRequest(request, error: nil)
    }
}