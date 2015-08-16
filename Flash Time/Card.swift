//
//  Card.swift
//  Flash Time
//
//  Created by Christopher Whidden on 8/13/15.
//  Copyright (c) 2015 SelfEdge Software. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Card)
class Card: NSManagedObject {

    @NSManaged var front: String
    @NSManaged var back: String
    @NSManaged var dueDate: NSDate
    @NSManaged var interval: NSNumber
    @NSManaged var imagePath: String?
    @NSManaged var id: String
    @NSManaged var answer: NSOrderedSet
    @NSManaged var configuration: Configuration
    @NSManaged var group: Group
    

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(front: String, back: String, dueDate: NSDate, interval: NSNumber, imagePath: String? = nil, configuration: Configuration, group: Group, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("Card", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        self.front = front
        self.back = back
        self.dueDate = dueDate
        self.imagePath = imagePath
        self.configuration = configuration
        self.group = group
        sharedContext.save(nil)
    }
    
    convenience init(front: String, back: String, dueDate: NSDate, interval: NSNumber, imagePath: String? = nil, configuration: Configuration, group: Group) {
        self.init(front: front, back: back, dueDate: dueDate, interval: interval, imagePath: imagePath, configuration: configuration, group: group, context: sharedContext)
    }
    
    func getImage() -> UIImage? {
        if let imagePath = imagePath {
            let docPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first as! String
            let fullPath = docPath + imagePath
            return UIImage(contentsOfFile: fullPath)
        } else {
            return nil
        }
    }
}
