//
//  ViewController.swift
//  Saurabh_SP
//
//  Created by saurabh srivastava on 03/08/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lowerActivity: UIActivityIndicatorView!
    @IBOutlet weak var noneButton: UIButton!
    @IBOutlet weak var publishButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    var realArticles = [Article]()
    var articles = [Article]()
    var pageNo = 0
    var apiCalling = true
    var fetchMore = true
    var searchActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        ProgressView.shared.showProgressView()
        lowerActivity.hidesWhenStopped = true
        lowerActivity.stopAnimating()
        self.getArticles()
        
    }
    
    
    func getArticles(){
        if apiCalling == true && fetchMore == true{
            pageNo += 1
            APIService.sharedInstance.getCall(pageNo, completion: {[weak self] (result,error) -> Void in
                self?.apiCalling = false
                ProgressView.shared.hideProgressView()
                self?.lowerActivity.stopAnimating()
                if error == nil{
                    if let data = result as? [Article]{
                        self?.articles += data
                        self?.realArticles += data
                        if data.count == 0{
                            self?.fetchMore = false
                        }
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                    }
                }
                else{
                    self?.showAlert("Error", message: error!)
                }
                
            })
            
            
        }
    }
    

    @IBAction func noneSort(_ sender: Any) {
        self.searchActive = false
        self.articles = self.realArticles
        self.tableView.reloadData()
    }

    @IBAction func sortByPublish(_ sender: Any) {
        self.searchActive = false
        self.articles = self.realArticles.sorted(by: {$0.publishedAt > $1.publishedAt})
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200), execute: {
            self.searchActive = true
            self.articles = self.realArticles.filter{$0.title.lowercased().contains(self.searchField.text!.lowercased())}
            if self.articles.count == 0{
                self.articles = self.realArticles
            }
            self.tableView.reloadData()
        })
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.searchActive = false
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.searchActive = false
        self.articles = self.realArticles
        return true
    }
    
}

extension ViewController:UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
        cell.updateTableCell(articles[indexPath.row])
        cell.goNews = {[weak self] () -> Void in
            self?.goToNews((self?.articles[indexPath.row])!)
            
        }
        if indexPath.row == articles.count-1{
            if self.apiCalling == false && searchActive == false{
                lowerActivity.startAnimating()
                self.apiCalling = true
                self.getArticles()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        return 65
    }
    
    func goToNews(_ article:Article){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        controller.url = article.url
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

