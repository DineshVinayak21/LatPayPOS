//
//  cartTableViewCell.swift
//  LatPayPOS
//
//  Created by user166170 on 6/15/20.
//  Copyright © 2020 dss. All rights reserved.
//

import UIKit

class cartTableViewCell: UITableViewCell
{
    
    var dele: quantityChange?
    
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var plusLabel: UIButton!
    @IBOutlet weak var minusLabel: UIButton!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var productOverallQuantity: UILabel!
    
    override func awakeFromNib()
    {
        design()
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func plusCart(_ sender: Any)
    {
        var temp = Int(quantity.text!)
        temp = temp! + 1
        if temp! < Int(productOverallQuantity.text!)!
        {
            plusLabel.isHidden = false
            quantity.text = "\(temp!)"
            let temp2 = Double(itemPrice.text!)
            dele?.addQuantity(name: itemName.text!, price: temp2!, quantity: temp!)
        }
        else if temp! == Int(productOverallQuantity.text!)!
        {
            plusLabel.isHidden = true
            quantity.text = "\(temp!)"
            let temp2 = Double(itemPrice.text!)
            dele?.addQuantity(name: itemName.text!, price: temp2!, quantity: temp!)
        }
        else
        {
            plusLabel.isHidden = true
            print("Unable to Increase")
        }
    }
    
    @IBAction func minusCart(_ sender: Any)
    {
        plusLabel.isHidden = false
        var temp = Int(quantity.text!)
        temp = temp! - 1
        if temp! < 1
        {
            print("unable to reduce cart")
        }
        else{
            quantity.text = "\(temp!)"
            let temp2 = Double(itemPrice.text!)
            dele?.subQuantity(name: itemName.text!, price: temp2!, quantity: temp!)
        }
    }
    
    func design()
    {
        quantity.layer.cornerRadius = 5
        minusLabel.layer.cornerRadius = 5
        plusLabel.layer.cornerRadius = 5
        insideView.layer.cornerRadius = 5
    }

}

protocol quantityChange
{
    func addQuantity(name: String, price: Double, quantity: Int)
    func subQuantity(name: String, price: Double, quantity: Int)
}
