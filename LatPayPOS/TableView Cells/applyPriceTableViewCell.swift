//
//  applyPriceTableViewCell.swift
//  LatPayPOS
//
//  Created by user166170 on 6/15/20.
//  Copyright © 2020 dss. All rights reserved.
//

import UIKit

class applyPriceTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var CouponName: UILabel!
    @IBOutlet weak var CouponRate: UILabel!
    
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
