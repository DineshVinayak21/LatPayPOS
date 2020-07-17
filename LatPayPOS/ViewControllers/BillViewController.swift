//
//  BillViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/14/20.
//  Copyright © 2020 dss. All rights reserved.
//

import UIKit
import CoreData

class BillViewController: UIViewController
{
    var currentDateTime = String()
    var totalPrice = String()
    var numberOfProducts = String()
    var productList = String()
    var couponName = String()
    var couponPrice = String()
    var actualPrice = String()
    var singleProductPrice = String()
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var doneButtonLabel: UIButton!
    @IBOutlet weak var dateAndTime: UILabel!
    @IBOutlet weak var total: UILabel!
    
    @IBAction func done(_ sender: Any)
    {
        receiptAlert()
    }
    override func viewDidLoad()
    {
        savingValuesToReciptDataBase()
        dateAndTime.text = currentDateTime
        total.text = "AUD \(totalPrice)"
        designFunctionBVC()
        super.viewDidLoad()
    }
    
    func receiptAlert()
    {
        let alert = UIAlertController(title: "Thank You", message: "Would you like to have a Receipt?", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { _ in
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Yes",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
                                        //Sign out action
                                        self.performSegue(withIdentifier: "smsmail", sender: self)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard let destination1 = segue.destination as? SmsMailViewController else { return }
        destination1.payment = totalPrice
    }
}
