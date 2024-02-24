//
//  DetailCompleteOrderViewController+Extension.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 24/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import RxSwift
import RxRelay
import JonAlert

extension DetailCompleteOrderViewController {
    func getDetailSupplierOrders(){
        viewModel.getDetailSupplierOrders().subscribe(onNext: { [self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<SupplierOrdersDetailResponse>().mapArray(JSONObject: response.data) {

                    viewModel.dataArray.accept(dataFromServer)
                    dLog(dataFromServer.toJSON())
                }
            }else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
}

//MARK: REGISTER CELL TABLE VIEW
extension DetailCompleteOrderViewController{
    
    func registerCell() {
        
        let detailCompleteOrderTableViewCell = UINib(nibName: "DetailCompleteOrderTableViewCell", bundle: .main)
        tableView.register(detailCompleteOrderTableViewCell, forCellReuseIdentifier: "DetailCompleteOrderTableViewCell")
        
        tableView.isScrollEnabled = false
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView
            .rx.setDelegate(self)
            .disposed(by: rxbag)
    }
    func bindTableView(){
            viewModel.dataArray.asObservable()
                .bind(to: tableView.rx.items) { (tableView, index, element) in
                    let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCompleteOrderTableViewCell") as! DetailCompleteOrderTableViewCell
                        cell.data = element
                    return cell
                }.disposed(by: rxbag)
    }
}

extension DetailCompleteOrderViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
