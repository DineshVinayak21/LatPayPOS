//
//  itemsTableViewCell.swift
//  LatPayPOS
//
//  Created by user166170 on 6/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import UIKit

class itemsTableViewCell: UITableViewCell
{
    var del: transferValue?
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var removeButtonLabel: UIButton!
    @IBOutlet weak var addButtonLabel: UIButton!
    @IBOutlet weak var insidecellView: UIView!
    @IBOutlet weak var size: UILabel!
    
    override func awakeFromNib()
    {
        design()
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func removeAction(_ sender: Any)
    {
        print("remove button")
        removeButtonLabel.isHidden = true
        addButtonLabel.isHidden = false
        del?.removeTransfer(name: itemName.text!, price: itemPrice.text!, size: size.text!)
    }
    
    @IBAction func addAction(_ sender: Any)
    {
        print("add button")
        removeButtonLabel.isHidden = false
        addButtonLabel.isHidden = true
        del?.transfer(name: itemName.text!, price: itemPrice.text!, size: size.text!)
    }
    
    func design()
        {
            size.isHidden = true
            removeButtonLabel.isHidden = true
            insidecellView.layer.cornerRadius = 5
            removeButtonLabel.layer.cornerRadius = 5
            addButtonLabel.layer.cornerRadius = 5
        }
    }

protocol transferValue
{
    func transfer(name: String, price: String, size: String)
    func removeTransfer(name: String, price: String, size: String)
}
