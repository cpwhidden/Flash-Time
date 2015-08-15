//
//  Group.swift
//  Flash Time
//
//  Created by Christopher Whidden on 8/13/15.
//  Copyright (c) 2015 SelfEdge Software. All rights reserved.
//

import Foundation
import CoreData

class Group: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var cards: NSSet?
    @NSManaged var defaultConfiguration: Configuration

    init(name: String, cards: NSSet? = [], defaultConfiguration: Configuration, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("Group", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        self.name = name
        self.cards = cards
        self.defaultConfiguration = defaultConfiguration
        sharedContext.save(nil)
    }
    
    convenience init(name: String, cards: NSSet? = [], defaultConfiguration: Configuration) {
        self.init(name: name, cards: cards, defaultConfiguration: defaultConfiguration, context: sharedContext)
    }
}
