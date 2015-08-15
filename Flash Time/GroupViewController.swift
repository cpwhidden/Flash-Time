//
//  GroupViewController.swift
//  Flash Time
//
//  Created by Christopher Whidden on 8/13/15.
//  Copyright (c) 2015 SelfEdge Software. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {
    @IBOutlet weak var cardsDueLabel: UILabel!
    @IBOutlet weak var totalCardsLabel: UILabel!
    
    var group: Group!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = group.name
        totalCardsLabel.text = "You have \(group.cards?.count) total in this group"
        
        // TODO: Get total number of cards due from Core Data
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let id = segue.identifier {
            switch id {
            case "EditGroup":
                let dvc = (segue.destinationViewController as! UINavigationController).topViewController as! EditGroupViewController
                dvc.group = group
            case "AddGroup":
                let dvc = (segue.destinationViewController as! UINavigationController).topViewController as! AddCardTableViewController
                dvc.group = group
            case "StartReview":
                let dvc = segue.destinationViewController as! ReviewTableViewController
                dvc.group = group
            default:
                break
            }
        }
    }
    

}
