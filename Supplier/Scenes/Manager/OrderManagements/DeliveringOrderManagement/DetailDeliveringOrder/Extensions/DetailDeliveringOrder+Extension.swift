//
//  DetailDeliveringOrderViewController+Extension.swift
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

extension DetailDeliveringOrderViewController {
    func getDetailSupplierOrders(){
        viewModel.getDetailSupplierOrders().subscribe(onNext: { [self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<SupplierOrdersDetailResponse>().mapArray(JSONObject: response.data) {

                    viewModel.dataArray.accept(dataFromServer)
                    
                    var heightTableView: CGFloat = 0
                    dataFromServer.enumerated().forEach { (index, value) in
                        heightTableView += Utils.getHeightTextContentInView(textString: dataFromServer[index].supplier_material_name, maxWidth: self.view.safeAreaLayoutGuide.layoutFrame.width - CGFloat(242), theRest: 32, fontSize: 14, fontName: "Roboto-Regular")
                    }
                    height_table_view.constant = heightTableView
                    dLog(dataFromServer.toJSON())
                }
            }else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
}



//MARK: REGISTER CELL TABLE VIEW
extension DetailDeliveringOrderViewController{
    
    func registerCell() {
        
        let detailDeliveringOrderTableViewCell = UINib(nibName: "DetailDeliveringOrderTableViewCell", bundle: .main)
        tableView.register(detailDeliveringOrderTableViewCell, forCellReuseIdentifier: "DetailDeliveringOrderTableViewCell")
        
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
                    let cell = tableView.dequeueReusableCell(withIdentifier: "DetailDeliveringOrderTableViewCell") as! DetailDeliveringOrderTableViewCell
                        cell.data = element
                    return cell
                }.disposed(by: rxbag)
    }
}

extension DetailDeliveringOrderViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

