//
//  DialogChooseRestaurantViewController + Extension + API.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 07/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import ObjectMapper
import JonAlert
import RxRelay
//MARK: call API
extension DialogChooseRestaurantViewController:UIScrollViewDelegate {
    func getRestaurantList() {
        viewModel.getRestaurantList().subscribe(onNext: { [self] (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let dataFromServer = Mapper<RestaurantModel>().map(JSONObject: response.data){
                    viewModel.listOfRestaurants.accept(dataFromServer.list)
                }
            }
        }).disposed(by: rxbag)
    }
    
    func getBrandList() {
        viewModel.getBrandList().subscribe(onNext: { [self] (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let dataFromServer = Mapper<BrandResponse>().map(JSONObject: response.data){
                    viewModel.listOfBrands.accept(dataFromServer.list)
                }

            }
        }).disposed(by: rxbag)
    }
    
    
    func getBranchList(){
        viewModel.getBranchList().subscribe(onNext: { [self] (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let dataFromServer = Mapper<BranchesResponse>().map(JSONObject: response.data){
                    viewModel.listOfBranches.accept(dataFromServer.list)
                }
            }
        }).disposed(by: rxbag)
    }
    
    
}


//MARK: REGISTER SELECT CHOOSE TYPE
extension DialogChooseRestaurantViewController: ArrayChooseCategoryViewControllerDelegate {
    
    func showPopUp(btnShowPopup: UIButton!){
        var listName = [String]()
        var listIcon = [String]()
        
        switch viewModel.dropDownType.value{
            case 1:
                for restaurant in viewModel.listOfRestaurants.value {
                    listName.append(restaurant.name)
                    listIcon.append("")
                }
                break
            
            case 2:
                for brand in viewModel.listOfBrands.value {
                    listName.append(brand.name)
                    listIcon.append("")
                }
                break

            case 3:
                for branch in viewModel.listOfBranches.value {
                    listName.append(branch.name)
                    listIcon.append("")
                }
                break
            
            default:
                return
        }
        let controller = ArrayChooseCategoryViewController(Direction.allValues)
        controller.delegate = self
        controller.list_icons = listIcon
        controller.listString = listName
        controller.preferredContentSize = CGSize(width: btnShowPopup.frame.width, height: 300)
        showPopup(controller, sourceView: btnShowPopup)
    }
    

    
    private func showPopup(_ controller: UIViewController, sourceView: UIView) {
        let presentationController = AlwaysPresentAsPopover.configurePresentation(forController: controller)
        //turn off arrow sign
      
        presentationController.sourceView = sourceView
        presentationController.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)
        let position = CGRectMake(sourceView.bounds.origin.x, sourceView.bounds.origin.y + 180, sourceView.bounds.size.width, sourceView.bounds.size.height)
        presentationController.sourceRect = position
        self.present(controller, animated: true)
    }
    
    func selectCategoryAt(pos: Int) {
        
        switch viewModel.dropDownType.value{
            case 1:
                lbl_restaurant.text = viewModel.listOfRestaurants.value[pos].name
                viewModel.selectedRestaurant.accept(viewModel.listOfRestaurants.value[pos])
                getBrandList()
                break
            
            case 2:
                lbl_brand.text = viewModel.listOfBrands.value[pos].name
                viewModel.selectedBrand.accept(viewModel.listOfBrands.value[pos])
                getBranchList()
                break
            
            case 3:
                lbl_branch.text = viewModel.listOfBranches.value[pos].name
                viewModel.selectedBranch.accept(viewModel.listOfBranches.value[pos])
                break
            
            default:
                return
        }
        
    }
    
}
