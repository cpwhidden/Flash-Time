//
//  CaptureImageViewController.swift
//  Flash Time
//
//  Created by Christopher Whidden on 8/14/15.
//  Copyright (c) 2015 SelfEdge Software. All rights reserved.
//

import UIKit

class CaptureImageViewController: UIViewController, UISearchBarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var previousButton: UIBarButtonItem!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickerButton: UIBarButtonItem!
    
    lazy var picker = UIImagePickerController()
    var startingImage: UIImage?
    var photoCompletionHandler: ((UIImage?) -> Void)?
    var urls: [NSURL]?
    var urlIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = startingImage
        picker.delegate = self
        // Do any additional setup after loading the view.
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            pickerButton.enabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneTapped(sender: UIBarButtonItem) {
        photoCompletionHandler!(imageView.image)
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancelTapped(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func getUserPhoto(sender: UIBarButtonItem) {
        searchBar.text = ""
        previousButton.enabled = false
        nextButton.enabled = false
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func getPreviousPhoto() {
        if urlIndex > 0 {
//            downloadImageForURL(self.urls[--urlIndex]) { image, error in
//                if error == nil && urls != nil {
//                    self.imageView.image = image
//                }
//            }
            nextButton.enabled = true
        } else {
            previousButton.enabled = false
        }
    }
    
    func getNextPhoto() {
        if urlIndex < urls!.count - 1 {
//            downloadImageForURL(self.urls[++urlIndex]) { image, error in
//                if error == nil && urls != nil {
//                    self.imageView.image = image
//                }
//            }
            previousButton.enabled = true
        } else {
            nextButton.enabled = false
        }
    }
    
    // MARK: Image Picker Controller Delegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imageView.image = image
    }

    // MARK: Search Bar Delegate
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if count(searchBar.text) > 0 {
//            resumedTaskForURLsForKeyword(searchBar.text) { urls, error in
//                if error == nil && urls != nil {
//                    self.urls = urls
//                    previousButton.enabled = false
//                    if count(urls) > 0 {
//                        downloadImageForURL(self.urls[0]) { image, error in
//                            if error == nil && image != nil {
//                                self.imageView.image = image
//                                  self.urlIndex = 0
//                            }
//                        }
//                    }
//                    if count(urls) > 1 {
//                        nextButton.enabled = true
//                    }
//                }
//            }
        }
    }
}
