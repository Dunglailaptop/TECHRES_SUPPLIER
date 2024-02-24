//
//  NotificationViewController+Extension+API.swift
//  TECHRES-SUPPLIER
//
//  Created by Kelvin on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

//MARK: CALL API
extension NotificationViewController {
    func notifications(){
        viewModel.notifications().subscribe(onNext: { (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<NotificationResponse>().map(JSONObject: response.data) {
                    self.totalRecord = dataFromServer.total_record
                    if(dataFromServer.list.count > 0){
                        var datas = self.viewModel.dataArray.value
                        datas.append(contentsOf: dataFromServer.list)
                        self.viewModel.dataArray.accept(datas)
                        self.viewModel.dataFilter.accept(datas)
                    }
                    self.spinner.stopAnimating()
                }
            }else{
                dLog(response.message ?? "")
            }

        }).disposed(by: rxbag)
    }

}
