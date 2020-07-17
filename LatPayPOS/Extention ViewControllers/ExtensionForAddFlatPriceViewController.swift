//
//  ExtensionForAddFlatPriceViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import Foundation
import UIKit

extension AddFlatPriceViewController: UITextFieldDelegate
{
    func designFunctionAFPVC()
    {
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
        addCouponLabel.layer.cornerRadius = 5
        flatPriceLabel.layer.cornerRadius = 5
        
        offerName.delegate = self
        offerPrice.delegate = self
        addCouponLabel.layer.cornerRadius = 5
        
        offerPrice.keyboardType = UIKeyboardType.numbersAndPunctuation
    }
    
    func saveAlert()
    {
        let alert = UIAlertController(title: "Saved!!", message: "Discount Coupon Saved Successfully", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadFlatPrice"), object: nil)
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func pleaseEnterAllAlert()
    {
        let alert = UIAlertController(title: "Invalid!!", message: "Please Enter Value for All Fields", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //TextField Delegate Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == offerPrice {
            let allowedCharacters = "1234567890."
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
        if textField == offerName {
                   let NewLength = (textField.text?.count)! + string.count - range.length
                   return NewLength <= 10
        }
        return true
    }
}
