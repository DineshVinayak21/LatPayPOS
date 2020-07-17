//
//  DetailedReceiptViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/14/20.
//  Copyright © 2020 dss. All rights reserved.
//

import UIKit

class DetailedReceiptViewController: UIViewController
{

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backButtonLabel: UIButton!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var topFinalAmount: UILabel!
    @IBOutlet weak var numOfProducts: UILabel!
    @IBOutlet weak var listOfProducts: UILabel!
    @IBOutlet weak var actualPrice: UILabel!
    @IBOutlet weak var couponPrice: UILabel!
    @IBOutlet weak var couponName: UILabel!
    @IBOutlet weak var bottomFinalAmount: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var sendReceipt: UIButton!
    
    var updateActualPrice = String()
    var updateCouponName = String()
    var updateCouponPrice = String()
    var updateDateAndTime = String()
    var updateReceiptPrice = String()
    var updateNumberOfProducts = String()
    var updateProductsList = String()
    
    override func viewDidLoad()
    {
        designFunctionDRVC()
        super.viewDidLoad()
    }
    
    @IBAction func onTapBack(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendReceiptFunction(_ sender: Any)
    {
        performSegue(withIdentifier: "smsandmail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard let destination1 = segue.destination as? SmsMailViewController else { return }
        destination1.payment = bottomFinalAmount.text!
    }
}
