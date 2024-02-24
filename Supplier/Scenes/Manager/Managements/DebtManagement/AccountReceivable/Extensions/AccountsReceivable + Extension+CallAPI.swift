//
//  ReceiptBillDebtViewController+Extension.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import RxSwift
import RxRelay

//MARK: CALL API
extension AccountsReceivableViewController{
    
    func getListOfRestaurantWithReceipt(){
        viewModel.getListOfRestaurantWithReceipt().subscribe(onNext: { [self] (response) in
            dLog(response.toJSON())
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<ListOfRestaurantWithReceipt>().map(JSONObject: response.data) {
                    
                    totalRecord = dataFromServer.total_record
                    if(dataFromServer.data.count > 0){
                        var data = viewModel.dataArray.value
                        data.append(contentsOf: dataFromServer.data)
                        viewModel.dataArray.accept(data)
                    }
                    spinner.stopAnimating()
                    lbl_total_debt.text = String(viewModel.dataArray.value.count)
                    lbl_total_debt.text = Utils.stringVietnameseMoneyFormatWithNumberDouble(
                        amount: viewModel.dataArray.value.map{$0.total_amount}.reduce(0,+)
                    )
                    Utils.isHideAllView(isHide: viewModel.dataArray.value.count > 0 ? true: false , view: root_view_empty_data)
                }
            }else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
}

