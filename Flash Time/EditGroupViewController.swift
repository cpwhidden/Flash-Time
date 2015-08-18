//
//  EditGroupViewController.swift
//  Flash Time
//
//  Created by Christopher Whidden on 8/13/15.
//  Copyright (c) 2015 SelfEdge Software. All rights reserved.
//

import UIKit

class EditGroupViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var configurationPicker: UIPickerView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var group: Group?
    var configurations: [Configuration]!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        configurations = sharedContext.fetchAllOfEntity("Configuration") as! [Configuration]
        
        if let group = group {
            nameTextField.text = group.name
            let index = find(configurations, group.defaultConfiguration)!
            configurationPicker.selectRow(index, inComponent: 0, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let finalString = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
        if count(finalString) != 0 {
            doneButton.enabled = true
        } else {
            doneButton.enabled = false
        }
        return true
    }
    
    @IBAction func doneTapped(sender: UIBarButtonItem) {
        let index = configurationPicker.selectedRowInComponent(0)
        if let group = group {
            group.name = nameTextField.text
            group.defaultConfiguration = configurations[index]
        } else {
            let group = Group(name: nameTextField.text, cards: [], defaultConfiguration: configurations[index])
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
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
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
}
