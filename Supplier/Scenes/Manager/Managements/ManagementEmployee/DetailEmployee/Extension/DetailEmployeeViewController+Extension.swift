//
//  DetailEmployeeViewController+Extension.swift
//  Techres-Seemt
//
//  Created by Nguyen Thanh Vinh on 19/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import ObjectMapper
import Kingfisher
import JonAlert
import ZLPhotoBrowser


extension DetailEmployeeViewController{
    func presentAddressDialogOfAccountInforViewController(areaType:String){
        let addressDialogOfAccountInforViewController = AddressDialogOfAccountInforViewController()
        addressDialogOfAccountInforViewController.delegate = self
        addressDialogOfAccountInforViewController.view.backgroundColor = ColorUtils.blackTransparent()
    
        var selectedArea:[String:Area] = [
            "CITY" : Area(id:viewModel.employeeInfor.value.city_id, name:viewModel.employeeInfor.value.city_name, is_select:ACTIVE),
            "DISTRICT" :Area(id:viewModel.employeeInfor.value.district_id, name:viewModel.employeeInfor.value.district_name, is_select:ACTIVE),
            "WARD" : Area(id:viewModel.employeeInfor.value.ward_id, name:viewModel.employeeInfor.value.ward_name, is_select:ACTIVE)
        ]
        addressDialogOfAccountInforViewController.selectedArea = selectedArea
        addressDialogOfAccountInforViewController.areaType = areaType
        
        let nav = UINavigationController(rootViewController: addressDialogOfAccountInforViewController)
            // 1
            nav.modalPresentationStyle = .overCurrentContext
            // 2
            if #available(iOS 15.0, *) {
                if let sheet = nav.sheetPresentationController {
                    // 3
                    sheet.detents = [.large()]
                }
            } else {
                // Fallback on earlier versions
            }
            // 4
           
            present(nav, animated: true, completion: nil)

        }
}

extension DetailEmployeeViewController:AccountInforDelegate{
    func callBackToAcceptSelectedArea(selectedArea:[String:Area]) {
        lbl_city.text = selectedArea["CITY"]!.name
        lbl_district.text = selectedArea["DISTRICT"]!.name
        lbl_ward.text = selectedArea["WARD"]!.name
        
        var employeeInfo = viewModel.employeeInfor.value
        employeeInfo.city_id = selectedArea["CITY"]!.id
        employeeInfo.city_name = selectedArea["CITY"]!.name
        employeeInfo.district_id = selectedArea["DISTRICT"]!.id
        employeeInfo.district_name = selectedArea["DISTRICT"]!.name
        employeeInfo.ward_id = selectedArea["WARD"]!.id
        employeeInfo.ward_name = selectedArea["WARD"]!.name
       checkDailog = true
        viewModel.employeeInfor.accept(employeeInfo)
    }
}


extension DetailEmployeeViewController{
    
    func chooseAvatar() {
       let config = ZLPhotoConfiguration.default()
       config.maxSelectCount = 1
       config.maxVideoSelectCount = 1
       config.useCustomCamera = false
       config.sortAscending = false
       config.sortAscending = false
       config.allowSelectVideo = false
       config.allowEditImage = true
       config.allowEditVideo = false
       config.allowSlideSelect = false
       config.maxSelectVideoDuration = 60 * 100//100 phut
        let ps = ZLPhotoPreviewSheet()
        ps.selectImageBlock = { [weak self] results, isOriginal in
            // your code
            self?.avatar.image = results[0].image
            self?.imagecover.append(results[0].image)
            self?.selectedAssets.append(results[0].asset)
            self!.generateFileUpload()
            self?.checkDailog = true
        }
        ps.showPhotoLibrary(sender: self)
       
    }

    
    func generateFileUpload(){
        if imagecover.count > 0{
            var medias_requests = [Media]()

                let widthImageAvatar = Int(self.imagecover[0].size.width)
                let heightImageAvatar = Int(self.imagecover[0].size.height)
                var media_request = Media()
//                file_name = String(format: "file_name_%@_%@.%@", result, random, "png")
                media_request.type = 0
                media_request.name = Utils.getImageFullName(asset: self.selectedAssets[0])
                media_request.size = 1
                media_request.is_keep = 1 // lưu lại mãi mãi. Nếu 0 sẽ bị xoá sau 1 thời gian ( trường hợp trong group chat)
                media_request.width = widthImageAvatar
                media_request.height = heightImageAvatar
                media_request.type = TYPE_IMAGE// hình ảnh
                medias_requests.append(media_request)
                dLog(media_request)
                dLog(medias_requests)
                self.viewModel.medias.accept(medias_requests)
        }
    }
    
 
    
}

extension DetailEmployeeViewController: DialogConfrimCreateEmployee {
    func callBackDialogConfrimCreateEmployeePopup(check:Int) {
        if check == 1 {
            dismiss(animated: true)
            presentModalDialogAccessPopUp(type: 1)
        }else {
            viewModel.makePopViewController()
        }
      
    }
    
    func presentModalDialogAccessPopUp(type:Int) {
        
        let DialogConfrimAccessViewController = DialogConfrimAccessViewController()
        
        DialogConfrimAccessViewController.view.backgroundColor = ColorUtils.blackTransparent()
        DialogConfrimAccessViewController.Delegate = self
        if type == 1 {
            DialogConfrimAccessViewController.lbl_not.text = "Toàn bộ Thông tin bạn vừa thay đổi sẽ bị mất. Bạn có muốn thoát không?"
        } else if type == 0 {
            DialogConfrimAccessViewController.lbl_not.text = "Toàn bộ Thông tin bạn vừa nhập sẽ bị mất. Bạn có muốn thoát không?"
        }
        let nav = UINavigationController(rootViewController: DialogConfrimAccessViewController)
        // 1
        nav.modalPresentationStyle = .overCurrentContext

        // 2
        if #available(iOS 15.0, *) {
            if let sheet = nav.sheetPresentationController {
                
                // 3
                sheet.detents = [.large()]
            }
        } else {
            // Fallback on earlier versions
        }
        // 4

        present(nav, animated: true, completion: nil)

        }
}
extension DetailEmployeeViewController: DialogConfrimUpdateEmployee {
    func presentModalDialogAccessUpdateEmployee(username:String) {
        
        let DialogConfrimShowInfoViewController = DialogConfrimShowInfoViewController()
        
        DialogConfrimShowInfoViewController.view.backgroundColor = ColorUtils.blackTransparent()
        DialogConfrimShowInfoViewController.delegate = self
        DialogConfrimShowInfoViewController.username = username
//        DialogConfrimShowInfoViewController.Delegate = self
        
        let nav = UINavigationController(rootViewController: DialogConfrimShowInfoViewController)
        // 1
        nav.modalPresentationStyle = .overCurrentContext

        // 2
        if #available(iOS 15.0, *) {
            if let sheet = nav.sheetPresentationController {
                
                // 3
                sheet.detents = [.large()]
            }
        } else {
            // Fallback on earlier versions
        }
        // 4

        present(nav, animated: true, completion: nil)

        }
    func callBackDialogUpdateEmployee() {
       imagecover.count > 0 ? updateWithAvatar() : postUpdate()
        dismiss(animated: true)
        presentModalDialogAccessEmployee()
    }
}
extension DetailEmployeeViewController {
    func presentModalDialogAccessEmployee() {
        
        let DialogConfrimAccessUpdateEmployeeViewController = DialogConfrimAccessUpdateEmployeeViewController()
        
        DialogConfrimAccessUpdateEmployeeViewController.view.backgroundColor = ColorUtils.blackTransparent()
        DialogConfrimAccessUpdateEmployeeViewController.viewModel = viewModel
//        DialogConfrimShowInfoViewController.Delegate = self
        
        let nav = UINavigationController(rootViewController: DialogConfrimAccessUpdateEmployeeViewController)
        // 1
        nav.modalPresentationStyle = .overCurrentContext

        // 2
        if #available(iOS 15.0, *) {
            if let sheet = nav.sheetPresentationController {
                
                // 3
                sheet.detents = [.large()]
            }
        } else {
            // Fallback on earlier versions
        }
        // 4

        present(nav, animated: true, completion: nil)

        }
}
