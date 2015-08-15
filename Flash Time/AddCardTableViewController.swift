//
//  AddCardTableViewController.swift
//  Flash Time
//
//  Created by Christopher Whidden on 8/14/15.
//  Copyright (c) 2015 SelfEdge Software. All rights reserved.
//

import UIKit

class AddCardTableViewController: UITableViewController {
    @IBOutlet weak var doneButton: UIBarButtonItem!
    var group: Group!
    var image: UIImage?
    var imagePath: String?
    var customConfiguration: Configuration?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if image != nil {
            return 3
        } else {
            return 2
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("Text", forIndexPath: indexPath) as! TextTableViewCell
            cell.textView.text = "Front"
            return cell
        case 1:
            if let image = image {
                let cell = tableView.dequeueReusableCellWithIdentifier("Image", forIndexPath: indexPath) as! ImageTableViewCell
                cell.associatedImage.image = image
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("Text", forIndexPath: indexPath) as! TextTableViewCell
                cell.textView.text = "Back"
                return cell
            }
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("Text", forIndexPath: indexPath) as! TextTableViewCell
            cell.textView.text = "Back"
            return cell
        default:
            fatalError("Index for card cell out of range")
        }
    }
    
    @IBAction func cancelTapped(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func doneTapped(sender: UIBarButtonItem) {
        let frontText = (tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! TextTableViewCell).textView.text
        let backIndex = (image != nil) ? 2 : 1
        let backText = (tableView.cellForRowAtIndexPath(NSIndexPath(forRow: backIndex, inSection: 0)) as! TextTableViewCell).textView.text
        if count(frontText) > 0 {
            let card = Card(front: frontText, back: backText, dueDate: NSDate(), imagePath: imagePath ?? nil, configuration: customConfiguration ?? group.defaultConfiguration)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let id = segue.identifier {
            switch id {
            case "ConfigureCard":
                let dvc = (segue.destinationViewController as! UINavigationController).topViewController as! CardConfigurationViewController
                dvc.configuration = group.defaultConfiguration
            case "CaptureImage":
                let dvc = (segue.destinationViewController as! UINavigationController).topViewController as! CaptureImageViewController
                if let image = image {
                    dvc.startingImage = image
                }
                dvc.photoCompletionHandler = { image in
                    // TODO: Delete current image at imagePath if found
                    let imagePath = "" // TODO: Save new image to documents image path
                    self.image = image
                    self.imagePath = imagePath
                }
            default:
                break
            }
        }
    }
    

}
