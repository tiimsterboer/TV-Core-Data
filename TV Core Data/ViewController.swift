//
//  ViewController.swift
//  TV Core Data
//
//  Created by Tim Beemsterboer on 2/13/18.
//  Copyright © 2018 Tim Beemsterboer. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    var tvshows:[TVShow]? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Alamofire.request("https://api.tvmaze.com/shows?page=0").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                //print(swiftyJsonVar)
                for item in swiftyJsonVar.array! {
                    print(item["name"].stringValue)
                    print(item["genres"].arrayValue)
                    print(Int32(item["id"].intValue))
                    print(item["type"].stringValue)
                    print(item["language"].stringValue)
                    print(item["summary"].stringValue)
                    
                    
                    if CoreDataHandler.saveObject(id: Int32(item["id"].intValue), name: item["name"].stringValue, type: item["type"].stringValue, language: item["language"].stringValue, summary: item["summary"].stringValue, genres: item["genres"].arrayValue) {
                        self.tvshows = CoreDataHandler.fetchObject()
                        }
                }
        
            }
        
        
            
            for item in 1...10 {
                
                if CoreDataHandler.saveObject(id: Int32(item), name: "tim\(item)", type: "drama\(item)", language: "english", summary: "\(item) time running out", genres: ["suspense","drama"]) {
                    self.tvshows = CoreDataHandler.fetchObject()
                
            }
                
        
            
            
            }
            for i in self.tvshows! {
                print(i.name!)
                //print(tvshows)
        }
        
        
        
        
    }

    


}

}
