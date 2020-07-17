//
//  receiptTableViewCell.swift
//  LatPayPOS
//
//  Created by user166170 on 6/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import UIKit

class receiptTableViewCell: UITableViewCell
{

    @IBOutlet weak var moneyImage: UIImageView!
    @IBOutlet weak var receiptPrice: UILabel!
    @IBOutlet weak var dateAndTime: UILabel!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var numberOfProducts: UILabel!
    @IBOutlet weak var productsList: UILabel!
    @IBOutlet weak var couponName: UILabel!
    @IBOutlet weak var couponPrice: UILabel!
    @IBOutlet weak var actualPrice: UILabel!
    
    
    override func awakeFromNib()
    {
        cellDesign()
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    func cellDesign()
    {
        insideView.layer.cornerRadius = 5
        numberOfProducts.isHidden = true
        productsList.isHidden = true
        couponName.isHidden = true
        couponPrice.isHidden = true
        actualPrice.isHidden = true
    }

}
