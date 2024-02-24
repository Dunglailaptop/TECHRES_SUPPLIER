//
//  CategoryReportViewController.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import BmoViewPager

class CategoryReportViewController: BaseViewController {
    
    var viewModel = CategoryReportViewModel()
    var router = CategoryReportRouter()
    
    
    
    @IBOutlet weak var viewPager: BmoViewPager!
    @IBOutlet weak var viewPagerNavigationBar: BmoViewPagerNavigationBar!
    
    var title_names = ["NHẬP KHO"," XUẤT KHO", "TRẢ HÀNG", "HUỶ HÀNG", "TỒN KHO"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.viewModel.bind(self, router: router)
        self.viewPagerNavigationBar.viewPager = viewPager
        self.viewPagerNavigationBar.layer.masksToBounds = true
        self.viewPager.presentedPageIndex = 0
        self.viewPager.dataSource = self
        self.viewPager.delegate = self
        
        viewPager.reloadData()
    }
    
    
    @IBAction func actionToNavigateBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
}

extension CategoryReportViewController: BmoViewPagerDataSource, BmoViewPagerDelegate{
    
    func bmoViewPagerDataSourceNumberOfPage(in viewPager: BmoViewPager) -> Int {
        return self.title_names.count
    }
    
    func bmoViewPagerDataSource(_ viewPager: BmoViewPager, viewControllerForPageAt page: Int) -> UIViewController {
        if(page == 0){
            let importCategoryReportViewController = ImportCategoryReportRouter().viewController as! ImportCategoryReportViewController
            return importCategoryReportViewController
        }else if(page == 1){
            let exportCategoryReportViewController = ExportCategoryReportRouter().viewController as! ExportCategoryReportViewController
            return exportCategoryReportViewController
        }else if(page == 2){
            let returnCategoryReportViewController = ReturnCategoryReportRouter().viewController as! ReturnCategoryReportViewController
            return returnCategoryReportViewController
        }else if(page == 3){
            let cancelCategoryReportViewController = CancelCategoryReportRouter().viewController as! CancelCategoryReportViewController
            return cancelCategoryReportViewController
        }else {
            let remainingCategoryReportViewController = RemainingCategoryReportRouter().viewController as! RemainingCategoryReportViewController
            return remainingCategoryReportViewController
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
            return CGSize(width: 100, height: navigationBar.bounds.height)
        case 1:
            return CGSize(width: 100, height: navigationBar.bounds.height)
        case 2:
            return CGSize(width: 100, height: navigationBar.bounds.height)
        case 3:
            return CGSize(width: 100, height: navigationBar.bounds.height)
        default:
            return CGSize(width: 100, height: navigationBar.bounds.height)
        }
    }
    
    func bmoViewPagerDataSourceNaviagtionBarItemHighlightedBackgroundView(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> UIView? {
        let view = UIView()

        view.addBottomBorder()
        return view
    }
}
