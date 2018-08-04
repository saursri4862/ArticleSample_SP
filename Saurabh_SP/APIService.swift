//
//  ApiService.swift
//  Saurabh_SP
//
//  Created by saurabh srivastava on 04/08/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class APIService: NSObject {
    
    static let sharedInstance : APIService = {
        let instance = APIService()
        return instance
    }()
    
    fileprivate override init() {
        super.init()
    }
    func getCall(_ pageNo:Int,  completion:@escaping (_ response:Any? ,_ error:String?) -> Void){
        let url = URL(string: "https://newsapi.org/v2/everything?q=apple&pageSize=10&page="+String(pageNo)+"&sortBy=popularity&apiKey=3363a374df9f4660a260a187915f0937")!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil,error?.localizedDescription)
                return 
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]{
                    if let artDict = json["articles"] as? [[String:Any]]{
                        var articles = [Article]()
                        for dict in artDict{
                            var article = Article()
                            article.updateArticle(dict)
                            articles.append(article)
                        }
                        DispatchQueue.main.async {
                            completion(articles,nil)
                        }
                    }
                }
            }
            catch{
                DispatchQueue.main.async {
                    completion(nil,"")
                }
            }
        }
        task.resume()
    }
}
