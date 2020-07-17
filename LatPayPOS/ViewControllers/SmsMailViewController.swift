//
//  SmsMailViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/14/20.
//  Copyright © 2020 dss. All rights reserved.
//

import UIKit

class SmsMailViewController: UIViewController
{

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var cancelButtonLabel: UIButton!
    @IBOutlet weak var chooseLabel: UILabel!
    @IBOutlet weak var doneButtonLabel: UIButton!
    @IBOutlet weak var smsLabel: UIButton!
    @IBOutlet weak var mailLabel: UIButton!
    @IBOutlet weak var midView: UIView!
    @IBOutlet weak var insideView: UIView!
    
    @IBOutlet weak var numberField: FloatingLabelTextField!
    @IBOutlet weak var mailField: FloatingLabelTextField!
    
    var payment: String?
    
    override func viewDidLoad()
    {
        numberField.isHidden = true
        mailField.isHidden = true
        numberField.delegate = self
        mailField.delegate = self
        numberField.keyboardType = UIKeyboardType.numberPad
        super.viewDidLoad()
        frontDesignView()
        self.addDoneButtonOnKeyboard()
    }
    
    @IBAction func onTapCancel(_ sender: Any)
    {
        //self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        cancelAlert()
    }
    
    @IBAction func done(_ sender: Any)
    {
        //thanksAlert()
        CommonActivityIndicator().defaultActivityIndicator(uiView: self.view)
        if numberField.text != ""
        {
            let temp = (numberField.text?.isPhone())
            print(temp as Any)
            print("sms if stmt executed")
            if (temp == false)
            {
                incorrectNumberAlert()
            }
            else
            {
                smsApiCalling()
            }
        }
        
        if mailField.text != ""
        {
            print("mail if stmt executed")
            mailApiCalling()
        }
    }
    @IBAction func sms(_ sender: Any)
    {
        numberField.isHidden = false
        mailField.isHidden = true
        mailField.text = ""
    }
    
    @IBAction func mail(_ sender: Any)
    {
        numberField.isHidden = true
        mailField.isHidden = false
        numberField.text = ""
    }

    func smsApiCalling()
    {
            
        let url : NSString = "https://lpshub.com/latpay/service/LatPayServices/Api/SendSMS?recipient=91\(numberField.text!)&message=Your transaction of $\(payment!) is made successfully. Payment-Reference 2124. For any Questions & Complaints - contact(044 000 111)" as NSString
            
            let urlStr : NSString = url.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
            let searchURL : NSURL = NSURL(string: urlStr as String)!
            print(searchURL)
            
            var req = URLRequest(url: searchURL as URL)
            req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            req.httpMethod = "POST"
            
            URLSession.shared.dataTask(with: req)
            {(data, response, error) in
                if error != nil
                {
                    print("Invalid Entry", error as Any)
                }
                else
                {
                    do
                    {
                        let jsonVal = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)

                        let j = jsonVal
                        print("JSon Value :", j)
                        if jsonVal is String
                        {
                            DispatchQueue.main.async
                            {
                                self.tryAgainAlert()
                            }
                        }
                        else if jsonVal is NSDictionary
                        {
                            self.incorrectNumberAlert()
                        }
                    }
                    catch
                    {
                        print("Invalid Entry", error)
                    }
                }
            }.resume()
        }
    
    func mailApiCalling()
    {
        
        let url : NSString = "https://lpshub.com/latpay/service/LatPayServices/Api/SendEmail?displayName=Test&mailTo=\(mailField.text!)&mailSub=Invoice Receipt&mailBody=Your transaction of $\(payment!) is made successfully. Payment-Reference 2124. For any Questions & Complaints - contact(044 000 111)" as NSString
        
        let urlStr : NSString = url.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
        let searchURL : NSURL = NSURL(string: urlStr as String)!
        print(searchURL)
        
        var req = URLRequest(url: searchURL as URL)
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        req.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: req)
        {(data, response, error) in
            if error != nil
            {
                print("Invalid Login", error as Any)
            }
            else
            {
                do
                {
                    let jsonVal = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)

                    let j = jsonVal
                    print("JSon Value :", j)
                    if jsonVal is String
                    {
                        DispatchQueue.main.async
                        {
                            self.tryAgainAlert()
                        }
                    }
                    else if jsonVal is NSDictionary
                    {
                        self.incorrectMailAlert()
                    }
                }
                catch
                {
                    print("Invalid Login", error)
                }
            }
        }.resume()
    }
    
}
