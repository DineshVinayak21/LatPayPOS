//
//  ViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, transferValue
{
    
    var products = [Products]()
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var itemsDisplay: UITableView!
    @IBOutlet weak var noItemImage: UIImageView!
    @IBOutlet weak var bottomLeftView: UIView!
    @IBOutlet weak var bottomRightView: UIView!
    @IBOutlet weak var gotoCartButtonLabel: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var search: UISearchBar!
    
    
    var tempName: [String] = []
    var tempPrice: [String] = []
    var tempQuantity: [String] = []
    var tempQuan = 0
    
    var searchedItems = [String]()
    var searching = false
    var productName = [String]()
    
    override func viewDidLoad()
    {
        itemsDisplay.delegate = self
        itemsDisplay.dataSource = self
        itemsDisplay.tableFooterView = UIView()
        designFunctionVC()
        loadingItemsAtBeginning()
        CommonActivityIndicator().defaultActivityIndicator(uiView: self.view)
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool)
    {
        loadingItemsAtMid()
        itemsDisplay.reloadData()
    }
    
    @IBAction func gotoCart(_ sender: Any)
    {
        performSegue(withIdentifier: "cart", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is AddToCartViewController
        {
            let nextVC = segue.destination as! AddToCartViewController
            nextVC.nameArr = tempName
            nextVC.priceArr = tempPrice
            nextVC.productQuantity = tempQuantity
        }
    }
    
    //TableView DataSource Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("Items count :", products.count)
        if searching
        {
            return searchedItems.count
        }
        else
        {
            return products.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = itemsDisplay.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! itemsTableViewCell
        if searching
        {
            cell.itemName.text = searchedItems[indexPath.row]
        }
        else
        {
            let product = products[indexPath.row]
            cell.itemName.text = product.name
            cell.itemPrice.text = String(product.price)
            cell.size.text = String(product.quantity)
            cell.selectionStyle = .none
            cell.del = self
        }
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 75.0
    }
    
    func transfer(name: String, price: String, size: String) {
        bottomRightView.isHidden = false
        tempQuan = tempQuan + 1
        countLabel.text = "\(tempQuan)"
        tempName.append(name)
        tempPrice.append(price)
        tempQuantity.append(size)
        print(tempName)
        print(tempPrice)
        print(tempQuantity)
    }
    
    func removeTransfer(name: String, price: String, size: String)
    {
        tempQuan = tempQuan - 1
        countLabel.text = "\(tempQuan)"
        if tempName.contains(name)
        {
            if let firstIndex = tempName.index(of: name)
            {
                tempName.remove(at: firstIndex)
            }
        }
        
        if tempPrice.contains(price)
        {
            print("this")
            if let firstIndex = tempPrice.index(of: price)
            {
                print("this")
                tempPrice.remove(at: firstIndex)
            }
        }
        
        if tempQuantity.contains(size)
        {
            print("this")
            if let firstIndex = tempQuantity.index(of: size)
            {
                print("this")
                tempQuantity.remove(at: firstIndex)
            }
        }
        
        if tempPrice == [] || tempName == [] || tempQuantity == []
        {
            bottomRightView.isHidden = true
        }
        
        print("After Vanished :", tempName)
        print("After Vanished :", tempPrice)
        print("After Vanished :", tempQuantity)
    }
    
}

