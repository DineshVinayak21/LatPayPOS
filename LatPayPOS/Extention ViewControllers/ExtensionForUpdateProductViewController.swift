//
//  ExtensionForUpdateProductViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/14/20.
//  Copyright © 2020 dss. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension UpdateProductViewController: UITextFieldDelegate
{
    func designFunctionUPVC()
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
        
        newName.delegate = self
        newPrice.delegate = self
        newCategory.delegate = self
        newQuantity.delegate = self
        newDescription.delegate = self
        
        newPrice.keyboardType = UIKeyboardType.numbersAndPunctuation
        newQuantity.keyboardType = UIKeyboardType.numbersAndPunctuation
    }
    
    func loadNewCategoryForDropDown()
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
                    newDropDownValues.append((temp.value(forKey: "title") as! String))
                }
                print("Titles are:", newDropDownValues)
                newCategory.optionArray = newDropDownValues
            }
        }
        catch
        {
            print("could not fetch result")
        }
    }
    
    func newCategorySelection()
    {
        newCategory.didSelect{(selectedText, index, id) in
        print("value", selectedText)
            self.newSelectedCategory = selectedText
        }
    }
    
    func saveAlert()
    {
        let alert = UIAlertController(title: "Saved!!", message: "Product Updated Successfully", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadUpdatedProduct"), object: nil)
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //TextField Delegates
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == newQuantity {
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
        if textField == newPrice {
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
        if textField == newPrice
        {
            moveTextField(textField, moveDistance: -130, up: true)
        }
        if textField == newQuantity
        {
            moveTextField(textField, moveDistance: -60, up: true)
        }
        
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if textField == newPrice
        {
            moveTextField(textField, moveDistance: 130, up: true)
        }
        if textField == newQuantity
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
