//
//  QuoteFetch.swift
//  Continuous
//
//  Created by Chloe on 2016-02-23.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

import Foundation

extension CreateViewController {
    
    func generateQuote() {
        let url = NSURL(string: "http://quotes.rest/qod.json?category=inspire")
        let session = NSURLSession.sharedSession()
        session.dataTaskWithURL(url!, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            do {
                let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                print(json)
                let text = json["conents"]!["quotes"]!["quote"]!
                let author = json["contents"]!["quotes"]!["author"]!
                print(text, author)
            } catch {
                print(error)
                
            }
        }).resume()
    }
    
}
