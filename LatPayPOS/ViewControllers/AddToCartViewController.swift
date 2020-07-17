//
//  AddToCartViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/14/20.
//  Copyright © 2020 dss. All rights reserved.
//

import UIKit
import LocalAuthentication

class AddToCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, quantityChange
    
{

    var nameArr : [String] = []
    var priceArr : [String] = []
    var tempNameArr : [String] = []
    var tempPriceArr : [Double] = []
    var productQuantity : [String] = []
    
    var loadingIndicator = UIActivityIndicatorView()
    
    var sum: Double?
    var tryName: String?
    var tryPrice: Double?
    var tryQuantity: Int?
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var cartTable: UITableView!
    @IBOutlet weak var placeOrdelLabel: UIButton!
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var backLabel: UIButton!
    @IBOutlet weak var applyCouponButtonLabel: UIButton!
    
    var cName = String()
    var cPercentage = Int16()
    var cDiscount = Int16()
    
    var tempDName = String()
    var tempDPercentage = String()
    var tempDPrice = String()
    var temp = Double()
    
    var actualPriceHere = Double()
    var discountedPriceHere = Double()
    
    override func viewDidLoad()
    {
        frontDesignView()
        print("Second VC :", nameArr)
        print("Second VC :", priceArr)
        cartTable.delegate = self
        cartTable.dataSource = self
        initialCalculation()
        cartTable.delegate = self
        cartTable.dataSource = self
        cartTable.tableFooterView = UIView()
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(applyCouponHere), name: NSNotification.Name(rawValue: "applyDiscount"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applyFlatPriceHere), name: NSNotification.Name(rawValue: "applyFlatPrice"), object: nil)
    }
    
    @objc func applyCouponHere(notification: Notification)
    {
        print("Notification Center Called From Discount VC")
        let couponVC = notification.object as! ApplyCouponViewController
        tempDName = couponVC.tempDisocuntName
        tempDPercentage = couponVC.tempDisocuntPercentage
        tempDPrice = couponVC.tempDisocuntPrice
        
        print(tempDName)
        print(tempDPercentage)
        print(tempDPrice)
        
//        applyCouponButtonLabel.titleLabel?.text = tempDName
        applyCouponButtonLabel.setTitle(tempDName, for: .normal)
        detectingDiscount()
    }
    
    @objc func applyFlatPriceHere(notification: Notification)
    {
        print("Notification Center Called From Discount VC")
        let couponVC = notification.object as! ApplyCouponViewController
        tempDName = couponVC.tempDisocuntName
        tempDPrice = couponVC.tempDisocuntPrice
        print(tempDName)
        print(tempDPrice)
        let compare = Double(totalPriceLbl.text!)
        let compare2 = Double(tempDPrice)
        if (compare?.isLess(than: compare2!))!
        {
            print("Coupon Can't Be Applied")
        }
        //applyCouponButtonLabel.titleLabel?.text = tempDName
        applyCouponButtonLabel.setTitle(tempDName, for: .normal)
        detectingFlatPrice()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        CommonActivityIndicator().defaultActivityIndicator(uiView: self.view)
    }

    @IBAction func applyCoupon(_ sender: Any)
    {
        if applyCouponButtonLabel.titleLabel?.text != "Apply Coupon"
        {
            
            let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Change Offer", style: .default, handler: { (_) in
            print("You've pressed default")
            self.totalPriceLbl.text = String(self.temp)
            self.performSegue(withIdentifier: "coupon", sender: self)
        }))

            alert.addAction(UIAlertAction(title: "Delete Offer", style: .destructive, handler: { (_) in
            print("You've pressed cancel")
            self.totalPriceLbl.text = String(self.temp)
            self.applyCouponButtonLabel.setTitle("Apply Coupon", for: .normal)
        }))

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            print("You've pressed the destructive")
        }))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            performSegue(withIdentifier: "coupon", sender: self)
        }
        
    }
    
    @IBAction func placeOrder(_ sender: Any)
    {
            alert()
            print("Success Message")
    }
        
    @IBAction func back(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
        
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return nameArr.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = cartTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cartTableViewCell
        cell.itemName.text = nameArr[indexPath.row]
        cell.itemPrice.text = priceArr[indexPath.row]
        cell.productOverallQuantity.text = productQuantity[indexPath.row]
        cell.quantity.text = "1"
        cell.selectionStyle = .none
        cell.dele = self
        
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 65
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        let alert = UIAlertController(title: "Attention", message: "Are you sure want to delete Product?", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
                   
        if editingStyle == .delete
        {
            self.nameArr.remove(at: indexPath.row)
            self.priceArr.remove(at: indexPath.row)
            self.productQuantity.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            DispatchQueue.main.async
            {
                print("Dispatch Queue Worked")
                self.cartTable.reloadData()
                //self.initialCalculation()
                self.calculationAfterRowDeleted()
                let cell = self.cartTable.cellForRow(at: indexPath) as? cartTableViewCell
                cell?.plusLabel.isHidden = false
            }
        }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in }))
        //secondtbl.reloadData()
        //initialCalculation()
        self.present(alert, animated: true, completion: nil)
    }
        
    func alert()
    {
        let alert = UIAlertController(title: "Confirmation", message: "Your Total Payable Amount is $.\(totalPriceLbl.text!)", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Approve", style: .default, handler: { (_) in
                //self.performSegue(withIdentifier: "bill", sender: self)
                //self.tapCardActivity()
                self.authenticateUser()
                
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
        
    func initialCalculation()
    {
        tempPriceArr = priceArr.map { Double($0)!}
        tempNameArr = nameArr.map { String($0)}
        print("initial names :", tempNameArr)
        print("initial price :", tempPriceArr)
        sum = tempPriceArr.reduce(0, +)
        totalPriceLbl.text = "\(sum!)"
        actualPriceHere = sum!
    }
        
    func calculationAfterRowDeleted()
    {
        print("calculationAfterRowDeleted called")
        tempPriceArr = priceArr.map { Double($0)!}
        tempNameArr = nameArr.map {String ($0)}
        print("check this tempName Arr after row deleted :", tempNameArr)
        print("check this tempPrice Arr after row deleted :", tempPriceArr)
        sum = tempPriceArr.reduce(0, +)
        print("Sum ->", sum)
        totalPriceLbl.text = "\(sum!)"
        actualPriceHere = sum!
    }
        
    func addQuantity(name: String, price: Double, quantity: Int)
    {
        tryName = name
        tryPrice = price
        tryQuantity = quantity
        
        print("tryName :", tryName!)
        print("tryPrice :", tryPrice!)
        print("tryQuantity :", tryQuantity!)
        calculate()
    }
        
    func subQuantity(name: String, price: Double, quantity: Int)
    {
        tryName = name
        tryPrice = price
        tryQuantity = quantity
        
        print("tryName :", tryName!)
        print("tryPrice :", tryPrice!)
        print("tryQuantity :", tryQuantity!)
        calculate2()
    }
        
    func calculate()
    {
        let temp = totalPriceLbl.text!
        print(temp)
        let final = "\(Double(temp)! + tryPrice!)"
        totalPriceLbl.text = final
        actualPriceHere = Double(final)!
    }
        
    func calculate2()
    {
        let temp = totalPriceLbl.text!
        print(temp)
        let final = "\(Double(temp)! - tryPrice!)"
        totalPriceLbl.text = final
        actualPriceHere = Double(final)!
    }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
            if segue.destination is BillViewController
            {
                let receiptVC = segue.destination as! BillViewController

                //Getting Current Date and Time
                let now = Date()
                let formatter = DateFormatter()
                formatter.timeZone = TimeZone.current
                formatter.dateFormat = "yyyy-MM-dd / HH:mm:ss"
                let dateString = formatter.string(from: now)
                
                //Getting List of Products
                let str = tempNameArr.map { String($0) }.joined(separator: ", ")
                
                //Getting Number of Products
                let temp = cartTable.numberOfRows(inSection: Int())
                
                receiptVC.currentDateTime = dateString
                receiptVC.totalPrice = totalPriceLbl.text!
                receiptVC.numberOfProducts = String(temp)
                receiptVC.productList = str
                receiptVC.couponName = applyCouponButtonLabel.titleLabel?.text as! String
                receiptVC.couponPrice = String(discountedPriceHere)
                receiptVC.actualPrice = String(actualPriceHere)
                receiptVC.singleProductPrice = "1"
            }
            
            if segue.destination is ApplyCouponViewController
            {
                let receiveVC = segue.destination as! ApplyCouponViewController
                receiveVC.actualPrice = totalPriceLbl.text!
            }
        }
        
    func authenticateUser()
    {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
        let reason = "Identify Yourself!"

        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason)
        {
            [unowned self] success, authenticationError in
            DispatchQueue.main.async {
                if success {
                        print("SUccess")
                        self.tapCardActivity()
                        } else {
                            let ac = UIAlertController(title: "Authentication failed", message: "Sorry!", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(ac, animated: true)
                        }
                    }
                }
            } else {
                let ac = UIAlertController(title: "Touch ID Not Available", message: "Proceed With Care!", preferredStyle: .alert)
                //ac.addAction(UIAlertAction(title: "OK", style: .default))
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                self.tapCardActivity()
                }))
                
                present(ac, animated: true)
            }
        }

}
