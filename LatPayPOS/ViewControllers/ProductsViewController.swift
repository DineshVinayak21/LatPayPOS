//
//  ProductsViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import UIKit
import CoreData

class ProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var addButtonlabel: UIButton!
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var backButtonLabel: UIButton!
    @IBOutlet weak var noItemImage: UIImageView!
    
    var category: [Categories] = []
    var product: [Products] = []
    
    var updateNewProdName = String()
    var updateNewProdDesc = String()
    var updateNewProdQuan = String()
    var udpateNewProdPrice = String()
    var updateNewProdCategory = String()
    
    override func viewDidLoad()
    {
        loadCategoryValuesAtInitial()
        loadProductValuesAtInitial()
        designFunctionPVC()
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.tableFooterView = UIView()
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(productLoad), name: NSNotification.Name(rawValue: "loadProduct"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(productUpdate), name: NSNotification.Name(rawValue: "loadUpdatedProduct"), object: nil)
    }
    
    @objc func productLoad()
    {
        print("Product Notification Center Called")
        self.reloadProductListAgain()
    }
    
    @objc func productUpdate()
    {
        print("Product Notification Center Called")
        self.reloadProductListAgain()
    }
    
    @IBAction func onTapBackButton(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addProduct(_ sender: Any)
    {
        if self.category == []
        {
            print("temp")
            self.addCategoryFirstAlert()
        }
        else
        {
            performSegue(withIdentifier: "addProduct", sender: self)
        }
    }
    
    //TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("Products Counts Are :", product.count)
        return product.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = productTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! productTableViewCell
        let product1 = product[indexPath.row]
        cell.productName.text = product1.name
        cell.productDescription.text = product1.desc
        cell.productCategory.text = product1.mainCategory
        cell.productPrice.text = String(product1.price)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        let alert = UIAlertController(title: "Attention", message: "Are you sure want to delete Product?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {(_: UIAlertAction!) in
        }))
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            
            if editingStyle == .delete
            {
                self.deleteProduct(at: indexPath)
            }
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = productTableView as? productTableViewCell
        let prod = product[indexPath.row]
        updateNewProdName = prod.name!
        updateNewProdDesc = prod.desc!
        updateNewProdQuan = String(prod.quantity)
        udpateNewProdPrice = String(prod.price)
        updateNewProdCategory = prod.mainCategory!
        self.performSegue(withIdentifier: "updateproduct", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is UpdateProductViewController
        {
            let updateVC = segue.destination as! UpdateProductViewController
            updateVC.tempName = updateNewProdName
            updateVC.tempDescription = updateNewProdDesc
            updateVC.tempQuantity = updateNewProdQuan
            updateVC.tempPrice = udpateNewProdPrice
            updateVC.tempCategory = updateNewProdCategory
        }
    }
}
