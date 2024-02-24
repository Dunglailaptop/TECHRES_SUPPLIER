//
//  DialogChooseRestaurantViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 07/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DialogChooseRestaurantViewController: BaseViewController {

    var viewModel = DialogChooseRestaurantViewModel()
    var router = DialogChooseRestaurantRouter()
    var delegate:DialogChooseRestaurantDelegate?

    
    @IBOutlet var root_view: UIView!
   
    @IBOutlet weak var lbl_restaurant: UILabel!
    @IBOutlet weak var btn_choose_restaurant: UIButton!
    
    @IBOutlet weak var lbl_brand: UILabel!
    @IBOutlet weak var btn_choose_brand: UIButton!
    
    @IBOutlet weak var lbl_branch: UILabel!
    @IBOutlet weak var btn_choose_branch: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        root_view.round(with: .both,radius: 10)
        setUpForTapOutSide()
        getRestaurantList()
    }
    
    
    @IBAction func actionChooseRestaurant(_ sender: Any) {
        viewModel.dropDownType.accept(1)
        showPopUp(btnShowPopup: btn_choose_restaurant)
    }
    
    
    @IBAction func actionChooseBrand(_ sender: Any) {
        viewModel.dropDownType.accept(2)
        showPopUp(btnShowPopup: btn_choose_brand)
    }
    
    @IBAction func actionChooseBranch(_ sender: Any) {
        viewModel.dropDownType.accept(3)
        showPopUp(btnShowPopup: btn_choose_branch)
    }
    
    
    
    @IBAction func actionReset(_ sender: Any) {
        lbl_restaurant.text = "Vui lòng chọn nhà hàng"
        lbl_brand.text = "Vui lòng chọn thương hiệu"
        lbl_branch.text = "Vui lòng chọn chi nhánh"
        viewModel.selectedRestaurant.accept(Restaurant())
        viewModel.selectedBrand.accept(Brand())
        viewModel.selectedBranch.accept(Branches())
    }
    
    
    @IBAction func actionConfirm(_ sender: Any) {
        if (viewModel.selectedRestaurant.value.id > 0 &&
            viewModel.selectedBrand.value.id > 0 &&
            viewModel.selectedBranch.value.id > 0)
        {
            delegate?.callBackToGetResult(
                restaurant: viewModel.selectedRestaurant.value,
                brand: viewModel.selectedBrand.value,
                branch: viewModel.selectedBranch.value)
        }
       
        dismiss(animated: true)
    }
    
    
    private func setUpForTapOutSide() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutSide(_:)))
        tapGesture.cancelsTouchesInView = false
        UIApplication.shared.windows.first?.addGestureRecognizer(tapGesture) // Attach to the window
    }
    
    
    @objc func handleTapOutSide(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: self.root_view)
        if !root_view.bounds.contains(tapLocation) {
            dismiss(animated: true, completion: nil)
        }
    }
    


}
