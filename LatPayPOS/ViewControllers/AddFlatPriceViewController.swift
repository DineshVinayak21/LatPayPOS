//
//  AddFlatPriceViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import UIKit

class AddFlatPriceViewController: UIViewController
{
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var cancelButtonLabel: UIButton!
    @IBOutlet weak var flatPriceLabel: UILabel!
    @IBOutlet weak var offerName: FloatingLabelTextField!
    @IBOutlet weak var offerPrice: FloatingLabelTextField!
    @IBOutlet weak var addCouponLabel: UIButton!
    
    override func viewDidLoad()
    {
        designFunctionAFPVC()
        super.viewDidLoad()
    }
    
    @IBAction func cancelScreen(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addCoupon(_ sender: Any)
    {
        if (offerName.text == "" || offerPrice.text == "")
        {
            print("Fill All Details to Save")
            pleaseEnterAllAlert()
        }
        else
        {
            let name = offerName.text
            let tempPrice = offerPrice.text ?? "0"
            let price = Int16(tempPrice)
            
            let flatPriceClass = FlatPrice(couponName: name!, couponPrice: price!)
            do
            {
                try flatPriceClass?.managedObjectContext?.save()
                print("FlatPrice Coupon Saved Successfully")
            }
            catch
            {
                print("Could Not Save Products")
            }
            
            print("Coupon Name: ", name as Any)
            print("FlatPrice: ", price as Any)
            self.saveAlert()
        }
    }
    
}
