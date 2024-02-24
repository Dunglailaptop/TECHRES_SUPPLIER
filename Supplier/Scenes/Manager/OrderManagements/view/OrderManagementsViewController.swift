//
//  OrderManagementsViewController.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import BmoViewPager

class OrderManagementsViewController: UIViewController {
    @IBOutlet weak var viewPager: BmoViewPager!
    @IBOutlet weak var viewPagerNavigationBar: BmoViewPagerNavigationBar!
    
    var title_names = ["CHỜ XỬ LÝ", "ĐANG GIAO", "HOÀN TẤT", "TỔNG HỢP S.L"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.viewPagerNavigationBar.viewPager = viewPager
        self.viewPagerNavigationBar.layer.masksToBounds = true
        self.viewPager.presentedPageIndex = 0
        self.viewPager.dataSource = self
        self.viewPager.delegate = self
        
        viewPager.reloadData()
    }
}

extension OrderManagementsViewController: BmoViewPagerDataSource, BmoViewPagerDelegate{
    
    func bmoViewPagerDataSourceNumberOfPage(in viewPager: BmoViewPager) -> Int {
        return self.title_names.count
    }
    
    func bmoViewPagerDataSource(_ viewPager: BmoViewPager, viewControllerForPageAt page: Int) -> UIViewController {
        if(page == 0){
            let pendingOrderManagementViewController = PendingOrderManagementRouter().viewController as! PendingOrderManagementViewController
            return pendingOrderManagementViewController
        }else if(page == 1){
            let deliveringOrderManagementViewController = DeliveringOrderManagementRouter().viewController as! DeliveringOrderManagementViewController
            return deliveringOrderManagementViewController
        }else if(page == 2){
            let completeOrderManagementViewController = CompleteOrderManagementRouter().viewController as! CompleteOrderManagementViewController
            return completeOrderManagementViewController
        }else {
            let totalAmountOrderManagementViewController = TotalAmountOrderManagementRouter().viewController as! TotalAmountOrderManagementViewController
            return totalAmountOrderManagementViewController
        }
    }
    
    func bmoViewPagerDataSourceNaviagtionBarItemNormalAttributed(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> [NSAttributedString.Key : Any]? {
        return [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12.0),
            NSAttributedString.Key.foregroundColor : ColorUtils.gray_600()
        ]
    }
    
    func bmoViewPagerDataSourceNaviagtionBarItemHighlightedAttributed(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> [NSAttributedString.Key : Any]? {
        return [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12.0),
            NSAttributedString.Key.foregroundColor : ColorUtils.blue_700()
        ]
    }
    
    func bmoViewPagerDataSourceNaviagtionBarItemTitle(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> String? {
        return self.title_names[page].uppercased()
    }

    
    func bmoViewPagerDataSourceNaviagtionBarItemSize(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> CGSize {
        switch page {
        case 0:
            return CGSize(width: 110, height: navigationBar.bounds.height)
        case 1:
            return CGSize(width: 120, height: navigationBar.bounds.height)
        case 2:
            return CGSize(width: 110, height: navigationBar.bounds.height)
        default:
            return CGSize(width: 120, height: navigationBar.bounds.height)
        }
    }
    
    func bmoViewPagerDataSourceNaviagtionBarItemHighlightedBackgroundView(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> UIView? {
        let view = UIView()

        view.addBottomBorder()
        return view
    }
}
