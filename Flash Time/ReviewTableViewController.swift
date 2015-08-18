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
        
        revealToolbarItems = [
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Reveal", style: .Plain, target: self, action: "revealTapped:"),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        ]
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
    
    @IBAction func revealTapped(sender: UIBarButtonItem) {
        revealed = true
        navigationController?.toolbar.items = answerToolbarItems
        tableView.reloadData()
    }
    
    func resetTapped(sender: UIBarButtonItem) {
        revealed = false
        navigationController?.toolbar.items = revealToolbarItems
        cards[currentIndex].interval = cards[currentIndex].configuration.restartInterval
        cards[currentIndex].dueDate = NSDate(timeIntervalSinceNow: cards[currentIndex].interval.doubleValue)
        let answer = Answer(card: cards[currentIndex], correctness: 0, date: NSDate())
        ++currentIndex
        tableView.reloadData()
    }
    
    func hardTapped(sender: UIBarButtonItem) {
        answeredWithCorrectness(0, multiplier: cards[currentIndex].configuration.hardMultiplier)
    }
    
    func goodTapped(sender: UIBarButtonItem) {
        answeredWithCorrectness(0, multiplier: cards[currentIndex].configuration.standardMultiplier)
    }
    
    func easyTapped(sender: UIBarButtonItem) {
        answeredWithCorrectness(0, multiplier: cards[currentIndex].configuration.easyMultiplier)
    }
    
    func answeredWithCorrectness(correctness: Int, multiplier: NSNumber) {
        revealed = false
        navigationController?.toolbar.items = revealToolbarItems
        cards[currentIndex].interval = Int(cards[currentIndex].interval.doubleValue * (1 + multiplier.doubleValue / 100))
        cards[currentIndex].dueDate = NSDate(timeIntervalSinceNow: cards[currentIndex].interval.doubleValue)
        let answer = Answer(card: cards[currentIndex], correctness: correctness, date: NSDate())
        ++currentIndex
        tableView.reloadData()
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
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200.0
    }

}
