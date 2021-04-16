//
//  ViewController.swift
//  SocialKit
//
//  Created by Israel Torres Alvarado on 15/04/21.
//

import UIKit
//1 - Step
import Social

class ViewController: UIViewController {

    @IBOutlet weak var imageShare: UIImageView!
    @IBOutlet weak var txtShareMessage: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else {
            return
        }
        
        var keyBoardFrame: CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyBoardFrame = self.view.convert(keyBoardFrame, from: nil)
        var contentInset: UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyBoardFrame.size.height + 170
        scrollView.contentInset = contentInset
        dump(scrollView.contentInset)
        
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        
        let contentInset: UIEdgeInsets = .zero
        scrollView.contentInset = contentInset
        scrollView.contentInset.bottom = 0
    
    }
    
    @objc func handleTap(_ sender: UIGestureRecognizer? = nil) {
        txtShareMessage.resignFirstResponder()
    }

    @IBAction func shareFacebook(_ sender: Any) {
        
        let facebookShareVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        
        if let vc = facebookShareVC,
           let message = txtShareMessage.text {
            vc.setInitialText(message)
            vc.add(imageShare.image)
            vc.add(URL(string: "https://platzi.com/"))
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .formSheet
            self.present(vc, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func shareTwitter(_ sender: Any) {
    
        guard let button = sender as? UIButton else {
            return
        }
        
        let serviceType = button.tag == 1 ? SLServiceTypeTwitter : SLServiceTypeLinkedIn
        let facebookShareVC = SLComposeViewController(forServiceType: serviceType)
        
        if let vc = facebookShareVC,
           let message = txtShareMessage.text {
            vc.setInitialText(message)
            vc.add(imageShare.image)
            vc.add(URL(string: "https://platzi.com/"))
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .formSheet
            self.present(vc, animated: true, completion: nil)
            
        }
        
    }
    
}

