//
//  Card.swift
//  Flash Time
//
//  Created by Christopher Whidden on 8/13/15.
//  Copyright (c) 2015 SelfEdge Software. All rights reserved.
//

import Foundation
import CoreData

@objc class Card: NSManagedObject {

    @NSManaged var front: String
    @NSManaged var back: String
    @NSManaged var dueDate: NSDate
    @NSManaged var imagePath: String?
    @NSManaged var id: String
    @NSManaged var answer: NSOrderedSet
    @NSManaged var configuration: Configuration

    init(front: String, back: String, dueDate: NSDate, imagePath: String? = nil, configuration: Configuration, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("Card", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        self.front = front
        self.back = back
        self.dueDate = dueDate
        self.imagePath = imagePath
        self.configuration = configuration
        sharedContext.save(nil)
    }
    
    convenience init(front: String, back: String, dueDate: NSDate, imagePath: String? = nil, configuration: Configuration) {
        self.init(front: front, back: back, dueDate: dueDate, imagePath: imagePath, configuration: configuration, context: sharedContext)
    }
}
