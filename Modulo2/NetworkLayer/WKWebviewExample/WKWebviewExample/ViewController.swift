//
//  ViewController.swift
//  WKWebviewExample
//
//  Created by Israel Torres Alvarado on 23/03/21.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        guard let url = URL(string: "https://www.google.com/") else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
        webView.navigationDelegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        progressView.progress = 0.3
    }

}

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let url = navigationAction.request.url else { return }
        print("decidePolicyFor - url: \(url)")
        decisionHandler(WKNavigationActionPolicy.allow)
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        progressView.progress = 0.5
        if let textUrl = webView.url?.absoluteString {
            print("didStartProvisionalNavigation - webView.url:\(textUrl) ")
        }
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        progressView.progress = 1.0
        if let textUrl = webView.url?.absoluteString {
            print("didFinish - webView.url:\(textUrl) ")
        }
        
        webView.evaluateJavaScript("document.documentElement.outerHTML") { (html, error) in
            
            if let strHtml = html as? String {
                print(strHtml)
                
                if strHtml.contains("Ofrecido por Google en:") {
                   print("send accion")
                }
            }
            self.progressView.isHidden = true
        }
            
    }
        
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
        print(error.localizedDescription)
        
        webView.loadHTMLString("<h1>\(error.localizedDescription)<h1>", baseURL: nil)
        progressView.isHidden = true
        
    }

}

