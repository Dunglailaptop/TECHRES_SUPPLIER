//
//  DetailedReportViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DetailedReportViewController: UIViewController {
    
    @IBOutlet weak var order_view: UIView!
    @IBOutlet weak var cancel_item_view: UIView!
    @IBOutlet weak var inventory_view: UIView!
    @IBOutlet weak var debt_view: UIView!
    
    @IBOutlet weak var restaurant_item_view: UIView!
    @IBOutlet weak var items_view: UIView!
    @IBOutlet weak var category_view: UIView!
    
    
    var viewModel = DetailedReportViewModel()
    var router = DetailedReportRouter()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(self, router: router)
        firstSetup()
        // Do any additional setup after loading the view.
    }
    
    private func firstSetup(){
        var viewArray:[UIView]=[order_view,cancel_item_view,inventory_view,debt_view,restaurant_item_view,items_view,category_view]
        for view in viewArray{
            view.addShadow(
                shadowOffset: CGSize(width: 1, height: 1), shadowOpacity: 0.1, shadowRadius: 4, color: UIColor(.black)
            )
        }
    }
    
    
    
    @IBAction func actionToNavigateToOrderReportViewController(_ sender: Any) {
        viewModel.makeOrderReportViewController()
    }
    
    
    @IBAction func actionToNavigateToCancelItemReportViewController(_ sender: Any) {
        viewModel.makeCancelItemReportViewController()
    }
    
    
    @IBAction func actionToNavigateToInventoryReportViewController(_ sender: Any) {
        viewModel.makeInventoryReportViewController()
    }
    
    
    
    @IBAction func actionToNavigateToDebtReportViewController(_ sender: Any) {
        viewModel.makeDebtReportViewController()
    }
    
    
    
    @IBAction func actionToNavigateToRestaurantOrderReportViewController(_ sender: Any) {
        viewModel.makeRestaurantOrderReportViewController()
    }
    
    
    @IBAction func actionToNavigateToItemReportViewController(_ sender: Any) {
        viewModel.makeItemReportViewController()
    }
    
    
    @IBAction func actionToNavigateToCategoryReportViewController(_ sender: Any) {
        viewModel.makeCategoryReportViewController()
    }
}
