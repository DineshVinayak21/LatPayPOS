//
//  AddItemsViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import UIKit
import CoreData

class AddItemsViewController: UIViewController
{
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var menuItemsLabel: UILabel!
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var categoriesButtonLabel: UIButton!
    @IBOutlet weak var productsButtonLabel: UIButton!
    @IBOutlet weak var discontButtonLabel: UIButton!
    @IBOutlet weak var flatPriceButtonLabel: UIButton!
    
    override func viewDidLoad()
    {
        designFunctionAIVC()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
        
    override func viewDidDisappear(_ animated: Bool)
    {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func categoriesButton(_ sender: Any)
    {
        performSegue(withIdentifier: "category", sender: self)
    }
    
    @IBAction func productsButton(_ sender: Any)
    {
        performSegue(withIdentifier: "product", sender: self)
    }
    
    @IBAction func discountButton(_ sender: Any)
    {
        performSegue(withIdentifier: "discount", sender: self)
    }
    
    @IBAction func flatPriceButton(_ sender: Any)
    {
        performSegue(withIdentifier: "flatprice", sender: self)
    }
    
}
