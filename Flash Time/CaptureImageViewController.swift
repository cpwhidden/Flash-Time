//
//  CaptureImageViewController.swift
//  Flash Time
//
//  Created by Christopher Whidden on 8/14/15.
//  Copyright (c) 2015 SelfEdge Software. All rights reserved.
//

import UIKit

class CaptureImageViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentBarButton: UIBarButtonItem!
    @IBOutlet weak var segmentedPhotoControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelAndUnwind(sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func doneAndUnwind(sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func getUserPhoto(sender: UIBarButtonItem) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
