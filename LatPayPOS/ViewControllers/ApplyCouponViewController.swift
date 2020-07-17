//
//  ApplyCouponViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/15/20.
//  Copyright © 2020 dss. All rights reserved.
//

import UIKit
import CoreData

class ApplyCouponViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet weak var backLabel: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var applyCoupon: UITableView!
    
    var discount = [Discounts]()
    var flatPrice = [FlatPrice]()
    
    var couponName = String()
    var couponPercentage = Int16()
    var maxDiscount = Int16()
    
    var actualPrice = String()
    var tempDisocuntName = String()
    var tempDisocuntPercentage = String()
    var tempDisocuntPrice = String()
    
    override func viewDidLoad()
    {
        applyCoupon.delegate = self
        applyCoupon.dataSource = self
        loadingDiscountAtInitial()
        loadingFlatPriceAtInitial()
        validation()
        designFunctionACVC()
        applyCoupon.tableFooterView = UIView()
        super.viewDidLoad()
    }
    
    @IBAction func onTapBack(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    //TableView DataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section
        {
            case 0:
                return discount.count
            case 1:
                return flatPrice.count
            default:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.section
        {
            case 0:
                let cell = applyCoupon.dequeueReusableCell(withIdentifier: "first", for: indexPath) as! applyDiscountTableViewCell
                let disc = discount[indexPath.row]
                cell.discountCouponName.text = disc.discountName
                cell.discountCouponPercentage.text = String(disc.discountPercentage)
                cell.maxDiscountPrice.text = String(disc.discountMaximumPrice)
                cell.selectionStyle = .none
                return cell
            case 1:
                let cell = applyCoupon.dequeueReusableCell(withIdentifier: "second", for: indexPath) as! applyPriceTableViewCell
                let flat = flatPrice[indexPath.row]
                cell.CouponName.text = flat.couponName
                cell.CouponRate.text = String(flat.couponPrice)
                cell.selectionStyle = .none
                return cell
            default:
                return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath.section
        {
            case 0:
                return 100.0
            case 1:
                return 75.0
            default:
                return 60.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        switch indexPath.section
        {
        case 0:
                let cell = applyCoupon as? applyDiscountTableViewCell
                let disc = discount[indexPath.row]
                tempDisocuntName = disc.discountName!
                tempDisocuntPercentage = String(disc.discountPercentage)
                tempDisocuntPrice = String(disc.discountMaximumPrice)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "applyDiscount"), object: self)
                couponAppliedAlert()
        case 1:
                let cell = applyCoupon as? applyPriceTableViewCell
                let flat = flatPrice[indexPath.row]
                tempDisocuntName = flat.couponName!
                tempDisocuntPrice = String(flat.couponPrice)
                if (Double(actualPrice)?.isLessThanOrEqualTo(Double(flat.couponPrice)))!
                {
                    couponCantAppliedAlert()
                }
                else
                {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "applyFlatPrice"), object: self)
                    couponAppliedAlert()
                }
        default:
            return
        }
    }

}
