//
//  flatPriceTableViewCell.swift
//  LatPayPOS
//
//  Created by user166170 on 6/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import UIKit

class flatPriceTableViewCell: UITableViewCell
{

    @IBOutlet weak var flatPriceName: UILabel!
    @IBOutlet weak var flatPriceAmount: UILabel!
    @IBOutlet weak var insideView: UIView!
    
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
