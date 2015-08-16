//
//  FlickrClient.swift
//  Flash Time
//
//  Created by Christopher Whidden on 8/16/15.
//  Copyright (c) 2015 SelfEdge Software. All rights reserved.
//

import Foundation
import UIKit

class FlickrClient {
    static let sharedClient = FlickrClient()
    let sharedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    private init() {}
    
    func resumedTaskForURLsWithParameters(var parameters: [String:String], completionHandler: (urls: [NSURL]?, error: NSError?) -> Void) -> NSURLSessionTask {
        let urlString = APIConstants.baseURL + "?" + escapedParameters(parameters)
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if let error = error {
                completionHandler(urls: nil, error: error)
            } else {
                var jsonError: NSError? = nil
                let json = NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments, error: &jsonError) as! NSDictionary
                
                if let results = json["photos"] as? [String:AnyObject],
                    let photos = results["photo"] as? [[String:AnyObject]] {
                        let total = (results["total"] as! String).toInt()!
                        var slice = photos
                        slice.shuffle()
                        let max = min(21, total)
                        slice = Array(slice[0..<max])
                        let urls = map(slice) { (photo: [String:AnyObject]) -> NSURL in
                            let urlString = photo[APIConstants.urlExtra] as! String
                            return NSURL(string: urlString)!
                        }
                        completionHandler(urls: urls, error: nil)
                } else {
                    completionHandler(urls: nil, error: jsonError)
                }
            }
        }
        task.resume()
        return task
    }
    
    func resumedTaskForURLsForKeywordSearch(searchString: String, completionHandler: (urls: [NSURL]?, error: NSError?) -> Void) -> NSURLSessionTask {
        
        let params = [
            "method" : SearchMethod.searchPhotos,
            "api_key" : APIConstants.apiKey,
            "extras" : APIConstants.urlExtra,
            "format" : APIConstants.jsonFormat,
            "nojsoncallback" : "1",
            "text" : searchString,
            "sort" : "relevance",
            "per_page" : SearchMethod.perPage.description
        ]
        
        return resumedTaskForURLsWithParameters(params, completionHandler: completionHandler)
    }
    
    func downloadImageForURL(url: NSURL, completionHandler: (image: UIImage?, error: NSError?)->Void) {
        let request = NSURLRequest(URL: url)
        let task = NSURLSession.sharedSession().downloadTaskWithRequest(request) { url, response, error in
            if let error = error {
                completionHandler(image: nil, error: error)
            } else {
                let data = NSData(contentsOfURL: url)!
                let image = UIImage(data: data)
                completionHandler(image: image, error: nil)
            }
        }
        task.resume()
    }
    
    struct APIConstants {
        static let apiKey = "61da8616e0f859641b624b9d16b773c8"
        static let baseURL = "https://api.flickr.com/services/rest/"
        static let urlExtra = "url_m"
        static let jsonFormat = "json"
    }
    
    struct SearchMethod {
        static let searchPhotos = "flickr.photos.search"
        static let maxReturnedPhotos = 500
        static let perPage = 500
    }

    func escapedParameters(dictionary: [String:String]) -> String {
        let queryItems = map(dictionary) {
            NSURLQueryItem(name: $0, value: $1)
        }
        let comps = NSURLComponents()
        comps.queryItems = queryItems
        return comps.percentEncodedQuery ?? ""
    }
}

extension Array {
    mutating func shuffle() {
        if count < 2 { return }
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swap(&self[i], &self[j])
        }
    }
}