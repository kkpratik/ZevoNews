//
//  DetailsViewController.swift
//  ZevoNews
//
//  Created by Apple on 15/07/23.
//

import UIKit
import WebKit
import IHProgressHUD

class DetailsViewController: UIViewController {


    @IBOutlet weak var webView: WKWebView!
    var articleURL:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)

        
        if let myUrl = URL.init(string: articleURL ?? ""){
            let request = URLRequest.init(url: myUrl)
            IHProgressHUD.show()
            self.webView.load(request)
            
        }
    }


}

extension DetailsViewController: WKNavigationDelegate{
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            if Float(webView.estimatedProgress) > 0.4{
                IHProgressHUD.dismiss()
            }
        }
    }
}
