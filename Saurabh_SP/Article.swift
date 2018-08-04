//
//  Article.swift
//  Saurabh_SP
//
//  Created by saurabh srivastava on 04/08/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class Article: NSObject {
    
    var author = ""
    var title = ""
    var descript = ""
    var url = ""
    var urlToImage = ""
    var publishedAt = ""
    
    func updateArticle(_ data:[String:Any]){
        if let auth = data["author"] as? String{
            author = auth
        }
        if let tit = data["title"] as? String{
            title = tit
        }
        if let str = data["description"] as? String{
            descript = str
        }
        if let str = data["url"] as? String{
            url = str
        }
        if let str = data["urlToImage"] as? String{
            urlToImage = str
        }
        if let str = data["publishedAt"] as? String{
            publishedAt = str
        }
    }
    
    
}
