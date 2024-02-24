//
//  DetailedReceiptAndPaymentViewController + Extension.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 20/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift
extension DetailedReceiptAndPaymentViewController:UITableViewDelegate,UITableViewDataSource{
    func registerCell() {
        let detailedReceiptAndPaymentTableViewCell = UINib(nibName: "DetailedReceiptAndPaymentTableViewCell", bundle: .main)
        tableView.register(detailedReceiptAndPaymentTableViewCell, forCellReuseIdentifier: "DetailedReceiptAndPaymentTableViewCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.rowHeight = 60
        tableView.dataSource = self
        tableView.delegate = self
    }

    func bindTableViewData() {
//        viewModel.o.bind(to: tableView.rx.items(cellIdentifier: "DetailedReceiptAndPaymentTableViewCell", cellType: DetailedReceiptAndPaymentTableViewCell.self))
//            {(row, orderDetail, cell) in
//                cell.data = orderDetail
//            }.disposed(by: rxbag)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (viewModel.receiptPaymentDetail.value.type == 0){
            return viewModel.receiptPaymentDetail.value.supplier_orders.count
        }else {
            return viewModel.receiptPaymentDetail.value.supplier_warehouse_session_data.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailedReceiptAndPaymentTableViewCell") as! DetailedReceiptAndPaymentTableViewCell
        
       
        if (viewModel.receiptPaymentDetail.value.type == 0){//Phiếu thu
            let orderData = viewModel.receiptPaymentDetail.value.supplier_orders[indexPath.row]
            cell.lbl_code.text = orderData.code
            cell.lbl_date.attributedText = Utils.setMultipleFontAndColorForLabel(
                label: cell.lbl_date,
                attributes: [
                    (str:orderData.received_at.components(separatedBy: " ")[0],font:UIFont.systemFont(ofSize:10, weight:.regular),color:ColorUtils.black()),
                    (str:orderData.received_at.components(separatedBy: " ")[1],font:UIFont.systemFont(ofSize:12, weight:.regular),color:ColorUtils.gray_600())
            ])
            dLog(orderData.toJSON())
            
            cell.lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: orderData.total_amount)
        }else {//Phiếu chi
            let warehouseSessionData = viewModel.receiptPaymentDetail.value.supplier_warehouse_session_data[indexPath.row]
            cell.lbl_code.text = warehouseSessionData.code
            cell.lbl_date.attributedText = Utils.setMultipleFontAndColorForLabel(
                label: cell.lbl_date,
                attributes: [
                    (str:warehouseSessionData.created_at.components(separatedBy: " ")[0],font:UIFont.systemFont(ofSize:10, weight:.regular),color:ColorUtils.black()),
                    (str:warehouseSessionData.created_at.components(separatedBy: " ")[1],font:UIFont.systemFont(ofSize:12, weight:.regular),color:ColorUtils.gray_600())
            ])
            
            cell.lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: warehouseSessionData.total_amount)
        }
        
        
        return cell
    }

}







extension DetailedReceiptAndPaymentViewController:DialogConfirmDelegate,DialogRejectDelegate{

    func prensentDialogConfirm(content:String, dialogType:Int){
         let dialogConfirm = DialogConfirmViewController()
        dialogConfirm.view.backgroundColor = ColorUtils.blackTransparent()
        dialogConfirm.dialog_type = dialogType == 1 ? dialogConfirm.CONFIRM_DIALOG : dialogConfirm.REJECT_DIALOG
        dialogConfirm.dialogWidth = 300
        dialogConfirm.dialogHeight = 180
        dialogConfirm.dialogConfirmDelegate = self
        dialogConfirm.diaglogRejectDelegate = self
        dialogConfirm.dialog_title = dialogType == 1 ? "Xác nhận" : "Huỷ phiếu"
        dLog(content)
        dialogConfirm.dialog_content = content
        let nav = UINavigationController(rootViewController: dialogConfirm)
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
     
     func callBackToConfirm() {
         changeReceiptAndPaymentStatus(status: 2, reason: "")
     }
    func callBackToReject(reason: String) {
        changeReceiptAndPaymentStatus(status: 3, reason: reason)
    }
    
}
