//
//  Configuration.swift
//  Flash Time
//
//  Created by Christopher Whidden on 8/13/15.
//  Copyright (c) 2015 SelfEdge Software. All rights reserved.
//

import Foundation
import CoreData

@objc class Configuration: NSManagedObject {

    @NSManaged var restartInterval: NSNumber
    @NSManaged var isCustom: NSNumber
    @NSManaged var startingInterval: NSNumber
    @NSManaged var standardMultiplier: NSNumber
    @NSManaged var easyMultiplier: NSNumber
    @NSManaged var hardMultiplier: NSNumber
    @NSManaged var cards: NSSet
    @NSManaged var name: String

    init(name: String, startingInterval: NSNumber, standardMultiplier: NSNumber, hardMultiplier: NSNumber, easyMultiplier: NSNumber, restartInterval: NSNumber, isCustom: Bool, cards: [Card], context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("Configuration", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        self.startingInterval = startingInterval
        self.standardMultiplier = standardMultiplier
        self.hardMultiplier = hardMultiplier
        self.easyMultiplier = easyMultiplier
        self.restartInterval = restartInterval
        self.isCustom = isCustom
        self.name = name
        sharedContext.save(nil)
    }
    
    convenience init(name: String, startingInterval: NSNumber, standardMultiplier: NSNumber, hardMultiplier: NSNumber, easyMultiplier: NSNumber, restartInterval: NSNumber, isCustom: Bool, cards: [Card]) {
        self.init(name: name, startingInterval: startingInterval, standardMultiplier: standardMultiplier, hardMultiplier: hardMultiplier, easyMultiplier: easyMultiplier, restartInterval: restartInterval, isCustom: isCustom, cards: cards, context: sharedContext)
    }
}
