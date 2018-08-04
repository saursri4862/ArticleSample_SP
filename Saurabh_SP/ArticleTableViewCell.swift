//
//  ArticleTableViewCell.swift
//  Saurabh_SP
//
//  Created by saurabh srivastava on 04/08/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artImage: UIImageView!
    
    var goNews:(() -> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      //  titleLabel.adjustsFontSizeToFitWidth = true
    }
    
    func updateTableCell(_ article:Article){
        titleLabel.text = article.title
        titleLabel.sizeToFit()
        descLabel.text = article.descript
        descLabel.sizeToFit()
        artImage.kf.setImage(with:URL(string:article.urlToImage))
        date.text = stringToDateString(article.publishedAt)
        
    }
    
    @IBAction func goToNews(_ sender: Any) {
        if goNews != nil{
            goNews?()
        }
    }
    func stringToDateString(_ str:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date1 = dateFormatter.date(from: str)
        
        if date1 != nil {
            dateFormatter.dateFormat = "EEEE, dd MMM yyyy"
            dateFormatter.locale = Locale.current
            let string1 = dateFormatter.string(from: date1! as Date)
            let string2 = dateFormatter.string(from: NSDate() as Date)
            
            if string1 == string2 {
                return "Today"
            }
            
            return string1
        }
        
        return ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
