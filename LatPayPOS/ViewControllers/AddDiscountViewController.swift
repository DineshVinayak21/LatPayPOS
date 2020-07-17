//
//  AddDiscountViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import UIKit
import CoreData

class AddDiscountViewController: UIViewController
{
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var cancelButtonLabel: UIButton!
    @IBOutlet weak var createDiscountLabel: UILabel!
    @IBOutlet weak var couponName: FloatingLabelTextField!
    @IBOutlet weak var couponPercentage: FloatingLabelTextField!
    @IBOutlet weak var addDiscountButtonLabel: UIButton!
    @IBOutlet weak var maximumDiscountRate: FloatingLabelTextField!
    @IBOutlet weak var insideView: UIView!
    
    override func viewDidLoad()
    {
        designFunctionADVC()
        super.viewDidLoad()
    }
    
    @IBAction func cancelScreen(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addDiscount(_ sender: Any)
    {
        if (couponName.text == "" || couponPercentage.text == "" || maximumDiscountRate.text == "")
        {
            print("Fill All Details to Save")
            pleaseEnterAllAlert()
        }
        else
        {
            let name = couponName.text
            let tempPercentage = couponPercentage.text ?? "0"
            let percentage = Int16(tempPercentage)
            let tempDiscountRate = maximumDiscountRate.text ?? "0"
            let discountRate = Int16(tempDiscountRate)
        
            let discountClass = Discounts(discountName: name!, discountPercentage: percentage!, discountMaximumPrice: discountRate!)
            do
            {
                try discountClass?.managedObjectContext?.save()
                print("Discount Saved Successfully")
            }
            catch
            {
                print("Could Not Save Products")
            }
            
            print("Coupon Name: ", name as Any)
            print("Percentage: ", percentage as Any)
            print("Max Discount Rate: ", discountRate as Any)
            self.saveAlert()
        }
    }
    
}
