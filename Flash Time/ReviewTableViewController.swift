//
//  ReviewTableViewController.swift
//  Flash Time
//
//  Created by Christopher Whidden on 8/13/15.
//  Copyright (c) 2015 SelfEdge Software. All rights reserved.
//

import UIKit

class ReviewTableViewController: UITableViewController {
    @IBOutlet weak var noCardsLabel: UIView!
    
    var group: Group!
    var cards: [Card]!
    var currentIndex = 0
    var revealToolbarItems: [UIBarButtonItem]?
    var answerToolbarItems: [UIBarButtonItem]?
    var revealed = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        revealToolbarItems = navigationController?.toolbarItems as? [UIBarButtonItem]
        answerToolbarItems = [
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Reset", style: .Plain, target: self, action: "resetTapped:"),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Hard", style: .Plain, target: self, action: "hardTapped:"),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Good", style: .Plain, target: self, action: "goodTapped:"),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Easy", style: .Plain, target: self, action: "easyTapped:"),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        ]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func undoTapped(sender: UIBarButtonItem) {
    }
    
    @IBAction func revealTapped(sender: UIBarButtonItem) {
        revealed = true
        navigationController?.toolbar.items = answerToolbarItems
        tableView.reloadData()
    }
    
    @IBAction func skipTapped(sender: UIBarButtonItem) {
    }
    
    func resetTapped(sender: UIBarButtonItem) {
        navigationController?.toolbar.items = revealToolbarItems
        let answer = Answer(card: cards[currentIndex], correctness: 0, date: NSDate())
        ++currentIndex
    }
    
    func hardTapped(sender: UIBarButtonItem) {
        navigationController?.toolbar.items = revealToolbarItems
        let answer = Answer(card: cards[currentIndex], correctness: 1, date: NSDate())
        ++currentIndex
    }
    
    func goodTapped(sender: UIBarButtonItem) {
        navigationController?.toolbar.items = revealToolbarItems
        let answer = Answer(card: cards[currentIndex], correctness: 2, date: NSDate())
        ++currentIndex
    }
    
    func easyTapped(sender: UIBarButtonItem) {
        navigationController?.toolbar.items = revealToolbarItems
        let answer = Answer(card: cards[currentIndex], correctness: 3, date: NSDate())
        ++currentIndex
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentIndex >= cards.count {
            noCardsLabel.hidden = false
            for item in navigationController?.toolbar.items as! [UIBarButtonItem] {
                item.enabled = false
            }
            return 0
        } else {
            noCardsLabel.hidden = true
            for item in navigationController?.toolbar.items as! [UIBarButtonItem] {
                item.enabled = true
            }
        }
        if cards[currentIndex].imagePath != nil {
            return revealed ? 3 : 2
        } else {
            return revealed ? 2 : 1
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("Text", forIndexPath: indexPath) as! TextTableViewCell
            cell.textView.text = cards[currentIndex].front
            return cell
        case 1:
            if let imagePath = cards[currentIndex].imagePath {
                let cell = tableView.dequeueReusableCellWithIdentifier("Image", forIndexPath: indexPath) as! ImageTableViewCell
                cell.associatedImage.image = cards[currentIndex].getImage()
                return cell
            } else if revealed {
                let cell = tableView.dequeueReusableCellWithIdentifier("Text", forIndexPath: indexPath) as! TextTableViewCell
                cell.textView.text = cards[currentIndex].back
                return cell
            } else {
                fatalError("Index for card cell out of range")
            }
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("Text", forIndexPath: indexPath) as! TextTableViewCell
            cell.textView.text = cards[currentIndex].back
            return cell
        default:
            fatalError("Index for card cell out of range")
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
