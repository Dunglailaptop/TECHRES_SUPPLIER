//
//  SettingAccountBusinessViewController+Extensions.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 22/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ZLPhotoBrowser
import RxSwift
import RxCocoa
import TagListView


extension SettingAccountBusinessViewController: TagListViewDelegate {
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
dLog(title)
        tag_List.removeTag(title)
        var cloneOrderList = viewModel.dataArrayTypeBusiness.value
        if let position = cloneOrderList.firstIndex(where: {$0.name == title}){
            cloneOrderList[position].isSelected = DEACTIVE

        }
        viewModel.dataArrayTypeBusiness.accept(cloneOrderList)
        viewModel.dataSearch.accept(cloneOrderList)

    }
}

extension SettingAccountBusinessViewController: UITableViewDelegate {
    func register() {
        let viewTableCell = UINib(nibName: "ItemTypeBusinessTableViewCell", bundle: .main)
        tableView.register(viewTableCell, forCellReuseIdentifier: "ItemTypeBusinessTableViewCell")
        tableView.separatorStyle = .none
  
        
//        tableView.rx.modelSelected(TypeBusiness.self).subscribe(onNext: { [self] element in
//            if element
//
//
//        }).disposed(by: rxbag)
        tableView.rx.modelSelected(TypeBusiness.self) .subscribe(onNext: { [self] element in
            dLog("Selected \(element)")
            var dataget = viewModel.dataArrayTypeBusiness.value
            var dataSreach = viewModel.dataSearch.value
            height_tag_list.constant = 10 + tag_List.intrinsicContentSize.height
            heightview.constant =  height_tag_list.constant + 100
            dataget.enumerated().forEach { (index, value) in
                if value.id == element.id {
                    // Toggle the isSelected state
                    dataget[index].isSelected = (dataget[index].isSelected == ACTIVE) ? DEACTIVE : ACTIVE

                    // Check the updated isSelected state
                    if dataget[index].isSelected == ACTIVE {
                        // Add the tag if it's selected
                        self.tag_List.addTag( value.name,id:value.id)
                        self.tag_List.reloadInputViews()
                        
//                            self.tag_List.reloadInputViews()
                    } else {
                        // Remove the tag if it's deselected
                        self.tag_List.removeTag(value.name)
//                            self.tag_List.reloadInputViews()
                    }
                }
            }
            dataSreach.enumerated().forEach{ (index,value) in
                if value.id == element.id {
                    dataSreach[index].isSelected = (dataSreach[index].isSelected == ACTIVE) ? DEACTIVE : ACTIVE

                }
            }
            
            viewModel.dataArrayTypeBusiness.accept(dataget)
            viewModel.dataSearch.accept(dataSreach)
          
           
        }).disposed(by: rxbag)
        tableView.rx.setDelegate(self).disposed(by: rxbag)
    }
    
    func bindingtableview() {
        viewModel.dataArrayTypeBusiness.bind(to: tableView.rx.items(cellIdentifier: "ItemTypeBusinessTableViewCell", cellType: ItemTypeBusinessTableViewCell.self)) {
            (row,data,cell) in

            cell.data = data

        }.disposed(by: rxbag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}

extension SettingAccountBusinessViewController{
    
    func presentAddressDialogOfAccountInforViewController(areaType:String){
        let addressDialogOfAccountInforViewController = AddressDialogOfAccountInforViewController()
        addressDialogOfAccountInforViewController.delegate = self
        addressDialogOfAccountInforViewController.view.backgroundColor = ColorUtils.blackTransparent()
    
        var selectedArea:[String:Area] = [
            "CITY" : Area(id:viewModel.supplierInfor.value.city_id, name:viewModel.supplierInfor.value.city_name, is_select:ACTIVE),
            "DISTRICT" :Area(id:viewModel.supplierInfor.value.district_id, name:viewModel.supplierInfor.value.district_name, is_select:ACTIVE),
            "WARD" : Area(id:viewModel.supplierInfor.value.ward_id, name:viewModel.supplierInfor.value.ward_name, is_select:ACTIVE)
        ]
        
        switch areaType{
            case "CITY":
                addressDialogOfAccountInforViewController.selectedArea = selectedArea
                addressDialogOfAccountInforViewController.areaType = areaType
                break
            case "DISTRICT":
             
                addressDialogOfAccountInforViewController.selectedArea = selectedArea
                addressDialogOfAccountInforViewController.areaType = areaType
                break
            case "WARD":
                addressDialogOfAccountInforViewController.selectedArea = selectedArea
                addressDialogOfAccountInforViewController.areaType = areaType
                break
        default:
            return
        }

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
extension SettingAccountBusinessViewController:AccountInforDelegate{
    func callBackToAcceptSelectedArea(selectedArea:[String:Area]) {
        lbl_city.text = selectedArea["CITY"]!.name
        lbl_district.text = selectedArea["DISTRICT"]!.name
        lbl_ward.text = selectedArea["WARD"]!.name
        
        var cloneEmployeeInfo = viewModel.supplierInfor.value
        cloneEmployeeInfo.city_id = selectedArea["CITY"]!.id
        cloneEmployeeInfo.city_name = selectedArea["CITY"]!.name
        cloneEmployeeInfo.district_id = selectedArea["DISTRICT"]!.id
        cloneEmployeeInfo.district_name = selectedArea["DISTRICT"]!.name
        cloneEmployeeInfo.ward_id = selectedArea["WARD"]!.id
        cloneEmployeeInfo.ward_name = selectedArea["WARD"]!.name

        viewModel.supplierInfor.accept(cloneEmployeeInfo)

    }
}
extension SettingAccountBusinessViewController{
    
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
        if ischeck {
            self.imagecover.removeAll()
            self.selectedAssets.removeAll()
            ps.selectImageBlock = { [weak self] results, isOriginal in
                // your code
                self?.avatar.image = results[0].image
                self?.imagecover.append(results[0].image)
                self?.selectedAssets.append(results[0].asset)
                self!.generateFileUpload()
            }
            ps.showPhotoLibrary(sender: self)
        }else {
            self.imagecover2.removeAll()
            self.selectedAssets2.removeAll()
            ps.selectImageBlock = { [weak self] results, isOriginal in
                // your code
                self?.poster.image = results[0].image
                self?.imagecover2.append(results[0].image)
                self?.selectedAssets2.append(results[0].asset)
                self!.generateFileUpload()
            }
            ps.showPhotoLibrary(sender: self)
        }
        
       
       
    }

    
    func generateFileUpload(){
        var medias_requests = [Media]()
        var media_request = Media()
        var media_request2 = Media()
        if imagecover.count > 0 {
          

            let widthImageAvatar = Int(self.imagecover[0].size.width)
            let heightImageAvatar = Int(self.imagecover[0].size.height)
           
            
            media_request.type = TYPE_IMAGE // Set the type property to TYPE_IMAGE
            media_request.name = Utils.getImageFullName(asset: self.selectedAssets[0])
            media_request.size = 1
            media_request.is_keep = 1 // lưu lại mãi mãi. Nếu 0 sẽ bị xoá sau 1 thời gian ( trường hợp trong group chat)
            media_request.width = widthImageAvatar
            media_request.height = heightImageAvatar
            
            medias_requests.append(media_request)
           
            dLog(media_request)
            dLog(medias_requests)
        }
        if imagecover2.count > 0 {
            let widthImageAvatar2 = Int(self.imagecover2[0].size.width)
            let heightImageAvatar2 = Int(self.imagecover2[0].size.height)
          
            
            media_request2.type = TYPE_IMAGE // Set the type property to TYPE_IMAGE
            media_request2.name = Utils.getImageFullName(asset: self.selectedAssets2[0])
            media_request2.size = 1
            media_request2.is_keep = 1 // lưu lại mãi mãi. Nếu 0 sẽ bị xoá sau 1 thời gian ( trường hợp trong group chat)
            media_request2.width = widthImageAvatar2
            media_request2.height = heightImageAvatar2
            medias_requests.append(media_request2)
            dLog(media_request)
            dLog(medias_requests)
        }
       
       
        self.viewModel.medias.accept(medias_requests)
    }
    
 
    
}

extension SettingAccountBusinessViewController: UpdateSettingBusiness {
    
    func callUpdateBusiness() {
                viewModel.isAccountBusinessInforValid.take(1).subscribe({[weak self] isValid in
                    guard let strongSelf = self, let isValid = isValid.element else { return }
                    if isValid {
                        self!.imagecover.count > 0 || (self?.imagecover2.count)! > 0 ? self!.updateProfileWithAvatar() : self!.updateProfileBusiness()
                        
                    }
                }).disposed(by: rxbag)
        dismiss(animated: true)
    }
    
    func presentDialogAccessUpdatepProfileBusiness() {
        
        let DialogAccessUpdateProfileBusiness = DialogAccessUpdateProfileBusinessViewController()
        DialogAccessUpdateProfileBusiness.Delegate = self
        DialogAccessUpdateProfileBusiness.view.backgroundColor = ColorUtils.blackTransparent()
    
        
        
        let nav = UINavigationController(rootViewController: DialogAccessUpdateProfileBusiness)
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
