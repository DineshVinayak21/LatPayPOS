//
//  ExtensionForAddProductViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension AddProductViewController: UITextFieldDelegate
{
    func designFunctionAPVC()
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
        addProductButtonLabel.layer.cornerRadius = 5
        createProductLabel.layer.cornerRadius = 5
        
        produtName.delegate = self
        productDescription.delegate = self
        productCategory.delegate = self
        productQuantity.delegate = self
        productPrice.delegate = self
        
        productPrice.keyboardType = UIKeyboardType.numbersAndPunctuation
        productQuantity.keyboardType = UIKeyboardType.numbersAndPunctuation
    }
    
    func loadCategoryForDropDown()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else
        {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<Categories> = Categories.fetchRequest()
        
        do
        {
            category = try managedContext.fetch(fetchRequest)
            print("Fetch Function Called Successfully")
            if self.category == []
            {
                print("Category List Empty")
            }
            else
            {
                print(self.category)
                for temp in category as [NSManagedObject]
                {
                    dropDownValues.append((temp.value(forKey: "title") as! String))
                }
                print("Titles are:", dropDownValues)
                productCategory.optionArray = dropDownValues
            }
        }
        catch
        {
            print("could not fetch result")
        }
    }
    
    func categorySelection()
    {
        productCategory.didSelect{(selectedText, index, id) in
        print("value", selectedText)
            self.selectedCategory = selectedText
        }
    }
    
    func saveAlert()
    {
        let alert = UIAlertController(title: "Saved!!", message: "Product Added Successfully", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadProduct"), object: nil)
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
    
    //TextField Delegates
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == productQuantity {
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
        if textField == productPrice {
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
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if textField == productPrice
        {
            moveTextField(textField, moveDistance: -130, up: true)
        }
        if textField == productQuantity
        {
            moveTextField(textField, moveDistance: -60, up: true)
        }
        
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if textField == productPrice
        {
            moveTextField(textField, moveDistance: 130, up: true)
        }
        if textField == productQuantity
        {
            moveTextField(textField, moveDistance: 60, up: true)
        }
    }
    
    // Move the text field in a pretty animation!
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool)
    {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        //self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        insideView.frame = insideView.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
}
