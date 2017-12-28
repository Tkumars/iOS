//
//  MoreViewController.swift
//  Swift-TableView-Example
//
//
//  Created by Mahi Velu on 12/26/2017.
//

import Foundation
import UIKit
import MessageUI

class MoreViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
    @IBAction func ExportData(sender: UIButton) {
        sendEmail()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["tkumars@gmail.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
            print("Failed.......")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}



