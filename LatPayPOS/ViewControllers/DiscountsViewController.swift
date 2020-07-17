//
//  DiscountsViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import UIKit

class DiscountsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var addButtonlabel: UIButton!
    @IBOutlet weak var discountTableView: UITableView!
    @IBOutlet weak var backButtonLabel: UIButton!
    @IBOutlet weak var noItemImage: UIImageView!
    
    var discount: [Discounts] = []
    
    override func viewDidLoad()
    {
        designFunctionDVC()
        showDiscountAtInitial()
        discountTableView.delegate = self
        discountTableView.dataSource = self
        discountTableView.tableFooterView = UIView()
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(discountLoad), name: NSNotification.Name(rawValue: "loadDiscount"), object: nil)
    }
    
    @objc func discountLoad()
    {
        print("Discount Notification Center Called")
        self.reloadDiscountListAgain()
    }
    
    @IBAction func onTapBackButton(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addDiscount(_ sender: Any)
    {
        performSegue(withIdentifier: "addDiscount", sender: self)
    }
    
    //TableView Datasource Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("Discount Counts :", discount.count)
        return discount.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = discountTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! discountTableViewCell
        let disc = discount[indexPath.row]
        cell.discountName.text = disc.discountName
        cell.discountPercentage.text = String(disc.discountPercentage)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 75.0
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        let alert = UIAlertController(title: "Attention", message: "Are you sure want to delete Discount?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {(_: UIAlertAction!) in
        }))
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            
            if editingStyle == .delete
            {
                self.deleteDiscount(at: indexPath)
            }
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
