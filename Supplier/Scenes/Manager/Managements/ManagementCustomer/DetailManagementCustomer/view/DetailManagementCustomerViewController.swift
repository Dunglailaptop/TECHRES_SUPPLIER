//
//  DetailManagementCustomerViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 25/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import MarqueeLabel


class DetailManagementCustomerViewController: BaseViewController {

    var restaurant = Restaurant()
    var viewModel = DetailManagementCustomerViewModel()
    var router = DetailManagementCustomerRouter()
    
    @IBOutlet weak var view_info_detail: UIView!
    @IBOutlet weak var view_list_brand: UIView!

    @IBOutlet weak var image_logo: UIImageView!
    @IBOutlet weak var lbl_name_restaurant: UILabel!
    @IBOutlet weak var lbl_phone_restaurant: UILabel!
    @IBOutlet weak var lbl_email_restaurant: UILabel!
    @IBOutlet weak var lbl_address_restaurant: MarqueeLabel!
    
    @IBOutlet weak var lbl_info_detail: UILabel!
    @IBOutlet weak var lbl_list_brand: UILabel!
    var view1 = ManagementCustomerBrandViewController()
    var view2 = ManagementInfoCustomerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        setupdata()
        registerViewController()
        viewController_number_one()
       
    }
    
    @IBAction func btn_DetailListCustomerViewController(_ sender: Any) {
        viewController_number_one()
    }
    
    @IBAction func btn_BranchesViewController(_ sender: Any) {
        viewController_number_two()
    }
    
    func registerViewController() {
        view1 = ManagementCustomerBrandViewController(nibName: "ManagementCustomerBrandViewController", bundle: Bundle.main)
        view2 = ManagementInfoCustomerViewController(nibName: "ManagementInfoCustomerViewController", bundle: Bundle.main)
    }
    
    func viewController_number_two() {
        view_list_brand.backgroundColor = UIColor(hex: "E3ECF5")
        lbl_list_brand.textColor = UIColor(hex: "1462B0")

        view_info_detail.backgroundColor = .clear
        lbl_info_detail.textColor = UIColor(hex: "7D7E81")
        view1.restaurantId = restaurant.id
        addTopCustomViewController(view1, addTopCustom: 200)
        view2.remove()

    }
    func viewController_number_one(){
        view_info_detail.backgroundColor = UIColor(hex: "E3ECF5")
        lbl_info_detail.textColor = UIColor(hex: "1462B0")

        view_list_brand.backgroundColor = .clear
        lbl_list_brand.textColor = UIColor(hex: "7D7E81")
        view2.restaurantId = restaurant.id
        addTopCustomViewController(view2, addTopCustom: 200)
        view1.remove()

    }
    
    func setupdata() {
        if restaurant != nil {
            lbl_name_restaurant.text = restaurant.name.uppercased() + "          "
            lbl_phone_restaurant.text = restaurant.phone
            lbl_address_restaurant.text = restaurant.address
            lbl_email_restaurant.text = restaurant.email
            image_logo.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: restaurant.logo)), placeholder: UIImage(named: "icon-logo-gray"))
            Utils.getMarqueeLabel(lblContent: lbl_address_restaurant)
        }
    }
   
    @IBAction func btn_makeToManagementListCustomerViewController(_ sender: Any) {
        viewModel.makeToManagementListCustomerViewController()
    }
}
