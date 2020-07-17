//
//  discountTableViewCell.swift
//  LatPayPOS
//
//  Created by user166170 on 6/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import UIKit

class discountTableViewCell: UITableViewCell
{

    @IBOutlet weak var discountName: UILabel!
    @IBOutlet weak var discountPercentage: UILabel!
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
