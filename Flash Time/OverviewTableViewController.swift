//
//  OverviewTableViewController.swift
//  Flash Time
//
//  Created by Christopher Whidden on 8/13/15.
//  Copyright (c) 2015 SelfEdge Software. All rights reserved.
//

import UIKit

class OverviewTableViewController: UITableViewController {
    @IBOutlet weak var noGroupLabel: UIView!
    var groups: [Group]!
    var dueCounts: [Int]!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        groups = (sharedContext.fetchAllOfEntity("Group") as! [Group]) ?? []
        
        dueCounts = map(groups) { group in
            return count(sharedContext.fetchCardsDueInGroup(group)!)
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        let groupCount = groups!.count
        if groupCount > 0 {
            noGroupLabel.hidden = true
            return groupCount
        } else {
            noGroupLabel.hidden = false
            return 0
        }
    }

    @IBAction func addNewGroup(sender: UIBarButtonItem) {
        performSegueWithIdentifier("AddGroup", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let id = segue.identifier {
            switch id {
            case "AddGroup":
                let dvc = (segue.destinationViewController as! UINavigationController).topViewController as! EditGroupViewController
                dvc.group = nil
            case "ShowGroup":
                let cell = sender as! UITableViewCell
                let index = tableView.indexPathForCell(cell)!
                let dvc = (segue.destinationViewController as! GroupViewController)
                dvc.group = groups[index.row]
            default:
                break
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("group", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel!.text = groups[indexPath.row].name
        cell.detailTextLabel!.text = "\(dueCounts[indexPath.row]) due"

        return cell
    }
    
}