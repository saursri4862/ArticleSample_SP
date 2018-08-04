//
//  WebViewController.swift
//  Saurabh_SP
//
//  Created by saurabh srivastava on 04/08/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController,WKNavigationDelegate {
    var webView: WKWebView!
    var url = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
         ProgressView.shared.showProgressView()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        let url = URL(string: self.url)
        webView.load(URLRequest(url: url!))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ProgressView.shared.hideProgressView()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
         ProgressView.shared.hideProgressView()
    }
    
}
