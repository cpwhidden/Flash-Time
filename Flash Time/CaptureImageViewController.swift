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
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var searchActivityIndicator: UIActivityIndicatorView!

    lazy var picker = UIImagePickerController()
    var startingImage: UIImage?
    var photoCompletionHandler: ((UIImage?) -> Void)?
    var urls: [NSURL]?
    var urlIndex = 0
    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = startingImage
        picker.delegate = self
        searchActivityIndicator.hidden = true
        
        if let startingImage = startingImage {
            deleteButton.enabled = true
        }
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
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func getPreviousPhoto() {
        previousButton.enabled = false
        nextButton.enabled = false
        deleteButton.enabled = false
        doneButton.enabled = false
        if urlIndex > 0 {
            imageView.image = nil
            searchActivityIndicator.startAnimating()
            searchActivityIndicator.hidden = false
            FlickrClient.sharedClient.downloadImageForURL(self.urls![--urlIndex]) { image, error in
                if error == nil && self.urls != nil {
                    self.imageView.image = image
                    self.deleteButton.enabled = true
                    if self.urlIndex > 0 {
                        self.previousButton.enabled = true
                    }
                    self.nextButton.enabled = true
                    self.doneButton.enabled = true
                } else {
                    let alert = UIAlertView(title: "Error", message: "There was an error trying to download a photo for you", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                }
                self.searchActivityIndicator.stopAnimating()
                self.searchActivityIndicator.hidden = true
            }
        } else {
            previousButton.enabled = false
        }
    }
    
    @IBAction func getNextPhoto() {
        previousButton.enabled = false
        nextButton.enabled = false
        deleteButton.enabled = false
        doneButton.enabled = false
        if urlIndex < urls!.count - 1 {
            imageView.image = nil
            searchActivityIndicator.startAnimating()
            searchActivityIndicator.hidden = false
            FlickrClient.sharedClient.downloadImageForURL(self.urls![++urlIndex]) { image, error in
                if error == nil && self.urls != nil {
                    self.imageView.image = image
                    self.deleteButton.enabled = true
                    if self.urlIndex < self.urls!.count - 1 {
                        self.nextButton.enabled = true
                    }
                    self.previousButton.enabled = true
                    self.doneButton.enabled = true
                } else {
                    let alert = UIAlertView(title: "Error", message: "There was an error trying to download a photo for you", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                }
                self.searchActivityIndicator.stopAnimating()
                self.searchActivityIndicator.hidden = true
            }
        } else {
            nextButton.enabled = false
        }
    }
    
    @IBAction func deletePhoto(sender: UIBarButtonItem) {
        imageView.image = nil
        deleteButton.enabled = false
        doneButton.enabled = true
    }
    
    
    // MARK: Image Picker Controller Delegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        searchBar.text = ""
        previousButton.enabled = false
        nextButton.enabled = false
        deleteButton.enabled = true
        imageView.image = image
        doneButton.enabled = true
    }

    // MARK: Search Bar Delegate
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        return !isSearching
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if count(searchBar.text) > 0 {
            isSearching = true
            imageView.image = nil
            searchActivityIndicator.startAnimating()
            searchActivityIndicator.hidden = false
            FlickrClient.sharedClient.resumedTaskForURLsForKeywordSearch(searchBar.text) { urls, error in
                self.isSearching = false
                if error == nil && urls != nil {
                    self.urls = urls
                    self.previousButton.enabled = false
                    if count(urls!) > 0 {
                        FlickrClient.sharedClient.downloadImageForURL(self.urls![0]) { image, error in
                            if error == nil && image != nil {
                                self.imageView.image = image
                                self.urlIndex = 0
                                self.deleteButton.enabled = true
                            }
                            self.doneButton.enabled = true
                            self.searchActivityIndicator.stopAnimating()
                            self.searchActivityIndicator.hidden = true
                        }
                    } else {
                        self.searchActivityIndicator.stopAnimating()
                        self.searchActivityIndicator.hidden = true
                        let alert = UIAlertView(title: "Cannot find any photos", message: "Could not retrieve any photos for the keyword search", delegate: nil, cancelButtonTitle: "OK")
                        alert.show()
                    }
                    if count(urls!) > 1 {
                        self.nextButton.enabled = true
                    }
                } else {
                    let alert = UIAlertView(title: "Error", message: "There was an error trying to retrieve photos", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                }
            }
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
