//
//  ExtensionForSmsMailViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/14/20.
//  Copyright © 2020 dss. All rights reserved.
//

import Foundation
import UIKit

extension SmsMailViewController: UITextFieldDelegate
{
    func frontDesignView()
    {
        //Design Constraints for Top Layer
        let shadowPath = UIBezierPath()
        let shadowWidth : CGFloat = 1.5
        let shadowHeight : CGFloat = 0.0
        let shadowRadious : CGFloat = 2
        
        let width = topView.frame.width
        let height = topView.frame.height
        
        shadowPath.move(to: CGPoint(x: shadowRadious/2, y: height - shadowRadious/2))
        shadowPath.addLine(to: CGPoint(x: width - shadowRadious / 2, y: height - shadowRadious / 2))
        shadowPath.addLine(to: CGPoint(x: width * shadowWidth, y: height + (height * shadowHeight)))
        shadowPath.addLine(to: CGPoint(x: width * -(shadowWidth - 1), y: height + (height * shadowHeight)))
        
        topView.layer.shadowPath = shadowPath.cgPath
        topView.layer.shadowRadius = shadowRadious
        topView.layer.shadowOffset = .zero
        topView.layer.shadowOpacity = 0.5
        cancelButtonLabel.layer.cornerRadius = 5
        doneButtonLabel.layer.cornerRadius = 5
        chooseLabel.layer.cornerRadius = 10
        smsLabel.layer.cornerRadius = 5
        mailLabel.layer.cornerRadius = 5
        
        mailField.layer.cornerRadius = 5
        numberField.layer.cornerRadius = 5
        midView.layer.cornerRadius = 5
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == numberField {
            let allowedCharacters = "1234567890"
            let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
                   let typedCharacterSet = CharacterSet(charactersIn: string)
                   let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
                   let Range = range.length + range.location > (textField.text?.count)!
                   if Range == false && alphabet == false
                   {
                       return false
                       
                   }
                   let NewLength = (textField.text?.count)! + string.count - range.length
                   return NewLength <= 10
        }
        if textField == mailField {
            let allowedCharacters = "abcdefghijklmnopqrstuvwxyz1234567890.@"
            let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
                   let typedCharacterSet = CharacterSet(charactersIn: string)
                   let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
                   let Range = range.length + range.location > (textField.text?.count)!
                   if Range == false && alphabet == false
                   {
                       return false
                       
                   }
                   let NewLength = (textField.text?.count)! + string.count - range.length
                   return NewLength <= 30
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        textField.resignFirstResponder()
    }
    
    //KeyboardOpen
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField: textField, moveDistance: -50, up: true)
    }
    
    // KeyboardHide
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField: textField, moveDistance: -50, up: false)
    }
    
    func moveTextField(textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animationTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        midView.frame = midView.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        numberField.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        numberField.resignFirstResponder()
    }
    
    func cancelAlert()
    {
        let alert = UIAlertController(title: "Attention", message: "Don't Need Receipt?", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { _ in
            
        }))
        alert.addAction(UIAlertAction(title: "Yes",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
                                        //Sign out action
                                        self.thanksAlert()
                                        //self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func thanksAlert()
    {
        let alert = UIAlertController(title: "Thank You", message: "Keep Shopping", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: { _ in
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func tryAgainAlert()
    {
        let alert = UIAlertController(title: "Recipt Send Successfully", message: "Want to Send Again?", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { _ in
            self.thanksAlert()
        }))
        alert.addAction(UIAlertAction(title: "Yes",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
                                        //Sign out action
                                        self.numberField.text = ""
                                        self.mailField.text = ""
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func incorrectNumberAlert()
    {
        let alert = UIAlertController(title: "Mobile Number Incorrect", message: "Enter Valid Mobile Number", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            self.numberField.text = ""
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func incorrectMailAlert()
    {
        let alert = UIAlertController(title: "Email ID Incorrect", message: "Enter Valid Email", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            self.mailField.text = ""
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension String
{
    
    public func isPhone()->Bool {
        if self.isAllDigits() == true {
            let phoneRegex = "[235689][0-9]{6}([0-9]{3})?"
            let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return  predicate.evaluate(with: self)
        }else {
            return false
        }
    }
    
    private func isAllDigits()->Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = self.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  self == filtered
    }
    
    var isValidEmail: Bool {
      let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
      return testEmail.evaluate(with: self)
   }
}
