//
//  FlatPriceViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import UIKit

class FlatPriceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var addButtonlabel: UIButton!
    @IBOutlet weak var flatPriceTable: UITableView!
    @IBOutlet weak var backButtonLabel: UIButton!
    @IBOutlet weak var noItemImage: UIImageView!
    
    var flatPrice: [FlatPrice] = []
    
    override func viewDidLoad()
    {
        flatPriceTable.delegate = self
        flatPriceTable.dataSource = self
        flatPriceTable.tableFooterView = UIView()
        showFlatPriceAtInitial()
        designFunctionFPVC()
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(flatPriceLoad), name: NSNotification.Name(rawValue: "loadFlatPrice"), object: nil)
    }
    
    @objc func flatPriceLoad()
    {
        print("FlatPrice Notification Center Called")
        self.reloadFlatPriceListAgain()
    }
    
    @IBAction func onTapBackButton(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addFlatPrice(_ sender: Any)
    {
        performSegue(withIdentifier: "addFlatPrice", sender: self)
    }
    
    //TableView Datasource Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("Flat Price List Count :", flatPrice.count)
        return flatPrice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = flatPriceTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! flatPriceTableViewCell
        let flatPriceValue = flatPrice[indexPath.row]
        cell.flatPriceName.text = flatPriceValue.couponName
        cell.flatPriceAmount.text = String(flatPriceValue.couponPrice)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        let alert = UIAlertController(title: "Attention", message: "Are you sure want to delete Coupon?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {(_: UIAlertAction!) in
        }))
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            
            if editingStyle == .delete
            {
                self.deleteFlatPrice(at: indexPath)
            }
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
