//
//  ViewController.swift
//  TextViewSample
//
//  Created by Hayashidesu on 2014/12/31.
//  Copyright (c) 2014年 Hayashidesu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scvBackGround: UIScrollView!
    @IBOutlet weak var txtLogin: UITextField!
    @IBOutlet weak var txtPassword: UITextField!

    var txtActiveField = UITextField()
    
    func textFieldShouldBeginEditing(textField: UITextField!) -> Bool {
        txtActiveField = textField
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func handleKeyboardWillShowNotification(notification: NSNotification) {
        
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
        let myBoundSize: CGSize = UIScreen.mainScreen().bounds.size
        
        let txtLimit = txtActiveField.frame.origin.y + txtActiveField.frame.height + 8.0
        let kbdLimit = myBoundSize.height - keyboardScreenEndFrame.size.height

        println("テキストフィールドの下辺:\(txtLimit)")
        println("キーボードの上辺:\(kbdLimit)")
        
        if txtLimit >= kbdLimit {
            scvBackGround.contentOffset.y = txtLimit - kbdLimit
        }
    }
    
    func handleKeyboardWillHideNotification(notification: NSNotification) {
        scvBackGround.contentOffset.y = 0
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "handleKeyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "handleKeyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

