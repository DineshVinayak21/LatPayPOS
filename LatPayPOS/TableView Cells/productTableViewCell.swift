//
//  productTableViewCell.swift
//  LatPayPOS
//
//  Created by user166170 on 6/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import UIKit

class productTableViewCell: UITableViewCell
{
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productCategory: UILabel!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var deleteImage: UIImageView!
    
    override func awakeFromNib()
    {
        insideView.layer.cornerRadius = 5
        productName.layer.cornerRadius = 5
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}
