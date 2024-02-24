//
//  UnitSpecsManagementViewController + Extension + API.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 25/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import JonAlert
extension UnitSpecsManagementViewController{
    func getMaterialUnitSpecifications(){
        viewModel.getMaterialUnitSpecifications().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<UnitSpecification>().mapArray(JSONObject: response.data) {
                    viewModel.dataArray.accept(dataFromServer)
                    viewModel.dataFilter.accept(dataFromServer)
                    Utils.isHideAllView(isHide: viewModel.dataArray.value.count > 0 ? true : false, view: self.no_data_view)
                }
            }else{
                JonAlert.showError(message: response.message ?? "",duration:  2.0)
            }
            
        }).disposed(by: rxbag)
    }
    
    
    func changeMaterialUnitSpecsStatus(unitSpecificationId:Int){
        viewModel.unitSpecificationId.accept(unitSpecificationId)
        viewModel.changeMaterialUnitSpecsStatus().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                
                if let position1 = viewModel.dataFilter.value.firstIndex(where: {(element) in element.id == unitSpecificationId}){
                    var cloneDataArray = viewModel.dataFilter.value
                    cloneDataArray.remove(at: position1)
                    viewModel.dataFilter.accept(cloneDataArray)
                }

                if let position2 = viewModel.dataArray.value.firstIndex(where: {(element) in element.id == unitSpecificationId}){
                    var cloneDataArray = viewModel.dataArray.value
                    cloneDataArray.remove(at: position2)
                    viewModel.dataArray.accept(cloneDataArray)
                    tableView.reloadData()
                    Utils.isHideAllView(isHide: viewModel.dataArray.value.count > 0 ? true : false, view: self.no_data_view)
                }
                
                
                JonAlert.showSuccess(message: viewModel.status.value == DEACTIVE
                                     ? "Khôi phục trạng thái thành công"
                                     : "Tạm ngưng Quy cách thành công",
                duration:2.0)
                
               
            }else if(response.code == RRHTTPStatusCode.resetContent.rawValue){
                if let dataFromServer = Mapper<UnitSpecificationStatus>().mapArray(JSONObject: response.data) {
                    self.prensentDialogNotify(content: response.message ??  "",unitSpecsStatus: dataFromServer)
                }
            }else{
                JonAlert.showError(message: response.message ?? "",duration:  2.0)
            }
        }).disposed(by: rxbag)
    }

}


extension UnitSpecsManagementViewController:UITableViewDelegate,UITextFieldDelegate{
    
    
    func textFieldShouldClear(_: UITextField) -> Bool{
        viewModel.key_search.accept("")
        viewModel.dataArray.accept(viewModel.dataFilter.value)
        return true
    }
    
    
    func registerCell() {
        let unitSpecsManagementTableViewCell = UINib(nibName: "UnitSpecsManagementTableViewCell", bundle: .main)
        tableView.register(unitSpecsManagementTableViewCell, forCellReuseIdentifier: "UnitSpecsManagementTableViewCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = 45
        tableView.rx.setDelegate(self).disposed(by: rxbag)
    }
    
    func bindTableViewData() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "UnitSpecsManagementTableViewCell", cellType: UnitSpecsManagementTableViewCell.self))
            {(row, material, cell) in
                cell.data = material
                cell.holder_view.backgroundColor = self.viewModel.status.value == ACTIVE ? ColorUtils.blue_700() : ColorUtils.orange_700()
            }.disposed(by: rxbag)
    }
    

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var  configuration : UISwipeActionsConfiguration?
        
        switch viewModel.status.value{
            case ACTIVE:
              
            
                //Nút chỉnh sửa
                let editBtn = UIContextualAction(style: .destructive, title: ""){
                    [weak self] (action, view, completionHandler) in
                    self!.viewModel.makeCreateUnitSpecificationViewController(unitSpecification: self!.viewModel.dataArray.value[indexPath.item])
                    completionHandler(true)
                }
                editBtn.backgroundColor = ColorUtils.blue_000()
                editBtn.image = UIImage(named: "icon-edit-blue")
            
            
                //Nút ngừng sử dụng
                let stopUsingBtn = UIContextualAction(style: .destructive, title: ""){
                    [weak self] (action, view, completionHandler) in
                    self!.prensentDialogConfirm(content: String(format: "Tạm ngưng Quy cách %@", self!.viewModel.dataArray.value[indexPath.item].name))
                    self!.viewModel.closure.accept({})
                    self!.viewModel.closure.accept(
                        {self!.changeMaterialUnitSpecsStatus(unitSpecificationId: self!.viewModel.dataArray.value[indexPath.item].id)}
                    )
                    
                    completionHandler(true)
                }
                stopUsingBtn.backgroundColor = ColorUtils.gray_200()
                stopUsingBtn.image = UIImage(named: "icon-stop-using")
                configuration = UISwipeActionsConfiguration(actions: [stopUsingBtn,editBtn])
                configuration!.performsFirstActionWithFullSwipe = false
            
            case DEACTIVE:
                //Nút khôi phục
                let restoreBtn = UIContextualAction(style: .destructive, title: ""){
                    [weak self] (action, view, completionHandler) in
                    
                    self!.prensentDialogConfirm(content: String(format: "Bật hoạt động Quy cách %@", self!.viewModel.dataArray.value[indexPath.item].name))
                    self!.viewModel.closure.accept({})
                    self!.viewModel.closure.accept(
                        {self!.changeMaterialUnitSpecsStatus(unitSpecificationId: self!.viewModel.dataArray.value[indexPath.item].id)}
                    )
                    completionHandler(true)
                }
                restoreBtn.backgroundColor =  ColorUtils.orange_000()
                restoreBtn.image = UIImage(named: "icon-restore-orange")
                configuration = UISwipeActionsConfiguration(actions: [restoreBtn])
                configuration!.performsFirstActionWithFullSwipe = false
                break
            
            default:
                break
        }

        return configuration
    }
}
