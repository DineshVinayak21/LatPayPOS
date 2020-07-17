//
//  CategoriesViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var addButtonlabel: UIButton!
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var backButtonLabel: UIButton!
    @IBOutlet weak var noItemImage: UIImageView!
    
    
    var categories: [Categories] = []
    var products: [Products] = []
    var listOfAvailableProductsAtInitial: [String] = []
    
    override func viewDidLoad()
    {
        showCategoryAtInitial()
        loadProductAtInitial()
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.tableFooterView = UIView()
        designFunctionCVC()
        super.viewDidLoad()
    }
    
    @IBAction func onTapBackButton(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addCategory(_ sender: Any)
    {
        addCategory()
    }
    
    //TableView Datasource Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("Categories Count: ", categories.count)
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = categoryTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! categoryTableViewCell
        let category = categories[indexPath.row]
        cell.categoryName.text = category.title
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        let alert = UIAlertController(title: "Attention", message: "Are you sure want to delete Category?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {(_: UIAlertAction!) in
        }))
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            
            if editingStyle == .delete
            {
                self.deleteCategory(at: indexPath)
            }
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
