//
//  Answer.swift
//  Flash Time
//
//  Created by Christopher Whidden on 8/13/15.
//  Copyright (c) 2015 SelfEdge Software. All rights reserved.
//

import Foundation
import CoreData

class Answer: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var correctness: NSNumber
    @NSManaged var card: Card
    
    init(card: Card, correctness: NSNumber, date: NSDate, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("Card", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        self.card = card
        self.correctness = correctness
        self.date = date
    }
    
    convenience init(card: Card, correctness: NSNumber, date: NSDate) {
        self.init(card: card, correctness: correctness, date: date, context: sharedContext())
    }

}
