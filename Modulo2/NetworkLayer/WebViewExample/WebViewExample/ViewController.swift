//
//  ViewController.swift
//  WebViewExample
//
//  Created by Israel Torres Alvarado on 23/03/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.hidesWhenStopped = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
              
        guard let url = URL(string: "https://www.google.com/") else {
            return
        }
        let request = URLRequest(url: url)
        webView.loadRequest(request)
        webView.delegate = self
    }

}

extension ViewController: UIWebViewDelegate {
    

    func webViewDidStartLoad(_ webView: UIWebView) {
        
        activityIndicator.startAnimating()
        if let textUrl = webView.request?.url?.absoluteString {
            print(textUrl)
        }

    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        activityIndicator.stopAnimating()
        dump(webView.request)
        if let textUrl = webView.request?.url?.absoluteString {
            print(textUrl)
        }
        
        guard let doc = webView.stringByEvaluatingJavaScript(from: "document.documentElement.outerHTML") else {
            return
        }
        
        print("HTML: \(doc)")
        if doc.contains("Ofrecido por Google en:") {
           print("send accion")
        }
        
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        
        if let textUrl = webView.request?.url?.absoluteString {
            print(textUrl)
        }
        
        print("Entro..")
        
        return true
    }
    
}


