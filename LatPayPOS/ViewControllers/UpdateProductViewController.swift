//
//  UpdateProductViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/14/20.
//  Copyright © 2020 dss. All rights reserved.
//

import UIKit
import CoreData

class UpdateProductViewController: UIViewController
{
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var cancelButtonLabel: UIButton!
    @IBOutlet weak var updateProductLabel: UILabel!
    @IBOutlet weak var newName: FloatingLabelTextField!
    @IBOutlet weak var newDescription: FloatingLabelTextField!
    @IBOutlet weak var newCategory: DropDown!
    @IBOutlet weak var newQuantity: FloatingLabelTextField!
    @IBOutlet weak var newPrice: FloatingLabelTextField!
    @IBOutlet weak var saveChangesButtonLabel: UIButton!
    @IBOutlet weak var insideView: UIView!
    
    
    var category: [Categories] = []
    var newDropDownValues: [String] = []
    var newSelectedCategory: String = ""
    
    var tempName = String()
    var tempDescription = String()
    var tempQuantity = String()
    var tempPrice = String()
    var tempCategory = String()
    
    var tempSelection = String()
    var tempValue: [String] = []
    
    override func viewDidLoad()
    {
        newName.text = tempName
        newDescription.text = tempDescription
        newQuantity.text = tempQuantity
        newPrice.text = tempPrice
        newCategory.attributedPlaceholder = NSAttributedString(string: tempCategory, attributes: [NSAttributedString.Key.foregroundColor: UIColor(cgColor: #colorLiteral(red: 0.02450287715, green: 0.4335390329, blue: 0.5491459966, alpha: 1))])
        loadNewCategoryForDropDown()
        designFunctionUPVC()
        newCategorySelection()
        super.viewDidLoad()
    }
    
    @IBAction func cancelScreen(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveChanges(_ sender: Any)
    {
            let name = newName.text
            let description = newDescription.text
            let tempQuantity = newQuantity.text ?? "0"
            let finalQuantity = Int16(tempQuantity)
            let tempPrice = newPrice.text ?? "0.0"
            let finalPrice = Double(tempPrice)
            var allCat = newSelectedCategory
            
            if allCat == ""
            {
                allCat = tempCategory
            }
        
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Products")
            fetchRequest.predicate = NSPredicate(format: "name = %@", tempName)
            
            do
            {
                let test = try managedContext.fetch(fetchRequest)
                let updateValue = test[0] as! NSManagedObject
                updateValue.setValue(name, forKey: "name")
                updateValue.setValue(description, forKey: "desc")
                updateValue.setValue(finalQuantity, forKey: "quantity")
                updateValue.setValue(finalPrice, forKey: "price")
                updateValue.setValue(allCat, forKey: "mainCategory")
                do
                {
                    try managedContext.save()
                    print("new values updated successfully")
                }
                catch
                {
                    print("Could not save")
                }
            }
            catch
            {
                print("Could not update")
            }
            
            print("Product Name: ", name as Any)
            print("Description: ", description as Any)
            print("Price: ", finalPrice as Any)
            print("Quantity: ", finalQuantity as Any)
            print("Category: ", allCat as Any)
            self.saveAlert()
        
    }
    
    
}
