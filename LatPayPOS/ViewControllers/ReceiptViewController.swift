//
//  ReceiptViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import UIKit

class ReceiptViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    var receipt: [Receipt] = []
    
    @IBOutlet weak var receiptLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var receiptTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var noTransImage: UIImageView!
    
    
    var tempActualPrice = String()
    var tempCouponName = String()
    var tempCouponPrice = String()
    var tempDateAndTime = String()
    var tempReceiptPrice = String()
    var tempNumberOfProducts = String()
    var tempProductsList = String()
    
    override func viewDidLoad()
    {
        receiptTableView.delegate = self
        receiptTableView.dataSource = self
        receiptTableView.reloadData()
        designFunctionRVC()
        fetchingReceiptDetails()
        receiptTableView.tableFooterView = UIView()
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(loadTable), name: NSNotification.Name(rawValue: "reloadReceiptVC"), object: nil)
    }
    
    @objc func loadTable()
    {
        print("rceipt notification center called")
        fetchingReceiptDetails()
        receiptTableView.reloadData()
    }
    
    //TableView Vaues Initialization
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("Total Count :", receipt.count)
        return receipt.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = receiptTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! receiptTableViewCell
        let recpt = receipt[indexPath.row]
        cell.actualPrice.text = recpt.calculatedPrice
        cell.couponName.text = recpt.couponName
        cell.couponPrice.text = recpt.discountedPrice
        cell.dateAndTime.text = recpt.date
        cell.receiptPrice.text = recpt.finalPrice
        cell.numberOfProducts.text = recpt.totalCount
        cell.productsList.text = recpt.productName
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = receiptTableView as? receiptTableViewCell
        let recpt = receipt[indexPath.row]
        tempActualPrice = recpt.calculatedPrice!
        tempCouponName = recpt.couponName!
        tempCouponPrice = recpt.discountedPrice!
        tempDateAndTime = recpt.date!
        tempReceiptPrice = recpt.finalPrice!
        tempNumberOfProducts = recpt.totalCount!
        tempProductsList = recpt.productName!
        self.performSegue(withIdentifier: "receipt", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        let alert = UIAlertController(title: "Attention", message: "Are you sure want to delete Receipt?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {(_: UIAlertAction!) in
        }))
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            
            if editingStyle == .delete
            {
                self.deleteReceipt(at: indexPath)
            }
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is DetailedReceiptViewController
        {
            let detailVC = segue.destination as! DetailedReceiptViewController
            detailVC.updateActualPrice = tempActualPrice
            if tempCouponName == "Apply Coupon"
            {
                tempCouponName = "None"
                detailVC.updateCouponName = tempCouponName
            }
            else
            {
                detailVC.updateCouponName = tempCouponName
            }
            detailVC.updateCouponPrice = tempCouponPrice
            detailVC.updateDateAndTime = tempDateAndTime
            detailVC.updateReceiptPrice = tempReceiptPrice
            detailVC.updateNumberOfProducts = tempNumberOfProducts
            detailVC.updateProductsList = tempProductsList
        }
    }
}
