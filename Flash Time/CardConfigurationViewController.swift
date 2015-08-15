//
//  CardConfigurationViewController.swift
//  Flash Time
//
//  Created by Christopher Whidden on 8/14/15.
//  Copyright (c) 2015 SelfEdge Software. All rights reserved.
//

import UIKit

class CardConfigurationViewController: UIViewController {
    @IBOutlet weak var configurationPicker: UIPickerView!
    var configuration: Configuration!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
