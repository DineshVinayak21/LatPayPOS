//
//  applyDiscountTableViewCell.swift
//  LatPayPOS
//
//  Created by user166170 on 6/15/20.
//  Copyright © 2020 dss. All rights reserved.
//

import UIKit

class applyDiscountTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var discountCouponName: UILabel!
    @IBOutlet weak var discountCouponPercentage: UILabel!
    @IBOutlet weak var maxDiscountPrice: UILabel!
    
    override func awakeFromNib()
    {
        insideView.layer.cornerRadius = 5
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}
