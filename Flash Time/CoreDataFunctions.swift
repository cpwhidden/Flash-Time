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
}