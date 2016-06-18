//
//  CreateViewController+QuoteFetch.swift
//  Continuous
//
//  Created by Chloe on 2016-02-23.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

import Foundation

extension CreateViewController {
    
    func generateQuote() {
        let url = NSURL(string: "http://quotes.rest/quote.json?category=inspire&api_key=T6jlW_kFgFsJR0VblaFE1weF")
        let session = NSURLSession.sharedSession()
        session.dataTaskWithURL(url!, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            guard let data = data else {
                print("Couldn't fetch JSON")
                self.quoteLabel.text = "Two roads diverged in a wood, and I—I took the one less traveled by, And that has made all the difference. \n - Robert Frost"
                return
            }
            
            do {
                let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! NSDictionary
                let contents = json["contents"] as! NSDictionary
                let text = contents["quote"] as! String
                let author = contents["author"] as! String
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.quoteLabel.text = "\(text) \n -\(author)"
                })
            } catch {
                print(error)
            }
        }).resume()
    }
    
}
