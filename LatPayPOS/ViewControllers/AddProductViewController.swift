//
//  AddProductViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import UIKit
import CoreData

class AddProductViewController: UIViewController
{

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var cancelButtonLabel: UIButton!
    @IBOutlet weak var createProductLabel: UILabel!
    @IBOutlet weak var produtName: UITextField!
    @IBOutlet weak var productDescription: UITextField!
    @IBOutlet weak var productCategory: DropDown!
    @IBOutlet weak var productQuantity: UITextField!
    @IBOutlet weak var productPrice: UITextField!
    @IBOutlet weak var addProductButtonLabel: UIButton!
    @IBOutlet weak var insideView: UIView!
    
    var category: [Categories] = []
    var dropDownValues: [String] = []
    var selectedCategory: String = ""
    
    override func viewDidLoad()
    {
        loadCategoryForDropDown()
        designFunctionAPVC()
        categorySelection()
        super.viewDidLoad()
    }
    
    @IBAction func cancelScreen(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addProduct(_ sender: Any)
    {
        if (produtName.text == "" || productDescription.text == "" || productCategory.text == "" || productQuantity.text == "" || productPrice.text == "")
        {
            print("Fill All Details to Save")
            pleaseEnterAllAlert()
        }
        else
        {
            let name = produtName.text
            let description = productDescription.text
            let tempQuantity = productQuantity.text ?? "0"
            let finalQuantity = Int16(tempQuantity)
            let tempPrice = productPrice.text ?? "0.0"
            let finalPrice = Double(tempPrice)
            let allCat = selectedCategory

            let productClass = Products(name: name!, quantity: finalQuantity!, price: finalPrice!, mainCategory: allCat, desc: description!)
            do
            {
                try productClass?.managedObjectContext?.save()
                print("Product Saved Successfully")
            }
            catch
            {
                print("Could Not Save Products")
            }
            
            print("Product Name: ", name as Any)
            print("Description: ", description as Any)
            print("Price: ", finalPrice as Any)
            print("Quantity: ", finalQuantity as Any)
            print("Category: ", selectedCategory)
            self.saveAlert()
        }
    }
    
    
}
