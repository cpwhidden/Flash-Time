//
//  CardConfigurationViewController.swift
//  Flash Time
//
//  Created by Christopher Whidden on 8/14/15.
//  Copyright (c) 2015 SelfEdge Software. All rights reserved.
//

import UIKit

class CardConfigurationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var configurationPicker: UIPickerView!
    var configuration: Configuration!
    
    var configurationCompletionHandler: (Configuration -> Void)?
    var configurations: [Configuration]!

    override func viewDidLoad() {
        super.viewDidLoad()

        configurations = sharedContext.fetchAllOfEntity("Configuration") as! [Configuration]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneTapped(sender: UIBarButtonItem) {
        let customConfiguration = configurations[configurationPicker.selectedRowInComponent(0)]
        configurationCompletionHandler!(customConfiguration)
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancelTapped(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Picker View Data Source
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return configurations.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return configurations[row].name
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
